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
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/consumer/home_customer_widget.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/dashboard/dash_board.dart';
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

class _HomeScreenState extends BaseState<HomeCustomerScreen> {
  //with TickerProviderStateMixin {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeCustomerWidget(),
    ChatInbox(),//ConversationPage(canGoBack: false,),
    ScanQRCode(),
    DashBoard(),
    MyAccount(),
  ];

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {

    super.initState();
  }


  @override
  init(){
    getIt.get<StoresRepository>().getStoreTypes();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        elevation: 0, highlightElevation: 0,
        child: Container(
          width: 60,
          height: 60,
         // child: getTabImage(Assets.SCAN_IN_ACTIVE,),
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
      body: SafeArea(child: getRootContainer(),top: false,bottom: true,),
    );
  }

  getRootContainer() {
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
  withDefaultMargins() => false;

  @override
  getBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon:getSvgImage(imagePath: Assets.assets_icon_h_home_inactive,width: 24.0,height: 24.0),
           // icon: getSvgImage(imagePath:Assets.assets_icon_s_search,width: 24.0,height: 24.0),
            //activeIcon: getTabImage(Assets.HOME_ACTIVE),
            activeIcon: getSvgImage(imagePath: Assets.assets_icon_h_home_active,width: 24.0,height: 24.0),
            title: getTabText(TabTitle.HOME)),
        BottomNavigationBarItem(
          icon: Container(
            width: 24,
            height: 24,
            child: getSvgImage(imagePath: Assets.assets_icon_c_chat_inactive),
          ), //getTabImage(Assets.CHAT_IN_ACTIVE),
          activeIcon: Container(
            width: 24,
            height: 24,
            child: getSvgImage(imagePath: Assets.assets_icon_c_chat_active),
          ), //getTabImage(Assets.CHAT_ACTIVE),
          title: Text(
            TabTitle.CHAT,
            style: BaseStyles.navigationTextStyle,
          ),
        ),

        BottomNavigationBarItem(
          icon: Container(),
          activeIcon: Container(),
          title: Padding(
            padding: EdgeInsets.only(top: 24),
            child: getTabText(TabTitle.SCAN)
          ),
        ),
        BottomNavigationBarItem(
         // icon: getTabImage(Assets.MY_ORDERS_ACTIVE),
          icon: getSvgImage(imagePath: Assets.assets_icon_a_accounts_inactive,width: 24.0,height: 24.0),
         // activeIcon: getTabImage(Assets.MY_ORDERS_IN_ACTIVE),
          activeIcon:getSvgImage(imagePath:  Assets.assets_icon_a_accounts_active,width: 24.0,height: 24.0),
          title: getTabText(TabTitle.DASHBOARD)
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 24.0,
            height: 24.0,
            child:getSvgImage(imagePath: Assets.assets_icon_s_setting_inactive)),
            //SvgPicture.asset(Assets.SETTINGS_IN_ACTIVE,) ,),//getTabImage(Assets.SETTINGS_IN_ACTIVE),
          activeIcon: Container(
            width: 24.0,
            height: 24.0,
            child:getSvgImage(imagePath: Assets.assets_icon_s_setting_active)),
            //SvgPicture.asset(Assets.SETTINGS_ACTIVE,width: 24,) ,), //getTabImage(Assets.SETTINGS_ACTIVE),
          title: getTabText(TabTitle.SETTINGS),
          ),
      ],
    );
  }


  getPageContainer() {
    return _children[_currentIndex];
  }

}
