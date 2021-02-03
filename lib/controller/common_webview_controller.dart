/*
*  common_webview_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tara_app/screens/consumer/common_webview.dart';

class CommonWevViewController extends GetxController{


  var url = "".obs;
  var showProgress = false.obs;

  // var addCreditCardCallback = "http://107.20.4.43:9005/v0.1/mcpayment/tokenization/callback?token=1&success=1&register_id=a10603a9782841ec805133f7d894c8ed";
  // var paymentCallback = "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback?transaction=1&success=1&register_id=35f6363c72d7410bbcf62efd19cdde9d";
  var addCreditCardCallback = "http://107.20.4.43:9005/v0.1/mcpayment/tokenization/callback";
  var paymentCallback = "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback";




  onLoadStart(String currentUrl,WebViewType type){
    showProgress.value = true;
      if(type == WebViewType.ADD_CREDIT_CARD && currentUrl.contains(addCreditCardCallback)){
        var callback = Uri.dataFromString(currentUrl);
        Map<String, String> params = callback.queryParameters;
        var isSuccess = params['success']??false;
      }else if(type == WebViewType.ADD_CREDIT_CARD && currentUrl.contains(addCreditCardCallback)){

      }

  }

  onLoadStop(){
    showProgress.value = false;
  }






}