/*
*  home_customer_screen.dart
*  home_consumer_screen
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/consumer/home_customer_widget.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/dashboard/dash_board.dart';
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
    HomeCustomerWidget(),
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
  init() async {
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
          child: getTabImage(Assets.SCAN_IN_ACTIVE,),
          decoration: BoxDecoration(
            gradient: Gradients.primaryGradient,
            shape: BoxShape.circle,
          ),
        ),
        onPressed: () {},
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
            icon: getTabImage(Assets.HOME_IN_ACTIVE),
            activeIcon: getTabImage(Assets.HOME_ACTIVE),
            title: getTabText(TabTitle.HOME)),
        BottomNavigationBarItem(
          icon: getTabImage(Assets.CHAT_IN_ACTIVE),
          activeIcon: getTabImage(Assets.CHAT_ACTIVE),
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
          icon: getTabImage(Assets.MY_ORDERS_ACTIVE),
          activeIcon: getTabImage(Assets.MY_ORDERS_IN_ACTIVE),
          title: getTabText(TabTitle.MY_ORDERS)
        ),
        BottomNavigationBarItem(
          icon: getTabImage(Assets.ACCOUNTS_IN_ACTIVE),
          activeIcon: getTabImage(Assets.ACCOUNTS_ACTIVE),
          title: getTabText(TabTitle.ACCOUNTS),
          ),
      ],
    );
  }


  getPageContainer() {
    return _children[_currentIndex];
  }
}
