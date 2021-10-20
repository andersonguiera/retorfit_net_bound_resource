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