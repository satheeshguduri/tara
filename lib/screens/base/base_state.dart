/*
*  base_state.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:after_layout/after_layout.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import '../../common/constants/Margins.dart';
import 'common_mixin.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with AfterLayoutMixin, CommonMixin , BaseWidgets {
  ///analytics observer to monitor the screen changes
  FirebaseAnalyticsObserver observer;

  ///abstract method to be override
  /// if we want to have any type of api calls or initialization services.
  void init() {}

  String pageTitle() {
    return "Tara";
  }

  bool canGoBack() => false;

  ///method to get the appBar. optional
  Widget getFloatingActionButton() => Container(height: 0);

  ///method to get the main container of the page
//  getPageContainer();

  Widget getBottomNavigation() => Container(height: 0);

  @override
  BuildContext getContext();

  /// method to override the background color of the screen
  Color getBackgroundColor() => Colors.white;

  bool withDefaultMargins() => true;

  EdgeInsets containerPadding() =>
      !withDefaultMargins() ? EdgeInsets.all(0) : Margins.baseMarginAllScreen;

  ///method which will be called after all the widget bindings.
  @protected
  @override
  void afterFirstLayout(BuildContext context) {
    init();
//    observer = Provider.of<FirebaseAnalyticsObserver>(context,listen: false);
  }
//un comment after the values import
//  AppBar getAppBar() {
//    return AppBar(
//        title: Text(
//          pageTitle(),
//          style: BaseStyles.appTitleTextStyle,
//        ),
//        centerTitle: false,
//        automaticallyImplyLeading: false,
//        elevation: pageTitle().isEmpty ? 0 : 0.5,
//        backgroundColor: pageTitle().isEmpty
//            ? AppColors.homeScreenBackgroundWhite
//            : AppColors.homeScreenBackground,
//        leading: canGoBack()
//            ? IconButton(
//                icon: Image.asset(
//                  "assets/images/ic-back.png",
//                  fit: BoxFit.none,
//                ),
//                onPressed: () => Navigator.of(context).pop(),
//              )
//            : null);
//  }
}
