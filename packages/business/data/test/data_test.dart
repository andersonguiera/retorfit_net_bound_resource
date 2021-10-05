import 'package:domain/domain.dart';
import 'package:test/test.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';

void main() {
  test('Test a list of User', () async {
    final UserRepository repository =
    UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));
    final users = await repository.getUsers();

    expect(users.length, 10);
  });

  test('Test one User', () async {
    final UserRepository repository =
    UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));
    final users = await repository.getUser(1);

    expect(users.name, 'Leanne Graham');
  });
}
