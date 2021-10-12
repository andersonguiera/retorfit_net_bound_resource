import 'package:data/src/di/locator.dart';
import 'package:data/src/exceptions/exceptions.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';


void main() {
  configureDependencies();

  test('Try to find a user which doesn\'t exist - NotFoundException', () async {
    final UserRepository repository = getIt<UserRepository>();

    expect(() async => await repository.getUser(-178),
        throwsA(const TypeMatcher<NotFoundException>()));
  });

  test('Try to find a user which id is a string - NotFoundException', () async {
    final UserRepository repository = getIt<UserRepository>();

    expect(() async => await repository.getUser('a'),
        throwsA(const TypeMatcher<NotFoundException>()));
  });

  test('Test CRUD User', () async {
    final UserRepository repository = getIt<UserRepository>();

    const user = User(
      null,
      'Aleksei Maksimovich Peshkov',
      'gorki@yandex.ru',
      'male',
      'active',
    );

    var newUser = await repository.saveUser(user);

    expect(user.name, newUser.name);
    expect(user.email, newUser.email);
    expect(user.gender, newUser.gender);
    expect(user.status, newUser.status);

    print('id: ${newUser.id}');

    var transientUser = newUser.copyWith(status: 'inactive');
    var updatedUser = await repository.saveUser(transientUser);

    expect(newUser.id, updatedUser.id);
    expect(newUser.name, updatedUser.name);
    expect(newUser.email, updatedUser.email);
    expect(newUser.gender, updatedUser.gender);
    expect('inactive', updatedUser.status);

    var toDelete = await repository.getUser(newUser.id);

    print('ToDeleteId: ${toDelete.id}');
    expect(() async => await repository.deleteUser(toDelete.id), returnsNormally);
  });

  test('Test a list of User', () async {
    final UserRepository repository = getIt<UserRepository>();
    final users = await repository.getUsers();

    expect(users.length, 20);
  });
}
