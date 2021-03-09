

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';

class TransferDetailsEntryWidgetController extends GetxController{

  var showProgress = false.obs;
  var mappedItems = List<MappedBankAccountsBean>().obs;
  var currentSelectedCategory="Gift".obs;
  var selectedBenAccount=BeneDetailBean().obs;
  var selectedSelfAccount=MappedBankAccountsBean().obs;


  TextEditingController amountController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController paymentSourceController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  // new screen controller
   TextEditingController txtCtrlTransferAmt = TextEditingController();



  String validateAmountWidget(String value) {

    if(value.length>0){
      return null;
    }else{
     return Strings.entertheamount;
    }

  }

  String validateMessageWidget(String value){

    if(value.length>0){
      return null;
    }else{
      return Strings.typeyourmessage;
    }

  }




  String validateCvvWidget(String value) {
    if(value.length>0){
      if(value.length==3) {
         return null;
        }else{
       return Strings.enterthevalidcvv;
      }
    }else{
      return Strings.enterthecvv;
    }

  }

  void confirmToPay({String mobile,String amount,String remarks,String bic,String cvv,num accountTokenId,num beneId,num selfAccountId,MappedBankAccountsBean selectedSourceBankAccount}) async{
    await Get.find<TransactionController>().payNow(mobileNumber: mobile,amount1:txtCtrlTransferAmt.text,remarks1:messageController.text,bic1: bic,cvv1:cvvController.text,initiatorAccountId1: accountTokenId,benId1: beneId,selfAccountTokenId: selfAccountId);

  }

  void getCustomerBankAccounts() async{
   CustomerProfileDetailsResponse response = await Get.find<TransactionController>().getCustomerProfile2();
   mappedItems.value = response.mappedBankAccounts;

  }

  String getAccountNumberOnly(String fullString) {
    List<String> list = fullString.split('#').toList();
    return "**** **** **"+ list[0].substring(list[0].length - 2);

  }
}