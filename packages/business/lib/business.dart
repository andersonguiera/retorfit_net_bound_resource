library business;

import 'package:data/data.dart';
import 'package:usecase/usecase.dart';
import 'src/di/locator.dart' as locator;
class Business {
  static void config() {
    Data.config();
    UseCase.config();
    locator.configureDependencies();
  }
}
