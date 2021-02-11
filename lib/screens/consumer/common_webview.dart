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

enum WebViewType { ADD_CREDIT_CARD, PAYMENT, COMMON }

class CommonWebViewScreen extends StatelessWidget {
  final String url;
  final String title;
  final WebViewType type;
  CommonWebViewScreen({Key key, this.url, this.title, this.type})
      : super(key: key);
  final CommonWevViewController commonWevViewController =
      CommonWevViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: title,
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
                  initialUrl: url,
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions()),
                  onLoadStart: (InAppWebViewController controller, url) =>
                      commonWevViewController.onLoadStart(url, type),
                  onLoadStop: (InAppWebViewController controller, url) =>
                      commonWevViewController.onLoadStop()),
            ),
          ),
        ],
      ),
    );
  }
}
