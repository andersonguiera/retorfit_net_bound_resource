library data;

export 'src/repository/user_repository_remote_impl.dart'
    show UserRepositoryRemoteImpl;

import 'src/di/locator.dart' as locator;
class Data {
  static void config() {
    locator.configureDependencies();
  }
}