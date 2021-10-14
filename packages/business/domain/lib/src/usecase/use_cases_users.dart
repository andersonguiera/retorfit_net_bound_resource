import 'package:domain/domain.dart';

abstract class GetUserByIdUseCase {
  Future<User> getUser(dynamic id);
}

abstract class GetUsersByPageUseCase {
  Future<Paginated<User>> getUsers(int page);
}
