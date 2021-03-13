/*
*  home_customer_screen.dart
*  home_consumer_screen
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/controller/home_controller.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/consumer/home_customer_widget.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/dashboard/dash_board.dart';
import 'package:tara_app/screens/dashboard/settings_screen.dart';
import 'package:tara_app/screens/scan_qr_code.dart';
import '../../common/constants/values.dart';
import '../base/base_state.dart';

class HomeCustomerScreen extends StatefulWidget {
  HomeCustomerScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseState<HomeCustomerScreen> with AutomaticKeepAliveClientMixin{
  //with TickerProviderStateMixin {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeCustomerWidget(),
    ChatInbox(), //ConversationPage(canGoBack: false,),
    ScanQRCode(),
    DashBoard(),
    SettingsScreen(),
  ];
  HomeController homeController = Get.find<HomeController>();
  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    super.initState();
    homeController.getTransactionsHistory();
    homeController.getMyAccounts();
    homeController.getBanksList();
    homeController.getBillCategories();
  }

  @override
  void init() {
    getIt.get<StoresRepository>().getStoreTypes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: getBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        child: Container(
          width: 60,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getSvgImage(imagePath: Assets.assets_icon_s_scan),
          ),
          decoration: BoxDecoration(
            gradient: Gradients.primaryGradient,
            shape: BoxShape.circle,
          ),
        ),
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: getRootContainer(),
        top: false,
        bottom: true,
      ),
    );
  }

  Widget getRootContainer() {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: getBackgroundColor(),
        constraints: BoxConstraints.expand(),
        padding: !withDefaultMargins()
            ? EdgeInsets.all(0)
            : Margins.baseMarginAllScreen,
        child: getPageContainer() ??
            Align(
                alignment: Alignment.center,
                child: Text(
                    "Please override you container in getPageContainer()")));
  }

  @override
  bool withDefaultMargins() => false;

  @override
  Widget getBottomNavigation() {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyles.labelSelectedTextStyle,
      unselectedLabelStyle: TextStyles.labelUnSelectedTextStyle,
      selectedItemColor: AppColors.color_black_100_2_2_2,
      unselectedItemColor: AppColors.color_black_80_2_2_2,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: getSvgImage(
              imagePath: Assets.assets_icon_h_home_inactive,
              width: 24.0,
              height: 24.0),
          activeIcon: getSvgImage(
              imagePath: Assets.assets_icon_h_home_active,
              width: 24.0,
              height: 24.0),
          label: getTranslation(Strings.home),
        ),
        BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: getSvgImage(imagePath: Assets.assets_icon_c_chat_inactive),
            ),
            activeIcon: Container(
              width: 24,
              height: 24,
              child: getSvgImage(imagePath: Assets.assets_icon_c_chat_active),
            ),
            label: getTranslation(Strings.chat)),
        BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(bottom: 24),
            ),
            activeIcon: Container(
              margin: EdgeInsets.only(bottom: 24),
            ),
            label: getTranslation(Strings.scan)),
        BottomNavigationBarItem(
            icon: getSvgImage(
                imagePath: Assets.assets_icon_a_accounts_inactive,
                width: 24.0,
                height: 24.0),
            activeIcon: getSvgImage(
                imagePath: Assets.assets_icon_a_accounts_active,
                width: 24.0,
                height: 24.0),
            label: getTranslation(Strings.dashboard)),
        BottomNavigationBarItem(
            icon: Container(
                width: 24.0,
                height: 24.0,
                child: getSvgImage(
                    imagePath: Assets.assets_icon_s_setting_inactive)),
            activeIcon: Container(
                width: 24.0,
                height: 24.0,
                child: getSvgImage(
                    imagePath: Assets.assets_icon_s_setting_active)),
            label: getTranslation(Strings.settings)),
      ],
    );
  }

  Widget getPageContainer() {
    return _children[_currentIndex];
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
