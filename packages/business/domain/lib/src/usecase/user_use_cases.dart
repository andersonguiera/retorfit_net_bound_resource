import 'package:domain/domain.dart';
import 'common.dart';

abstract class GetUserByIdUseCase {
  Future<User> getUser(dynamic id);
}

abstract class GetUsersByPageUseCase {
  Future<Paginated<User>> getUsers({int? page});
}

abstract class FindUsersUseCase
    implements FindByNameUseCase<User>, FindByEmailUseCase<User> {}
