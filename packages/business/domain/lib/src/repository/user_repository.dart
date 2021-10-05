import 'package:domain/src/model/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUser(dynamic id);
}