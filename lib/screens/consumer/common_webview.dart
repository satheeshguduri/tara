/*
*  common_webview.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/controller/common_webview_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';


enum WebViewType { ADD_CREDIT_CARD, PAYMENT, COMMON }

class CommonWebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final WebViewType type;
  final num amount;

  CommonWebViewScreen({Key key, this.url, this.title, this.type,this.amount})
      : super(key: key);

  @override
  CommonWebViewScreenState createState() => CommonWebViewScreenState();


}


  class CommonWebViewScreenState extends BaseState<CommonWebViewScreen> {

    final CommonWevViewController commonWevViewController =  CommonWevViewController();
    var addCreditCardCallback = "http://107.20.4.43:9005/v0.1/mcpayment/tokenization/callback";
    var paymentCallback = "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback";

    @override
  void initState() {
    super.initState();
    commonWevViewController.payAmount = widget.amount;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: widget.title,
        addNewWidgetShow: false,
      ),
      body: Obx(() =>
          SafeArea(child: getWebView()) //put your body container here.
              .withProgressIndicator(
                  showIndicator: commonWevViewController.showProgress.value)),
    );
  }

  Widget getWebView() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[200])),
              child: InAppWebView(
                  initialUrl: widget.url,
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions()),
                  onLoadStart: (InAppWebViewController controller, url) {
                  commonWevViewController.onLoadStart(url, widget.type);

                  //for adding card
                  if(commonWevViewController.isCardAddedSuccess.value.isNotEmpty){
                      if(commonWevViewController.isCardAddedSuccess.value=="1"){
                      showToast(message: "Card Added Successfully");
                      }else{
                      showToast(message: "Card Not Added");
                      }
                    // for payment
                 }else if(commonWevViewController.isPaymentSuccess.value.isNotEmpty){
                    if(commonWevViewController.isPaymentSuccess.value=="1"){
                      showToast(message: "Payment has done successfully");
                    }else{
                      showToast(message: "Payment has done successfully");
                      // showToast(message: "Payment Failed");
                    }
              }

              },
                  onLoadStop: (InAppWebViewController controller, url) =>
                      commonWevViewController.onLoadStop()),
            ),
          ),
        ],
      ),
    );
  }

  @override
  BuildContext getContext() {
  return context;
  }


}
