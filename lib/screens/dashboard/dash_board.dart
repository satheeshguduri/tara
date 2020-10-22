import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/dashboard/notification_settings.dart';
import 'package:tara_app/screens/dashboard/profile_edit.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends BaseState<DashBoard> {


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
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 216,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                          gradient: Gradients.primaryGradient,
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(16.0),
                            bottomRight: const Radius.circular(16.0),
                          )
                      ),
                      child: Container(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 35,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            child: Text(
                              getTranslation(Strings.my_dashboard),
                              textAlign: TextAlign.center,
                              style: BaseStyles.topBarTextStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 26,),
                            child: Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(Assets.ic_avatar_default),
                                    fit: BoxFit.cover,
                                  )
                                // image: new Image.asset(_image.)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Text(
                          getTranslation(Strings.HELLO) + " 👋" ,
                          style:BaseStyles.alreadyHaveAccountTextStyle
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "Yakub Pasha",
                        textAlign: TextAlign.center,
                        style: BaseStyles.bankAccountHeaderTitleStyle,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
                    child: Column(
                      children: [
                        getCardWithTitle(Strings.profile),
                        getCardWithTitle(Strings.notification_settings),
                        getCardWithTitle(Strings.help_support)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton:getLogOutWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  getCardWithTitle(String title)
  {
    return InkWell(
      onTap: (){
        if (title == Strings.profile)
        {
          push(ProfileEdit());
        }
        else if (title == Strings.notification_settings)
        {
          push(NotificationSettings());
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 4,bottom: 4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
              boxShadow: [BoxShadow(
                  color: const Color(0x24000000),
                  offset: Offset(0,2),
                  blurRadius: 6,
                  spreadRadius: 0
              ), BoxShadow(
                  color: const Color(0x14000000),
                  offset: Offset(0,0),
                  blurRadius: 2,
                  spreadRadius: 0
              )] ,
              color: Colors.white
          ),
          child:Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    title==Strings.profile?Icon(Icons.person_outline,color: AppColors.header_top_bar_color,size: 24,):
                    title==Strings.notification_settings?Icon(Icons.notifications_none,color: AppColors.header_top_bar_color,size: 24,):
                    Icon(Icons.help_outline,color: AppColors.header_top_bar_color,size: 24,),
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16),
                      child: Text(
                          getTranslation(title),
                          style: BaseStyles.mobileNoTextStyle
                      ),
                    )
                  ],
                ),
                Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],size: 24,),
              ],
            ),
          ) ,
        ),
      ),
    );
  }

  getLogOutWidget()
  {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 24,top: 8,left: 16,right: 16),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Color(0xffb0b4c1)),
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            color: Colors.white
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.logout),
          textAlign: TextAlign.center,
          style: BaseStyles.logoutTextStyle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}