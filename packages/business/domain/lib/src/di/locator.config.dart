// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../domain.dart' as _i5;
import '../usecase/use_cases_users.dart' as _i3;
import '../usecase/use_cases_users_impl.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.GetUserByIdUseCase>(
      () => _i4.GetUserByIdUseCaseImpl(get<_i5.UserRepository>()));
  gh.factory<_i3.GetUsersByPageUseCase>(
      () => _i4.GetUsersByPageUseCaseImpl(get<_i5.UserRepository>()));
  return get;
}
