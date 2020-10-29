import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/screens/agent/Agent_Home_Widget.dart';
import 'package:tara_app/screens/agent/agent_widgets/agent_inprogress_handshake.dart';
import 'package:tara_app/screens/agent/agent_widgets/agent_inprogress_transaction.dart';
import 'package:tara_app/screens/agent/agent_widgets/agent_prepair_to_collect_cash.dart';
import 'package:tara_app/screens/agent/balance_history.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/dashboard/dash_board.dart';

import '../scan_qr_code.dart';
import 'agent_widgets/agent_empty_inprogress.dart';

class AgentHomeScreen extends StatefulWidget {
  AgentHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AgentHomeScreenState createState() => AgentHomeScreenState();
}

class AgentHomeScreenState extends BaseState<AgentHomeScreen> {
  int _currentIndex = 0;
  int selectedSegmentIndex = 0;
  bool isAccepted = false;
  bool isHandShake = false;
  bool isConfirmHandShake = false;

  final List<Widget> _children = [
    AgentHomeWidget(),
    ChatInbox(),//ConversationPage(canGoBack: false,),
    ScanQRCode(),
    MyAccount(),
    DashBoard(),
  ];

  BoxDecoration roundedBoxDecoration() {
    return BoxDecoration(
        borderRadius: Radii.border(20),
        boxShadow: Shadows.shadows_list,
        color: AppColors.primaryBackground);
  }

  @override
  BottomNavigationBar getBottomNavigation() {
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
              child: getTabText(TabTitle.SCAN)),
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
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: getBottomNavigation(),
        floatingActionButton: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
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
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: getTabImage(Assets.ic_Scan),
            ),
            onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(child: getRootContainer(),top: false,bottom: true,)

    );
  }

  getRootContainer(){
    return _children[_currentIndex];
  }


}
