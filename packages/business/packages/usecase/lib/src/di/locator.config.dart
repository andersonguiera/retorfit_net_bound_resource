// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:domain/domain.dart' as _i5;
import 'package:domain/usecase.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../user/use_cases_users_impl.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.CreateUserUseCase>(
      () => _i4.CreateUserUseCaseImpl2(get<_i5.UserRepository>()));
  gh.factory<_i3.FindUserByEmailPageRequestParam>(() =>
      _i4.FindUserByEmailPageRequestParam2Impl(get<_i5.UserRepository>()));
  gh.factory<_i3.FindUserByEmailStringParam>(
      () => _i4.FindUserByEmailStringParamImpl2(get<_i5.UserRepository>()));
  gh.factory<_i3.FindUserByEmailUserParam>(
      () => _i4.FindUserByEmailUserParamImpl2(get<_i5.UserRepository>()));
  gh.factory<_i3.FindUserByNamePageRequestParam>(
      () => _i4.FindUserByNamePageRequestParam2Impl(get<_i5.UserRepository>()));
  gh.factory<_i3.FindUserByNameStringParam>(
      () => _i4.FindUserByNameStringParamImpl2(get<_i5.UserRepository>()));
  gh.factory<_i3.FindUserByNameUserParam>(
      () => _i4.FindUserByNameUseCaseImpl2(get<_i5.UserRepository>()));
  gh.factory<_i3.GetAllUsers>(
      () => _i4.GetAllUsers2Impl(get<_i5.UserRepository>()));
  gh.factory<_i3.GetUserById>(
      () => _i4.FindUserByIdImpl2(get<_i5.UserRepository>()));
  gh.factory<_i3.GetUsersByPage>(
      () => _i4.GetUsersByPageImpl(get<_i5.UserRepository>()));
  return get;
}
