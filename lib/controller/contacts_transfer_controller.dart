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
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
import 'package:tara_app/models/auth/registration_status.dart';
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
  var filteredContactsList = List<CustomerProfile>().obs;
  var totalContactsList = List<CustomerProfile>().obs;
  var searchInProgress  = false.obs;


 var title = "abc".obs;

  var searchText = "".obs;

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
        contactList.value = (await ContactsService.getContacts(withThumbnails: false,)).toList();
        print("Total Contacts Lenght: ==> "+contactList.value.length.toString());
       contactList.value.removeWhere((e) => e?.phones?.isEmpty??true);
        print("After Deletion Total Contacts Lenght: ==> "+contactList.value.length.toString());
        totalContactsList.value = contactList.value.map((e) {
               return CustomerProfile(mobileNumber: e.phones?.elementAt(0).value.removeAllWhitespace,firstName: e?.displayName,registrationStatus: RegistrationStatus.INACTIVE);
            }
        ).toList();
        print(totalContactsList.value.toString());
      }
      showProgress.value = false;
    }

    void searchContact(String value){
      searchInProgress.value = true;
      if(value.isEmpty){
        searchInProgress.value = false;
        searchText.value= "";
        filteredContactsList.value.clear();
      }else{
        searchInProgress.value = true;
        searchText.value= value;
        filteredContactsList.value = totalContactsList.value
            .where((contact) => (contact.firstName.toLowerCase()??"")
            .toLowerCase()
            .startsWith(value.toLowerCase()))
            .toList();
      }


    }
  void filterTheContacts(String value) {
    title.value = value;
    searchText.value = value;
    if (searchText != null &&searchText.toString().trim().isNotEmpty &&searchText.toString().trim().length > 2) {
      filteredContactsList.value=[];
      if (totalContactsList.value.isNotEmpty) {
        filteredContactsList.value = totalContactsList.value
            .where((contact) => (contact.firstName??"")
                .toLowerCase()
                .contains(searchText.value.toLowerCase()))
            .toList();

      }
    } else {
      if (searchQuery.text == "") {
        title.value = "";
        searchText.value = "";
        searchQuery.text = "";
        filteredContactsList.value.clear();
        searchInProgress.value = false;

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

 Future getBeneficiaries() async {
  // showProgress.value = true;
   var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();

    if(isSessionInitiated){
      var queries =  await BaseRequestHelper().getCustomerDataQueryParam();
      var benResponse =  await getIt.get<TransactionRepository>().getBeneficiaries(queries);
      if(benResponse.isRight()){
        var response = benResponse.getOrElse(() => null);
        arrRecentlyAddedContactInfo.value = response.beneDetails;
        print(jsonEncode(arrRecentlyAddedContactInfo.value[0]));
        arrRecentlyAddedContactInfo.value.forEach((e) async{
         var matchedObject = totalContactsList.value.where((element){
           print(element.mobileNumber.removeAllWhitespace);
           print(e.beneMobile.removeAllWhitespace);
            return element.mobileNumber.removeAllWhitespace.contains(e.beneMobile.removeAllWhitespace);}).toList();
         if(matchedObject?.isNotEmpty??false) {
           var objIndex = totalContactsList.value.indexOf(matchedObject[0]);
           totalContactsList.value[objIndex].registrationStatus =
               RegistrationStatus.BENEFICIARY;
         }else{
           print("Not matched");
         }
        });
      }
    }
    showProgress.value = false;
  }


}