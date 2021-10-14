import 'package:domain/domain.dart';
import 'package:domain/src/model/user.dart';
import 'package:domain/src/usecase/use_cases_users.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: GetUserByIdUseCase)
class GetUserByIdUseCaseImpl implements GetUserByIdUseCase {

  GetUserByIdUseCaseImpl(this.repository);

  final UserRepository repository;

  @override
  Future<User> getUser(dynamic id) async {
    return repository.getUser(id);
  }
}

@Injectable(as: GetUsersByPageUseCase)
class GetUsersByPageUseCaseImpl implements GetUsersByPageUseCase {

  GetUsersByPageUseCaseImpl(this.repository);

  final UserRepository repository;

  //TODO: Transformar o parâmetro em opcional
  @override
  Future<Paginated<User>> getUsers(int page) async {
    return await repository.getUsers(page: page);
  }
}