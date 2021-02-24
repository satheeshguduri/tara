/*
*  common_webview_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tara_app/screens/consumer/common_webview.dart';
import 'package:tara_app/controller/transaction_controller.dart';




class CommonWevViewController extends GetxController{


  var url = "".obs;
  var showProgress = false.obs;
  var isCardAddedSuccess = "".obs;
  var isPaymentSuccess = "".obs;


  // var addCreditCardCallback = "http://107.20.4.43:9005/v0.1/mcpayment/tokenization/callback?token=1&success=1&register_id=a10603a9782841ec805133f7d894c8ed";
  // var paymentCallback = "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback?transaction=1&success=1&register_id=35f6363c72d7410bbcf62efd19cdde9d";
  var addCreditCardCallback = "http://107.20.4.43:9005/v0.1/mcpayment/tokenization/callback";
//  var paymentCallback = "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback";
  var paymentCallback = "https://tokenize-staging.mcpayment.id/return_pay";

  TransactionController transactionController = Get.find();




  onLoadStart(String currentUrl,WebViewType type){
       print("webview type"+type.toString());
       print("current url"+currentUrl);
       showProgress.value = true;
      if(type == WebViewType.ADD_CREDIT_CARD && currentUrl.contains(addCreditCardCallback)){
        isPaymentSuccess.value ="";
        var callback = Uri.dataFromString(currentUrl);
        Map<String, String> params = callback.queryParameters;
        isCardAddedSuccess.value = params['success']??"0";
        Get.back();
      }else if(type == WebViewType.PAYMENT && currentUrl.contains(paymentCallback)){
        print("coming here");
        isCardAddedSuccess.value = "";
        var callback = Uri.dataFromString(currentUrl);
        Map<String, String> params = callback.queryParameters;
        isPaymentSuccess.value = params['success']??"0";
        transactionController.paymentCompleted(trContext: TransactionContext.BILL_PAYMENT);
        Get.back();


      }

  }

  onLoadStop(){
    showProgress.value = false;
  }






}