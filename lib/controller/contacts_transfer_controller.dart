/*
*  transaction_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/authorize_request.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/device_info.dart';
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/validate_mobile_request.dart';
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/agent/transaction_history.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/my_account/otp_verification_screen.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import '../tara_app.dart';
import 'auth_controller.dart';

class ContactsTransferController extends GetxController{
  var showProgress = false.obs;
  var contactList = List<Contact>().obs;
  var filteredContactList = List<Contact>().obs;
  var arrRecentlyAddedContactInfo = List<BeneDetailBean>().obs;


 var title = "abc".obs;

  String searchText = "";

  TextEditingController searchQuery = TextEditingController();


  void loadData() async {
      showProgress.value = true;
      var status = await Permission.contacts.status;
      if (!status.isGranted) {
        PermissionStatus permissionStatus = await Permission.contacts.request();
        if(permissionStatus.isGranted) {
          contactList.value = (await ContactsService.getContacts( withThumbnails: false)).toList();
        }else{
          getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(desc:"Please enable contacts access permission in system settings",
            onTap: (){
                Get.back();
                Get.back();
            },),
          );
        }
      }else{
        contactList.value = (await ContactsService.getContacts(withThumbnails: false)).toList();

      }
      showProgress.value = false;
    }

  void filterTheContacts(String value) {
    title.value = value;
    searchText = value;
    if (searchText != null &&searchText.toString().trim().isNotEmpty &&searchText.toString().trim().length > 2) {
      filteredContactList.value=[];
      if (contactList.value.isNotEmpty) {
        filteredContactList.value = contactList.value
            .where((contact) =>
            displayNameValidation(contact.displayName??"")
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();

      }
    } else {
      if (searchQuery.text == "") {
        title.value = "";
        searchText = "";
        searchQuery.text = "";
        filteredContactList.value.clear();

      }
    }
  }

  String displayNameValidation(String contactInfo) {
    try{
      return contactInfo??"";
    }catch(Exception){
      return " ";
    }
  }

 void getBeneficiaries() async {
  // showProgress.value = true;
   var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();

    if(isSessionInitiated){
      var queries =  await BaseRequestHelper().getCustomerDataQueryParam();
      var benresponse =  await getIt.get<TransactionRepository>().getBeneficiaries(queries);
      if(benresponse.isRight()){
        var response = benresponse.getOrElse(() => null);
        arrRecentlyAddedContactInfo.value = response.beneDetails;

      }
    //  showProgress.value = false;

    }
  }


}