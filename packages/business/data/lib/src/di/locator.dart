import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();
}
