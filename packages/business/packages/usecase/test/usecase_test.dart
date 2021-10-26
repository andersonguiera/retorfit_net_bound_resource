import 'package:usecase/src/di/locator.dart';
import 'package:usecase/usecase.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';
import 'package:test/test.dart';
import 'mock_user_repository.dart';
import 'package:logger/logger.dart';

void main() {
  UseCase.config();
  //Must mock this repository because domain can not depends of data module
  getIt
      .registerSingleton<UserRepository>(MockUserRepository.fromUsersList(200));
  var logger = Logger();

  test('GetUserByIdUseCase', () async {
    final GetUserByIdUseCase usecase = getIt<GetUserByIdUseCase>();
    final user = await usecase.getUser(1);

    expect(user.name, 'Maxim Gorky');
  });

  test('GetUsersByPageUseCase', () async {
    final GetUsersByPageUseCase usecase = getIt<GetUsersByPageUseCase>();
    int pageNumber = 5;
    final page = await usecase.getUsers(page: pageNumber);

    expect(page.page, pageNumber);
    expect(page.size, page.elements.length);
  });

  test('FindUsersUseCase - find By name', () async {
    final FindUsersUseCase usecase = getIt<FindUsersUseCase>();
    final page = await usecase.findByName('Tolstoi');

    expect(page.page, 1);
    expect(page.elements.length, 2);
  });

  test('FindUsersUseCase - find By email', () async {
    final FindUsersUseCase usecase = getIt<FindUsersUseCase>();
    final page = await usecase.findByEmail('@xpto.com.br');

    expect(page.page, 1);
    expect(page.elements.length, 4);
  });

  test('GetAllUsersImpl - getAll', () async {
    final GetAllUsers usecase = getIt<GetAllUsers>();
    final users = await usecase.getAll();

    users.forEach((element) => print('${element.id}:${element.name}'));

    expect(users.length, 200);
    //expect(page.elements.length, 4);
  });

  test('CreateUserUseCase - Try to create user with existent email', () async {
    final CreateUserUseCase usecase = getIt<CreateUserUseCase>();
    const user =
    User(null, 'First', 'gorky@xpto.com.br', 'male', 'active');
    final newUser = await usecase.create(user);

    expect(newUser, User.empty);
  });

  test('CreateUserUseCase - Try to create a new user', () async {
    final CreateUserUseCase usecase = getIt<CreateUserUseCase>();
    const user =
    User(null, 'A New User', 'new_user@xpto.com.br', 'male', 'active');
    final newUser = await usecase.create(user);

    print('new id: ${newUser.id}');

    expect(newUser.id, isPositive);
    expect(newUser.name, user.name);
    expect(newUser.email, user.email);
    expect(newUser.status, user.status);
    expect(newUser.gender, user.gender);
  });

  test(
      'FindUserByNameUserParam2 - find User By name using User param', () async {
    final FindUserByNameUserParam2 usecase = getIt<FindUserByNameUserParam2>();
    final response = await usecase
        .perform(UseCaseRequest<User>(const User('', 'Tolstoi', '', '', '')));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 2);
  });

  test(
      'FindUserByNameStringParam2 - find User By name using String as param', () async {
    final FindUserByNameStringParam2 usecase = getIt<
        FindUserByNameStringParam2>();
    final response = await usecase
        .perform('Tolstoi');

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 2);
  });

  test(
      'FindUserByNamePageRequestParam2 - find User By name using String as param', () async {
    final FindUserByNamePageRequestParam2 usecase = getIt<
        FindUserByNamePageRequestParam2>();
    final response = await usecase.perform(
        PaginatedUseCaseRequest<String>(1, 'Tolstoi'));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 2);
  });

  test(
      'FindUserByEmailUserParam2 - find User By email using User as param', () async {
    final FindUserByEmailUserParam2 usecase = getIt<FindUserByEmailUserParam2>();
    final response = await usecase
        .perform(UseCaseRequest<User>(const User('', '', '@xpto.com.br', '', '')));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 4);
  });

  test(
      'FindUserByEmailStringParam2 - find User By email using String as param', () async {
    final FindUserByEmailStringParam2 usecase = getIt<FindUserByEmailStringParam2>();
    final response = await usecase
        .perform('@xpto.com.br');

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 4);
  });

  test(
      'FindUserByEmailPageRequestParam2 - find User By email using String as param', () async {
    final FindUserByEmailPageRequestParam2 usecase = getIt<
        FindUserByEmailPageRequestParam2>();
    final response = await usecase.perform(
        PaginatedUseCaseRequest<String>(1, '@xpto.com.br'));

    expect(response.payload.page, 1);
    expect(response.payload.elements.length, 4);
  });

  test('CreateUserUseCase2 - Try to create user with existent email', () async {
    final CreateUserUseCase2 usecase = getIt<CreateUserUseCase2>();
    const user =
    User(null, 'First', 'gorky@xpto.com.br', 'male', 'active');
    final response = await usecase.perform(user);

    expect(response.payload, User.empty);
  });

  test('CreateUserUseCase2 - Try to create a new user', () async {
    final CreateUserUseCase2 usecase = getIt<CreateUserUseCase2>();
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

  test('FindUserById2Impl', () async {
    final FindUserById2 usecase = getIt<FindUserById2>();
    var response = await usecase.perform(1);

    expect(response.payload.name, 'Maxim Gorky');
  });

  test('GetAllUsers2Impl - getAll', () async {
    final GetAllUsers2 usecase = getIt<GetAllUsers2>();
    void request; //TODO: Too Ugly
    final response = await usecase.perform();
    final users = response.payload;

    users.forEach((element) => print('${element.id}:${element.name}'));

    expect(users.length, 200);
    //expect(page.elements.length, 4);
  });

  // test('PackageOfCalls', () async {
  //   final PackageOfCalls packageOfCalls = PackageOfCalls(2, 11);
  //
  //   print(packageOfCalls.range);
  //   expect(packageOfCalls.range, equals([2,3,4,5,6,7,8,9,10,11]));
  //   //expect(page.elements.length, 4);
  // });
}
