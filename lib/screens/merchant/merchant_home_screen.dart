
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/dashboard/dash_board.dart';
import 'package:tara_app/screens/merchant/merchant_home_widget.dart';
import 'package:tara_app/screens/scan_qr_code.dart';

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
    ChatInbox(),//ConversationPage(canGoBack: false,),
    ScanQRCode(),
    MyAccount(),
    DashBoard(),
  ];


  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

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
          icon: Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(Assets.CHAT_IN_ACTIVE,),
          ), //getTabImage(Assets.CHAT_IN_ACTIVE),
          activeIcon: Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(Assets.CHAT_ACTIVE,),
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
          icon: getTabImage(Assets.ACCOUNTS_IN_ACTIVE),
          activeIcon: getTabImage(Assets.ACCOUNTS_ACTIVE),
          title: getTabText(TabTitle.ACCOUNTS),
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(Assets.SETTINGS_IN_ACTIVE,) ,),//getTabImage(Assets.SETTINGS_IN_ACTIVE),
          activeIcon: Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(Assets.SETTINGS_ACTIVE,width: 24,) ,), //getTabImage(Assets.SETTINGS_ACTIVE),
          title: getTabText(TabTitle.SETTINGS),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
        bottomNavigationBar:getBottomNavigation(),
        floatingActionButton: FloatingActionButton(
          elevation: 0, highlightElevation: 0,
            child: Container(
              height: 56,
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
              child:getTabImage(Assets.ic_Scan),
            ),
            onPressed: () {}),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        body: getRootScreen()

    );
  }

  getRootScreen(){
    return _children[_currentIndex];
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int timestamp = prefs.getInt('myTimestampKey');
    DateTime before;
    DateTime now;
    Duration timeDifference;
    int hours;
    if (timestamp!=null)
    {
      before = DateTime.fromMillisecondsSinceEpoch(timestamp);
      now = DateTime.now();
      timeDifference = now.difference(before);
      hours = timeDifference.inHours;
    }

    if (timestamp == null || (hours!=null && hours == 24)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Settle Balance"),
            content: new Text("Please make sure to settle the previous day balances and continue"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                  int timestamp = DateTime.now().millisecondsSinceEpoch;
                  prefs.setInt('myTimestampKey', timestamp);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
