// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:domain/domain.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../datasource/remote/user_repository_remote_service.dart' as _i4;
import '../repository/user_repository_remote_impl.dart' as _i6;
import 'locator.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.Dio>(registerModule.dio);
  gh.factoryParam<_i4.UserRepositoryRemoteServices, String?, dynamic>(
      (baseUrl, _) =>
          _i4.UserRepositoryRemoteServices(get<_i3.Dio>(), baseUrl: baseUrl));
  gh.factory<_i5.UserRepository>(() =>
      _i6.UserRepositoryRemoteImpl(get<_i4.UserRepositoryRemoteServices>()));
  return get;
}

class _$RegisterModule extends _i7.RegisterModule {}
