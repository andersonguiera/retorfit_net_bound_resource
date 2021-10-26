import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';

import 'package:injectable/injectable.dart';
import 'package:usecase/src/di/locator.dart';

@Injectable(as: GetUserByIdUseCase)
class GetUserByIdUseCaseImpl implements GetUserByIdUseCase {
  GetUserByIdUseCaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<User> getUser(dynamic id) async {
    return _repository.getUser(id);
  }
}

@Injectable(as: GetUsersByPageUseCase)
class GetUsersByPageUseCaseImpl implements GetUsersByPageUseCase {
  GetUsersByPageUseCaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Paginated<User>> getUsers({int? page}) async {
    return await _repository.getUsers(page: page);
  }
}

@Injectable(as: FindUsersUseCase)
class FindUsersUseCaseImpl implements FindUsersUseCase {
  FindUsersUseCaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Paginated<User>> findByName(String name, {int page = 1}) async {
    return await _repository.findByName(name, page: page);
  }

  @override
  Future<Paginated<User>> findByEmail(String email, {int page = 1}) async {
    return await _repository.findByEmail(email, page: page);
  }
}

@Injectable(as: GetAllUsers)
class GetAllUsersImp implements GetAllUsers {
  GetAllUsersImp(this._repository);

  final UserRepository _repository;

  @override
  Future<List<User>> getAll() async {
    Set users = <User>{};

    final firstPage = await _repository.getUsers();

    users.addAll(firstPage.elements);

    var manager = CallsManager<Paginated<User>>(
        firstPage.page + 1,
        firstPage.pages,
        (page) async => await _repository.getUsers(page: page));

    manager.prepare();

    var results = await manager.calls();

    for (var result in results) {
      users.addAll(result.elements);
    }

    if (manager.isError) {
      int lastErrorCount;
      do {
        lastErrorCount = manager.countErrors;
        //if (manager.isError) {
        var results = await manager.calls();
        for (var result in results) {
          users.addAll(result.elements);
          //}
        }
      } while (manager.isError && manager.countErrors < lastErrorCount);
    }

    return users.toList().cast();
  }
}

@Injectable(as: CreateUserUseCase)
class CreateUserUseCaseImpl implements CreateUserUseCase {
  CreateUserUseCaseImpl(this._repository) {
    _findUsersUseCase = getIt<FindUsersUseCase>();
  }

  late final FindUsersUseCase _findUsersUseCase;
  final UserRepository _repository;

  @override
  Future<User> create(User user) async {
    var page = await _findUsersUseCase.findByEmail(user.email);

    if (_notFound(page)) {
      return await _repository.saveUser(user);
    }
    return User.empty;
  }

  bool _notFound(Paginated page) {
    return page.total == 0;
  }
}

enum StateCalls { idle, processing, finish, error }

class PackageOfCalls<T> {
  final int first;
  final int last;
  late final List<int> range;
  final Future<T> Function(int order) future;
  late List<Future<T> Function()> calls;
  StateCalls state = StateCalls.idle;

  PackageOfCalls(this.first, this.last, this.future) {
    var length = last - first + 1;
    range = List.generate(length, (index) => index + first);
    calls = List.generate(length, (index) => () => future(range[index]));
  }

  Future<List<T>> call() async {
    List<T> results = [];
    List<Future<T> Function()> successCalls = [];
    print('$first-$last');
    state = StateCalls.processing;
    await Future.wait(calls
            .map((e) => e.call().then((value) {
                  print('Success: ${(value as Paginated).page}');
                  results.add(value);
                  successCalls.add(e);
                }))
            .toList())
        .then((value) {
      state = StateCalls.finish;
    }).onError((error, stackTrace) {
      state = StateCalls.error;
    });

    for (var success in successCalls) {
      calls.remove(success);
    }

    return results;
  }

  bool get isFinish => state == StateCalls.finish;

  bool get isError => state == StateCalls.error;

  int get totalFinish => last - first + 1 - totalErrors;

  int get totalErrors => calls.length;
}

class CallsManager<T> {
  int first;
  int last;
  int threshold;
  final Future<T> Function(int order) future;
  late final List<PackageOfCalls<T>> packages;

  CallsManager(this.first, this.last, this.future, [this.threshold = 10]);

  void prepare() {
    int totalCalls = last - first + 1;
    int totalPackages =
        totalCalls ~/ threshold + (totalCalls % threshold > 0 ? 1 : 0);
    List<int> firsts =
        List.generate(totalPackages, (index) => index * threshold + first);
    List<int> lasts =
        List.generate(totalPackages, (index) => firsts[index] + threshold - 1);
    lasts[lasts.length - 1] =
        lasts[lasts.length - 1] > last ? last : lasts[lasts.length - 1];

    packages = List.generate(
        totalPackages,
        (index) => PackageOfCalls<T>(
            firsts[index], lasts[index], (order) => future(order)));
  }

  Future<List<T>> calls() async {
    List<T> results = [];
    await _callList(packages).then((value) => results = value);
    print(
        'Errors: ${packages.map((e) => e.totalErrors).reduce((value, element) => value + element)}');
    return results;
  }

  Future<List<T>> _callList(List<PackageOfCalls<T>> list) async {
    List<T> resultCalls = [];
    for (var package in list) {
      resultCalls.addAll(await package.call());
    }
    return resultCalls;
  }

  bool get isFinish => packages
      .map((e) => e.isFinish)
      .reduce((value, element) => value && element);

  bool get isError => packages
      .map((e) => e.isError)
      .reduce((value, element) => value || element);

  int get countErrors => packages
      .map((e) => e.totalErrors)
      .reduce((value, element) => value + element);

  int get countSuccess => packages
      .map((e) => e.totalFinish)
      .reduce((value, element) => value + element);
}

//Outra abordagem

abstract class UserUseCasesWithUserRepo {
  UserUseCasesWithUserRepo(this._repository);

  final UserRepository _repository;
}

//OK
@Injectable(as: FindUserById2)
class FindUserByIdImpl2 extends UserUseCasesWithUserRepo
    implements FindUserById2 {
  FindUserByIdImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<User>> perform(request) async {
    var user = await _repository.getUser(request);
    return UseCaseResponse<User>(user);
  }
}

//OK
@Injectable(as: FindUserByNameUserParam2)
class FindUserByNameUseCaseImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByNameUserParam2 {
  FindUserByNameUseCaseImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(
      UseCaseRequest<User> request) async {
    var paginateUser = await _repository.findByName(request.param.name);

    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

//ok
@Injectable(as: FindUserByNameStringParam2)
class FindUserByNameStringParamImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByNameStringParam2 {
  FindUserByNameStringParamImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(String request) async {
    var paginateUser = await _repository.findByName(request);
    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

//OK
@Injectable(as: FindUserByNamePageRequestParam2)
class FindUserByNamePageRequestParam2Impl extends UserUseCasesWithUserRepo
    implements FindUserByNamePageRequestParam2 {
  FindUserByNamePageRequestParam2Impl(UserRepository repository)
      : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(
      PaginatedUseCaseRequest<String> request) async {
    var paginateUser =
    await _repository.findByName(request.param, page: request.page);
    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

//OK
@Injectable(as: FindUserByEmailUserParam2)
class FindUserByEmailUserParamImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByEmailUserParam2 {
  FindUserByEmailUserParamImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(
      UseCaseRequest<User> request) async {
    var paginateUser = await _repository.findByEmail(request.param.email);

    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

//ok
@Injectable(as: FindUserByEmailStringParam2)
class FindUserByEmailStringParamImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByEmailStringParam2 {
  FindUserByEmailStringParamImpl2(UserRepository repository)
      : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(String request) async {
    var paginateUser = await _repository.findByEmail(request);
    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

//ok
@Injectable(as: FindUserByEmailPageRequestParam2)
class FindUserByEmailPageRequestParam2Impl extends UserUseCasesWithUserRepo
    implements FindUserByEmailPageRequestParam2 {
  FindUserByEmailPageRequestParam2Impl(UserRepository repository)
      : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(
      PaginatedUseCaseRequest<String> request) async {
    var paginateUser =
        await _repository.findByEmail(request.param, page: request.page);
    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

@Injectable(as: CreateUserUseCase2)
class CreateUserUseCaseImpl2 extends UserUseCasesWithUserRepo implements CreateUserUseCase2{
  CreateUserUseCaseImpl2(UserRepository repository) : super(repository);

  final FindUserByEmailStringParam2 _findUsersUseCase = getIt<FindUserByEmailStringParam2>();

  @override
  Future<UseCaseResponse<User>> perform(User request) async {
    var response = await _findUsersUseCase.perform(request.email);

    if (_notFound(response.payload)) {
      var newUser =  await _repository.saveUser(request);
      return UseCaseResponse(newUser);
    }
    return UseCaseResponse(User.empty);
  }

  bool _notFound(Paginated page) {
    return page.total == 0;
  }
}

@Injectable(as: GetAllUsers2)
class GetAllUsers2Impl extends UserUseCasesWithUserRepo implements GetAllUsers2 {
  GetAllUsers2Impl(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<List<User>>> perform() async {
    Set users = <User>{};

    final firstPage = await _repository.getUsers();

    users.addAll(firstPage.elements);

    var manager = CallsManager<Paginated<User>>(
        firstPage.page + 1,
        firstPage.pages,
            (page) async => await _repository.getUsers(page: page));

    manager.prepare();

    var results = await manager.calls();

    for (var result in results) {
      users.addAll(result.elements);
    }

    if (manager.isError) {
      int lastErrorCount;
      do {
        lastErrorCount = manager.countErrors;
        //if (manager.isError) {
        var results = await manager.calls();
        for (var result in results) {
          users.addAll(result.elements);
          //}
        }
      } while (manager.isError && manager.countErrors < lastErrorCount);
    }

    return UseCaseResponse(users.toList().cast());
  }

}