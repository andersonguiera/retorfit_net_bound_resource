import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';

import 'package:injectable/injectable.dart';

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

    return users.toList().cast();
 }
}

class PackageOfCalls<T> {
  final int first;
  final int last;
  late final List<int> range;
  final Future<T> Function(int order) future;
  late final List<Future<T> Function()> calls;

  PackageOfCalls(this.first, this.last, this.future) {
    var length = last - first + 1;
    range = List.generate(length, (index) => index + first);
    calls = List.generate(length, (index) => () => future(range[index]));
  }

  Future<List<T>> call() async {
    print('$first-$last');
    return Future.wait(calls.map((e) => e.call()).toList());
  }
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

    packages = List.generate(totalPackages,
        (index) => PackageOfCalls<T>(firsts[index], lasts[index], (order) => future(order)));
  }

  Future<List<T>> calls() async {
    List<T> resultCalls = [];
    for (var package in packages) {
      resultCalls.addAll(await package.call());
    }
    return resultCalls;
  }
}
