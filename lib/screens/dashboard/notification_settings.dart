import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/Data.dart';

class NotificationSettings extends StatefulWidget {

  final Function(bool,bool,bool) notificationSettingCallback;
  NotificationSettings({Key key,this.notificationSettingCallback,}) : super(key: key);

  @override
  _NotificationSettingsState createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState
    extends BaseState<NotificationSettings> {

  List<NotificationSettingsInfo> arrSettingsInfo = List();
  List<String> arrSettingTitles = [NotificationSettingsStrings.push_notification,NotificationSettingsStrings.email,NotificationSettingsStrings.whats_app];
  List<String> arrSettingSubTitles = [NotificationSettingsStrings.receive_notification_push_subtext,
    NotificationSettingsStrings.receive_notification_email_subtext,
    NotificationSettingsStrings.receive_notification_whatsapp_subtext];

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body:SafeArea(child:  getNotificationSettingsListView(),), //bottom: true,top: false,
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
      settingInfo.settingSubTitle = arrSettingSubTitles[i];
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
          }
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.notification_settings),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  getNotificationSettingsListView()
  {
    return Container(
      color: Colors.transparent,
      child:ListView.builder(
        padding: EdgeInsets.only(top: 12),
        itemCount: (arrSettingsInfo!=null && arrSettingsInfo.isNotEmpty)?arrSettingsInfo.length:0,
        itemBuilder: (context, index) {
          return Container(
            child:Column(
              children: [
                Container(
                  margin:EdgeInsets.only(left: 16,top: 8,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(margin:EdgeInsets.only(bottom: 4),child:Text(arrSettingsInfo[index].settingTitle, style: BaseStyles.mobileNoTextStyle)),
                          Container(child:Text(arrSettingsInfo[index].settingSubTitle, style: BaseStyles.chatSubTitleTextStyle)),
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
                  margin: EdgeInsets.only(left: 16,top: 8,right: 16),
                )
              ],
            )
          );
        },
      ) ,
    );
  }


}

