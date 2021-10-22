import 'package:business/business.dart';
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
    final GetUsersByPageUseCase control = getIt<GetUsersByPageUseCase>();
    final firstPage = await control.getUsers();
    var stopwatch = Stopwatch()..start();
    final users = await usecase.getAll();
    print('Time elapsed: ${stopwatch.elapsed}\nRegs:${firstPage.total}');

    expect(users.length, firstPage.total);
  });
}
