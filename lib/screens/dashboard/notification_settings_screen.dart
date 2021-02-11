import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/Data.dart';

class NotificationSettingsScreen extends StatefulWidget {
  final Function(bool, bool, bool) notificationSettingCallback;
  NotificationSettingsScreen({
    Key key,
    this.notificationSettingCallback,
  }) : super(key: key);

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends BaseState<NotificationSettingsScreen> {
  List<NotificationSettingsInfo> arrSettingsInfo = List();
  List<String> arrSettingTitles = [
    NotificationSettingsStrings.allow_all_notifications,
    NotificationSettingsStrings.chat,
    NotificationSettingsStrings.payment_requests,
    NotificationSettingsStrings.deals_and_discounts,
    NotificationSettingsStrings.promotions,
  ];

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: getNotificationSettingsListView(),
      ), //bottom: true,top: false,
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    arrSettingsInfo = List();

    for (var i = 0; i < arrSettingTitles.length; i++) {
      var settingInfo = NotificationSettingsInfo();
      settingInfo.settingTitle = arrSettingTitles[i];
      settingInfo.isSwitched = false;
      arrSettingsInfo.add(settingInfo);
    }
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          }),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.notification_settings),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  getNotificationSettingsListView() {
    return Container(
      color: Colors.transparent,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 12),
        itemCount: (arrSettingsInfo != null && arrSettingsInfo.isNotEmpty)
            ? arrSettingsInfo.length
            : 0,
        itemBuilder: (context, index) {
          return Container(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 8, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text(arrSettingsInfo[index].settingTitle,
                                style: BaseStyles.mobileNoTextStyle)),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Switch(
                        value: arrSettingsInfo[index].isSwitched,
                        onChanged: (value) {
                          setState(() {
                            arrSettingsInfo[index].isSwitched = value;
                          });
                        },
                        activeTrackColor: Color(0xffb2f7e2),
                        activeColor: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
                margin: EdgeInsets.only(left: 16, top: 8, right: 16),
              )
            ],
          ));
        },
      ),
    );
  }
}
