import 'package:usecase/src/di/locator.dart';
import 'package:usecase/usecase.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';
import 'package:test/test.dart';
import 'mock_user_repository.dart';
import 'package:logger/logger.dart';

void main() {
  UseCase.config();
  //configureDependencies();
  //Must mock this repository because domain can not depends of data module
  getIt.registerSingleton<UserRepository>(MockUserRepository.fromUsersList(200));
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

  // test('PackageOfCalls', () async {
  //   final PackageOfCalls packageOfCalls = PackageOfCalls(2, 11);
  //
  //   print(packageOfCalls.range);
  //   expect(packageOfCalls.range, equals([2,3,4,5,6,7,8,9,10,11]));
  //   //expect(page.elements.length, 4);
  // });
}
