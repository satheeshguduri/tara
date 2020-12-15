/*
*  auth_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';

class CreateStoreAndOwnerController extends GetxController {
  ///listen for the progress bar changes
  var showProgress = false.obs;
  var merchantId = "".obs;
  var ownerName = "".obs;
  var storeName = "".obs;
  var ownerAddress = "".obs;
  var storeAddress = "".obs;
  var isEnterTheFieldsInCreateOwner = false.obs;
  var isEnterTheFieldsInCreateStore = false.obs;
  var errorMessage = "".obs;
  var addressStr =
      "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …".obs;
  var token = "".obs;
  var isCreateOwnerResponseSuccess = false.obs;

  TextEditingController ownerNameTextController = TextEditingController();
  TextEditingController storeNameTextController = TextEditingController();
  AuthResponse user = Get.find();
  ///on clicking on send otp
  void createOwner() async {
    //validate empty state here for the text fields
    if (isValidationSuccessInCreateOwner()) {
      showProgress.value = true;
      Owner request = Owner(name: ownerNameTextController.text,integrationId: user.customerProfile.id);
      print(request.toJson().toString());
      Either<Failure, Owner> response =
          await getIt.get<StoresRepository>().createOwner(request);
      showProgress.value = false;
      response.fold(
        (l) => print(l.message),
        (r) async => {
          print(r.integrationId),
          Utils()
              .savePrefBoolValue(SharedPreferencesStrings.isCreatedOwner, true),
         isCreateOwnerResponseSuccess.value = true
        },
      );
    } else {
      //handle empty state error here
    }
  }

  ///on tapping Create Store
  void createStore() async {
    //validate empty state here for the text fields
    if (isValidationSuccessInCreateStore()) {
      showProgress.value = true;
      Owner owner = Owner(name:ownerNameTextController.text,integrationId: user.customerProfile.id);
      Store request = Store(id:null,name: storeNameTextController.text, owner: owner,storeTypeId: [132, 135]);
      print(request.toJson());
      Either<Failure, Store> response =
          await getIt.get<StoresRepository>().createStore(request);
      showProgress.value = false;
      response.fold(
        (l) => print(l.message),
        (r) async => {
          print(r.registerStore),
          Utils()
              .savePrefBoolValue(SharedPreferencesStrings.isCreatedStore, true)
        },
      );
    }
  }

  void isEnterAllTheFieldsInCreateOwner() {
    if (!GetUtils.isNullOrBlank(ownerName.value)) {
      isEnterTheFieldsInCreateOwner.value = true;
    } else {
      isEnterTheFieldsInCreateOwner.value = false;
    }
  }

  void isEnterAllTheFieldsInCreateStore() {
    if (!GetUtils.isNullOrBlank(storeName.value)) {
      isEnterTheFieldsInCreateStore.value = true;
    } else {
      isEnterTheFieldsInCreateStore.value = false;
    }
  }

  bool isValidationSuccessInCreateOwner() {
    if (GetUtils.isNullOrBlank(ownerName.value)) {
      errorMessage.value = Strings.enter_owner_name;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }

  bool isValidationSuccessInCreateStore() {
    if (GetUtils.isNullOrBlank(storeName.value)) {
      errorMessage.value = Strings.enter_store_name;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }
}
