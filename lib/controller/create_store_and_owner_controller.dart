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
import 'package:tara_app/common/widgets/login_flow_widgets/account_confirmation.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';

class CreateStoreAndOwnerController extends GetxController {
  ///listen for the progress bar changes
  var showProgress = false.obs;
  var isEnterTheFieldsInCreateStore = false.obs;
  var isEnterTheFieldsInCreateOwner = false.obs;

  var errorMessage = "".obs;
  var addressStr =
      "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …".obs;
  var isCreateOwnerResponseSuccess = false.obs;


  TextEditingController ownerNameTextController = TextEditingController();
  TextEditingController storeNameTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  Owner ownerResponseObj = Owner();
  var storeTypes = List<StoreTypeModel>().obs;
  var selectedStoreType = StoreTypeModel().obs;
  var selectedStoreTypeName = "".obs;

  AuthResponse user = Get.find<AuthController>().user.value;
  ///on clicking on send otp
  void createOwner() async {

    var data = await getIt.get<UserLocalDataStore>().getUser();
//    data.fold(
//            (l) => print,
//            (r) => {
//          if(r?.securityToken?.token!=null){
//            Get.put(r),
//            user = r,
//          }
//        });

    var ownerName = "";
    user = data;
    if (!GetUtils.isNullOrBlank(user?.customerProfile?.firstName)) {
      ownerName = user.customerProfile.firstName;
    }else if (!GetUtils.isNullOrBlank(user?.customerProfile?.lastName)) {
      ownerName = user.customerProfile.lastName;
    }
    //validate empty state here for the text fields
    if (!GetUtils.isNullOrBlank(ownerName) && !GetUtils.isNullOrBlank(user?.customerProfile?.id)) {
      Owner request = Owner(name: ownerName,integrationId: user?.customerProfile?.id);
      print(request.toJson().toString());
      Either<Failure, Owner> response =
          await getIt.get<StoresRepository>().createOwner(request);
      response.fold(
        (l) => print(l.message),
        (r) async => {
          print(r),
          ownerResponseObj = r,
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
//      Owner owner = Owner(name:ownerNameTextController.text,integrationId: user.customerProfile.id);
      int id = selectedStoreType.value.id.toInt();
      Store request = Store(id:null,name: storeNameTextController.text, owner: ownerResponseObj,storeTypeId: [id]);
      print(request.toJson());
      Either<Failure, Store> response =
          await getIt.get<StoresRepository>().createStore(request);
      showProgress.value = false;
      response.fold(
        (l) => print(l.message),
        (r) async => {
          print(r.registerStore),
          Get.to(AccountConfirmationScreen())
//          Utils()
//              .savePrefBoolValue(SharedPreferencesStrings.isCreatedStore, true)
        },
      );
    }
  }

  void isEnterAllTheFieldsInCreateOwner() {
    if (!GetUtils.isNullOrBlank(ownerNameTextController.text)) {
      isEnterTheFieldsInCreateOwner.value = true;
    } else {
      isEnterTheFieldsInCreateOwner.value = false;
    }
  }

  void isEnterAllTheFieldsInCreateStore() {
    if (!GetUtils.isNullOrBlank(storeNameTextController.text)) {
      isEnterTheFieldsInCreateStore.value = true;
    } else {
      isEnterTheFieldsInCreateStore.value = false;
    }
  }


  bool isValidationSuccessInCreateStore() {
    if (GetUtils.isNullOrBlank(storeNameTextController.text)) {
      errorMessage.value = Strings.enter_full_name;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }

  Future<List<StoreTypeModel>> getAllStoreTypes() async{
    Either<Failure,List<StoreTypeModel>> response = await getIt.get<StoresRepository>().getStoreTypes();
    response.fold((l) => print(l.message), (r) => {
      storeTypes.value = r,
      selectedStoreType.value = storeTypes.first,
    });
    return storeTypes;
  }
}
