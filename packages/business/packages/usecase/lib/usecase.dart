library usecase;

export 'src/user/use_cases_users_impl.dart'
    show
        GetAllUsersImp,
        FindUsersUseCaseImpl,
        GetUserByIdUseCaseImpl,
        GetUsersByPageUseCaseImpl;

import 'src/di/locator.dart' as locator;

class UseCase {
  static void config() {
    locator.configureDependencies();
  }
}
