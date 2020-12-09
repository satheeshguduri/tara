/*
*  injector.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/auth_repository_impl.dart';
import 'package:tara_app/services/dio_client.dart';
import 'package:tara_app/services/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';

var getIt = GetIt.I;
Future<void> init() async{
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton<RestClient>(() => APIHelper(getIt()).getDioClient());
  getIt.registerLazySingleton(() => DataConnectionChecker());
}