import 'package:usecase/src/di/locator.dart';
import 'package:usecase/usecase.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';
import 'package:test/test.dart';
import 'mock_user_repository.dart';

void main() {
  UseCase.config();
  //Must mock this repository because domain can not depends of data module
  getIt
      .registerSingleton<UserRepository>(MockUserRepository.fromUsersList(200));

  test(
      'FindUserByNameUserParam - find User By name using an User as param', () async {
    final FindUserByNameUserParam usecase = getIt<FindUserByNameUserParam>();
    final response = await usecase
        .perform(UseCaseRequest<User>(const User('', 'Tolstoi', '', '', '')));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 2);
  });

  test(
      'FindUserByNameStringParam - find User By name using String as param', () async {
    final FindUserByNameStringParam usecase = getIt<
        FindUserByNameStringParam>();
    final response = await usecase
        .perform('Tolstoi');

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 2);
  });

  test(
      'FindUserByNamePageRequestParam - find User By name using String as key and page number as param', () async {
    final FindUserByNamePageRequestParam usecase = getIt<
        FindUserByNamePageRequestParam>();
    final response = await usecase.perform(
        PaginatedUseCaseRequest<String>(1, 'Tolstoi'));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 2);
  });

  test(
      'FindUserByEmailUserParam - find User By email using User as param', () async {
    final FindUserByEmailUserParam usecase = getIt<FindUserByEmailUserParam>();
    final response = await usecase
        .perform(UseCaseRequest<User>(const User('', '', '@xpto.com.br', '', '')));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 4);
  });

  test(
      'FindUserByEmailStringParam - find User By email using String as param', () async {
    final FindUserByEmailStringParam usecase = getIt<FindUserByEmailStringParam>();
    final response = await usecase
        .perform('@xpto.com.br');

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 4);
  });

  test(
      'FindUserByEmailPageRequestParam - find User By email using String as key and page number as param', () async {
    final FindUserByEmailPageRequestParam usecase = getIt<
        FindUserByEmailPageRequestParam>();
    final response = await usecase.perform(
        PaginatedUseCaseRequest<String>(1, '@xpto.com.br'));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 4);
  });

  test('CreateUserUseCase - Try to create user with existent email', () async {
    final CreateUserUseCase usecase = getIt<CreateUserUseCase>();
    const user =
    User(null, 'First', 'gorky@xpto.com.br', 'male', 'active');
    final response = await usecase.perform(user);

    expect(response.payload, User.empty);
  });

  test('CreateUserUseCase - Try to create a new user', () async {
    final CreateUserUseCase usecase = getIt<CreateUserUseCase>();
    const user =
    User(null, 'A New User', 'new_user@xpto.com.br', 'male', 'active');
    final response = await usecase.perform(user);
    var newUser = response.payload;

    print('new id: ${newUser.id}');

    expect(newUser.id, isPositive);
    expect(newUser.name, user.name);
    expect(newUser.email, user.email);
    expect(newUser.status, user.status);
    expect(newUser.gender, user.gender);
  });

  test('GetUserById - Get an user using id as key', () async {
    final GetUserById usecase = getIt<GetUserById>();
    var response = await usecase.perform(1);

    expect(response.payload.name, 'Maxim Gorky');
  });

  test('GetAllUsers - get all users of database', () async {
    final GetAllUsers usecase = getIt<GetAllUsers>();
    final response = await usecase.perform();
    final users = response.payload;

    users.forEach((element) => print('${element.id}:${element.name}'));

    expect(users.length, 200);
  });

  test('GetUsersByPage - Get a page of users', () async {
    final GetUsersByPage usecase = getIt<GetUsersByPage>();
    final response = await usecase.perform(2);
    final page = response.payload;

    expect(page.page, 2);
    expect(page.elements.first.id, 21);
    expect(page.size, 20);
  });

}
