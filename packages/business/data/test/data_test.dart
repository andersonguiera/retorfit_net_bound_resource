import 'package:data/src/di/locator.dart';
import 'package:data/src/exception/exceptions.dart';
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
    expect(
        () async => await repository.deleteUser(toDelete.id), returnsNormally);
  });

  test('Test a list of User', () async {
    final UserRepository repository = getIt<UserRepository>();
    final page = await repository.getUsers();

    expect(page.elements.length, 20);
  });

  test('Test a list of Users with name Roman', () async {
    final UserRepository repository = getIt<UserRepository>();

    const user1 = User(
      null,
      'Roman 1',
      'Roman_1@yandex.ru',
      'male',
      'active',
    );

    const user2 = User(
      null,
      'Roman 2',
      'Roman_2@yandex.ru',
      'male',
      'active',
    );

    final users = await Future.wait(
        [repository.saveUser(user1), repository.saveUser(user2)]);

    for (var element in users) {
      print(element.id);
    }

    final page = await repository.findByName('Roman');

    final deleteList = users.map((e) => repository.deleteUser(e.id)).toList();
    await Future.wait(deleteList);

    expect(page.elements.length, greaterThanOrEqualTo(users.length));
  });

  test('Test a list of Users with email @yandex.ru', () async {
    final UserRepository repository = getIt<UserRepository>();

    const user1 = User(
      null,
      'Roman 1',
      'Roman_1@yandex.ru',
      'male',
      'active',
    );

    const user2 = User(
      null,
      'Roman 2',
      'Roman_2@yandex.ru',
      'male',
      'active',
    );

    final users = await Future.wait(
        [repository.saveUser(user1), repository.saveUser(user2)]);

    for (var element in users) {
      print(element.id);
    }

    final page = await repository.findByEmail('Roman');

    final deleteList = users.map((e) => repository.deleteUser(e.id)).toList();
    await Future.wait(deleteList);

    expect(page.elements.length, greaterThanOrEqualTo(users.length));
  });

  // test('Just delete orphan users', () async {
  //   final UserRepository repository = getIt<UserRepository>();
  //
  //   await Future.wait([
  //     repository.deleteUser(2601),
  //     repository.deleteUser(2602),
  //   ]);
  // });

  test('Just to see exceptions return', () async {
    final UserRepository repository = getIt<UserRepository>();

    try{
      await repository.getUser(-178);
    } on NotFoundException catch (e, stackTrace) {
      print('fancy: ${e.fancyMessage}');
      print('complete: ${e.completeMessage}');
      print('e.StackTrace: ${e.stackTrace}');
      print('stackTrace: ${stackTrace}');
      expect(() => throw e,
          throwsA(const TypeMatcher<NotFoundException>()));
    }
  });
}
