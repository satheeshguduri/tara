import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/Merchant/create_owner_screen.dart';
import 'package:tara_app/screens/Merchant/create_store_screen.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/dashboard/dash_board.dart';
import 'package:tara_app/screens/dashboard/settings_screen.dart';
import 'package:tara_app/screens/merchant/merchant_home_widget.dart';
import 'package:tara_app/screens/scan_qr_code.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../../common/constants/colors.dart';

class MerchantHomeScreen extends StatefulWidget {
  MerchantHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MerchantHomeScreenState createState() => MerchantHomeScreenState();
}

class MerchantHomeScreenState extends BaseState<MerchantHomeScreen> {
  bool isTapOnIndex1 = true;
  bool isTapOnIndex2 = false;
  bool isTapOnIndex3 = false;
  int _currentIndex = 0;

  final List<Widget> _children = [
    MerchantHomeWidget(),
    ChatInbox(), //ConversationPage(canGoBack: false,),
    ScanQRCode(),
    DashBoard(),
    SettingsScreen(),
  ];

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  getBottomNavigation() {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
//    Future.delayed(Duration.zero, () => showBottomSheetToCreateOwner());
    return Scaffold(
        bottomNavigationBar: getBottomNavigation(),
        floatingActionButton: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            child: Container(
              // height: 56,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: Gradients.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(36, 7, 202, 208),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
                borderRadius: Radii.border(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: getSvgImage(imagePath: Assets.assets_icon_s_scan),
              ),
              //   child:getTabImage(Assets.ic_Scan),
            ),
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: getRootScreen());
  }

  getRootScreen() {
    return _children[_currentIndex];
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedDateStr = prefs.getString('myTimestampKey');
    bool isFirstTimeInaDay = prefs.getBool('isFirstTimeInaDay');
    if (savedDateStr != null) {
      var todayDateStr = Utils().getStringFromDate(DateTime.now(),
          "yyyy-MM-dd"); // DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (savedDateStr != todayDateStr) {
        isFirstTimeInaDay = false;
      }
    }

    if (savedDateStr == null || !isFirstTimeInaDay) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Settle Balance"),
            content: Text(
                "Please make sure to settle the previous day balances and continue"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  // Close the dialog
                  pop();
                  String date =
                      Utils().getStringFromDate(DateTime.now(), "yyyy-MM-dd");
                  prefs.setString('myTimestampKey', date);
                  prefs.setBool('isFirstTimeInaDay', true);
                },
              ),
            ],
          );
        },
      );
    }
  }

  /* showBottomSheetToCreateOwner() async {
    bool isCreatedOwner = await Utils().getPrefBoolValue(SharedPreferencesStrings.isCreatedOwner);
    if (!isCreatedOwner)
    {
      openBottomSheet();
    }
  }

  Future openBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        enableDrag:false,
        builder: (BuildContext context) {
          return CreateOwnerScreen();
        });
  }  */
}
