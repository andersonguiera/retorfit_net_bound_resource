import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<Paginated<User>> getUsers({int? page});
  Future<User> getUser(dynamic id);
  Future<User> saveUser(User user);
  Future<void> deleteUser(dynamic id);

  Future<Paginated<User>> findByName(String name, {int page = 1});
  Future<Paginated<User>> findByEmail(String email, {int page = 1});
}