import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<Paginated<User>> getUsers({int? page});
  Future<User> getUser(dynamic id);
  Future<User> saveUser(User user);
  Future<void> deleteUser(dynamic id);

}