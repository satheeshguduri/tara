/*
*  injector.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/controller/create_store_and_owner_controller.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/auth_repository_impl.dart';
import 'package:tara_app/repositories/bill_repository.dart';
import 'package:tara_app/repositories/chat_repository.dart';
import 'package:tara_app/repositories/chat_repository_impl.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/repositories/order_repository_impl.dart';
import 'package:tara_app/repositories/store_repository_impl.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/services/rest/biller_rest_client.dart';
import 'package:tara_app/services/dio_client.dart';
import 'package:tara_app/services/firebase/firebase_remote_service.dart';
import 'package:tara_app/services/rest/order_rest_client.dart';
import 'package:tara_app/services/rest/rest_client.dart';
import 'package:tara_app/services/rest/transaction_rest_client.dart';
import 'package:tara_app/services/rest/psp_rest_client.dart';
import 'package:tara_app/services/rest/umps_core_rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';

import 'models/order_management/store/store_type_model.dart';

var getIt = GetIt.I;
Future<void> init() async{
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton<RestClient>(() => APIHelper().getDioClient());
  getIt.registerLazySingleton<OrderRestClient>(() => APIHelper().getDioOrderClient());
  getIt.registerLazySingleton<TransactionRestClient>(() => APIHelper().getDioTransactionClient());
  getIt.registerLazySingleton<BillerRestClient>(() => APIHelper().getDioBillerClient());
  final pspRestClient = await APIHelper().getSecurePSPRestClient();
  getIt.registerLazySingleton<PSPRestClient>(() => pspRestClient);
  final umpsCoreRestClient = await APIHelper().getSecureUMPSCoreRestClient();
  getIt.registerLazySingleton<UMPSCoreRestClient>(() => umpsCoreRestClient);
  getIt.registerLazySingleton(() => DataConnectionChecker());
  await GetStorage.init();
  getIt.registerLazySingleton<GetStorage>(() => GetStorage());
  await FirebaseDatabase.instance.setPersistenceEnabled(true);
  await FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
  getIt.registerLazySingleton<DatabaseReference>(() => FirebaseDatabase.instance.reference());
  getIt.registerLazySingleton<FirebaseRemoteService>(() => FirebaseRemoteService(getIt()));
  getIt.registerLazySingleton<UserLocalDataStore>(() => UserLocalDataStoreImpl(getIt()));
  Get.put(AuthController());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(),getIt(),getIt()));
  getIt.registerLazySingleton<StoresRepository>(() => StoreRepositoryImpl(getIt(),getIt(),getIt()));
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(getIt(),getIt(),getIt()));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt(),getIt()));
  getIt.registerLazySingleton<TransactionRepository>(() => TransactionRepositoryImpl(getIt(),getIt(),getIt()));
  getIt.registerLazySingleton<BillRepository>(() => BillRepositoryImpl(getIt(),getIt(),getIt()));
  Get.lazyPut(()=>CreateStoreAndOwnerController());
  Get.put(OrderController());
  Get.put(BillController());
  Get.lazyPut(()=>StoreTypeResponse());

}