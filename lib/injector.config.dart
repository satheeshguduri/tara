// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services/dio_client.dart';
import 'repositories/auth_repository.dart';
import 'repositories/auth_repository_impl.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

extension GetItInjectableX on GetIt {
  GetIt init({
    String environment,
    EnvironmentFilter environmentFilter,
  }) {
    final gh = GetItHelper(this, environment, environmentFilter);
    gh.factory<AuthRepository>(() => AuthRepositoryImpl());

    // Eager singletons must be registered in the right order
    gh.singleton<APIHelper>(APIHelper());
    return this;
  }
}
