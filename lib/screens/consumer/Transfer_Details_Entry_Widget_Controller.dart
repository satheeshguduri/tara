

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';

class TransferDetailsEntryWidgetController extends GetxController{

  var showProgress = false.obs;
 // var customerProfile = CustomerProfileDetailsResponse().obs;
  var mappedItems = List<MappedBankAccountsBean>().obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController paymentSourceController = TextEditingController();
  TextEditingController cvvController = TextEditingController();


  String validateAmountWidget(String value) {

    if(value.length>0){
      return null;
    }else{
     return "Please Enter the Amount";
    }

  }

  String validateMessageWidget(String value){

    if(value.length>0){
      return null;
    }else{
      return "Please Enter the Message";
    }

  }

  String validateCategoryWidget(String value) {

    if(value.length>0){
      return null;
    }else{
      return "Please Enter the Category";
    }

  }

  String validatePaymentSourceWidget(String value) {

    if(value.length>0){
      return null;
    }else{
      return "Please Enter the Category";
    }

  }

  String validateCvvWidget(String value) {

    if(value.length>0){
      return null;
    }else{
      return "Please Enter the Category";
    }

  }

  void confirmToPay(String bic,num accountTokenId) async{
    await Get.find<TransactionController>().payNow(amountController.text,messageController.text,bic,cvvController.text,accountTokenId);

  }

  void getCustomerProfile2() async{
   CustomerProfileDetailsResponse response = await Get.find<TransactionController>().getCustomerProfile2();
   mappedItems.value = response.mappedBankAccounts;
   print("bankname"+mappedItems.value[0].bankName);

  }

}