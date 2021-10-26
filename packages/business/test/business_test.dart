import 'package:business/business.dart';
import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';
import 'package:test/test.dart';
import 'package:business/src/di/locator.dart';

void main() {
  Business.config();

  test(
      'GetAllUsersImpl - getAll - If any exception is trowed, see de difference'
      ' between users.length and firstPage.total. It can'
      't be so far from expected.', () async {
    final GetAllUsers usecase = getIt<GetAllUsers>();
    final GetUsersByPage control = getIt<GetUsersByPage>();
    var controlResponse = await control.perform(1);
    var firstPage = controlResponse.payload;
    var stopwatch = Stopwatch()..start();
    var response = await usecase.perform();
    final users = response.payload;
    print('Time elapsed: ${stopwatch.elapsed}\nRegs:${firstPage.total}');

    expect(users.length, firstPage.total);
  }, timeout: const Timeout(Duration(minutes: 5)));

  test(
      'CreateUserUseCase - Try to create user with existent email', () async {
    final CreateUserUseCase usecase = getIt<CreateUserUseCase>();
    const user = User(null, 'First', 'ppp4444@pp.itz', 'male', 'active');
    final newUser = await usecase.perform(user);

    expect(newUser.payload, User.empty);
  }, timeout: const Timeout(Duration(minutes: 5)));
}
