import 'package:usecase/di/locator.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';
import 'package:test/test.dart';
import 'mock_user_repository.dart';

void main() {
  configureDependencies();
  //Must mock this repository because domain can not depends of data module
  getIt.registerSingleton<UserRepository>(MockUserRepository());

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
    final page = await usecase.findByEmail('@yandex.ru');

    expect(page.page, 1);
    expect(page.elements.length, 4);
  });
}
