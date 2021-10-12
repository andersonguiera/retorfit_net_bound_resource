import 'package:domain/src/model/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({int? page});
  Future<User> getUser(dynamic id);
  Future<User> saveUser(User user);
  Future<void> deleteUser(dynamic id);

}