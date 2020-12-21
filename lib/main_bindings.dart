/*
*  main_bindings.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:get/get.dart';
import 'package:tara_app/models/auth/auth_response.dart';

import 'controller/transaction_controller.dart';
class MainBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthResponse>(() => AuthResponse());
    Get.lazyPut(()=>TransactionController());
  }
}