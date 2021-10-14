import 'package:domain/src/di/locator.dart';
import 'package:domain/src/usecase/use_cases_users.dart';
import 'package:test/test.dart';
import 'package:domain/domain.dart';
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
    final page = await usecase.getUsers(pageNumber);

    expect(page.page, pageNumber);
    expect(page.size, page.elements.length);
  });
}
