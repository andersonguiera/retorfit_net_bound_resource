import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';

import 'package:injectable/injectable.dart';
import 'package:usecase/src/di/locator.dart';
import './call_manager.dart';

abstract class UserUseCasesWithUserRepo {
  UserUseCasesWithUserRepo(this._repository);

  final UserRepository _repository;
}

@Injectable(as: GetUserById)
class FindUserByIdImpl2 extends UserUseCasesWithUserRepo
    implements GetUserById {
  FindUserByIdImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<User>> perform(request) async {
    var user = await _repository.getUser(request);
    return UseCaseResponse<User>(user);
  }
}

@Injectable(as: FindUserByNameUserParam)
class FindUserByNameUseCaseImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByNameUserParam {
  FindUserByNameUseCaseImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(
      UseCaseRequest<User> request) async {
    var paginateUser = await _repository.findByName(request.param.name);

    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

@Injectable(as: FindUserByNameStringParam)
class FindUserByNameStringParamImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByNameStringParam {
  FindUserByNameStringParamImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(String request) async {
    var paginateUser = await _repository.findByName(request);
    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

@Injectable(as: FindUserByNamePageRequestParam)
class FindUserByNamePageRequestParam2Impl extends UserUseCasesWithUserRepo
    implements FindUserByNamePageRequestParam {
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

@Injectable(as: FindUserByEmailUserParam)
class FindUserByEmailUserParamImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByEmailUserParam {
  FindUserByEmailUserParamImpl2(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(
      UseCaseRequest<User> request) async {
    var paginateUser = await _repository.findByEmail(request.param.email);

    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

@Injectable(as: FindUserByEmailStringParam)
class FindUserByEmailStringParamImpl2 extends UserUseCasesWithUserRepo
    implements FindUserByEmailStringParam {
  FindUserByEmailStringParamImpl2(UserRepository repository)
      : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(String request) async {
    var paginateUser = await _repository.findByEmail(request);
    return UseCaseResponse<Paginated<User>>(paginateUser);
  }
}

@Injectable(as: FindUserByEmailPageRequestParam)
class FindUserByEmailPageRequestParam2Impl extends UserUseCasesWithUserRepo
    implements FindUserByEmailPageRequestParam {
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

@Injectable(as: CreateUserUseCase)
class CreateUserUseCaseImpl2 extends UserUseCasesWithUserRepo implements CreateUserUseCase{
  CreateUserUseCaseImpl2(UserRepository repository) : super(repository);

  final FindUserByEmailStringParam _findUsersUseCase = getIt<FindUserByEmailStringParam>();

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

@Injectable(as: GetAllUsers)
class GetAllUsers2Impl extends UserUseCasesWithUserRepo implements GetAllUsers {
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

@Injectable(as: GetUsersByPage)
class GetUsersByPageImpl extends UserUseCasesWithUserRepo implements GetUsersByPage {
  GetUsersByPageImpl(UserRepository repository) : super(repository);

  @override
  Future<UseCaseResponse<Paginated<User>>> perform(int page) async {
    var responsePage = await _repository.getUsers(page: page);
    return UseCaseResponse(responsePage);
  }

}