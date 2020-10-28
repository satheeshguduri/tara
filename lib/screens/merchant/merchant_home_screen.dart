
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';

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

  BoxDecoration roundedBoxDecoration(){
    return BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(20)
        ),
        boxShadow: Shadows.shadows_list ,
        color: AppColors.primaryBackground
    );
  }

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
            icon: getTabImage(Assets.ic_home),
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
    icon: getTabImage(Assets.ACCOUNTS_ACTIVE),
    activeIcon: getTabImage(Assets.ACCOUNTS_IN_ACTIVE),
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
        body: SafeArea(
          top: false,
          child:Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child:Column(
                children: [
                  Container(
//                      height: 230,
                    child: HomeTopBar(appName: "Merchant",),
                  ),
                  Expanded(child: SingleChildScrollView(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                          padding: EdgeInsets.all(16),
                          height: 158,
                          decoration: BoxDecoration(
                              borderRadius: Radii.border(8),
                              gradient: Gradients.primaryGradient
                          ),
                          child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity : 0.6,
                                child:   Text(
                                    getTranslation(Strings.AVAIL_BALANCE),
                                    style: const TextStyle(
                                        color:  AppColors.primaryText,
                                        fontWeight: FontWeight.w500,
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 12.0
                                    ),
                                    textAlign: TextAlign.center
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Rp 1.256.000",
                                        style: const TextStyle(
                                            color:AppColors.fareColor,
                                            fontWeight: FontWeight.w700,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 24.0
                                        )
                                    ),
                                    InkWell(
                                      child:Container(
                                        margin: EdgeInsets.only(left: 12),
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            boxShadow: [BoxShadow(
                                                color: const Color(0x1a000000),
                                                offset: Offset(0,4),
                                                blurRadius: 8,
                                                spreadRadius: 0
                                            )] ,
                                            color: const Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(14)
                                        ),
                                        child:Icon(Icons.chevron_right,color: AppColors.fareColor,) ,
                                      ) ,
                                      onTap: (){
                                      },
                                    ),

                                  ]),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      width: 146,
                                      height: 64,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)
                                          ),
                                          boxShadow: Shadows.shadows_list ,
                                          color: AppColors.primaryBackground
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  getTranslation(Strings.INCOMING),
                                                  style: const TextStyle(
                                                      color:  AppColors.primaryText,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: 12.0
                                                  )
                                              ),
                                              Icon(Icons.chevron_right,size: 16,),

                                            ],
                                          ),
                                          Text(
                                              "Rp 7.692.350",
                                              style: const TextStyle(
                                                  color:  AppColors.fareColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 16.0
                                              )
                                          )
                                        ],
                                      )

                                  ),
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      width: 146,
                                      height: 64,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)
                                          ),
                                          boxShadow: Shadows.shadows_list ,
                                          color: AppColors.primaryBackground
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  getTranslation(Strings.OUT_GOING),
                                                  style: const TextStyle(
                                                      color:  AppColors.primaryText,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: 12.0
                                                  )
                                              ),
                                              Icon(Icons.chevron_right,size: 16,),

                                            ],
                                          ),
                                          Text(
                                              "Rp 3.388.475",
                                              style: const TextStyle(
                                                  color:  AppColors.fareColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 16.0
                                              )
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),

                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16,top: 16),
//            padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  getTranslation(Strings.ORDERS),
                                  style: const TextStyle(
                                      color:  AppColors.fareColor,
                                      fontWeight: FontWeight.w700,
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 20.0
                                  )
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                    child:Text(
                                        getTranslation(Strings.SEE_ALL),
                                        style: const TextStyle(
                                            color:  AppColors.fareColor,
                                            fontWeight: FontWeight.w700,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 14.0
                                        ),
                                        textAlign: TextAlign.right
                                    ),
                                    onTap: (){

                                    },
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 28),
                                      width: 54,
                                      height: 2,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffb2f7e2)
                                      )
                                  )
                                ],
                              )
                            ],
                          ) ,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: Radii.border(24),
                              color: const Color(0xfff7f7f7)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isTapOnIndex1 = true;
                                    isTapOnIndex2 = false;
                                    isTapOnIndex3 = false;
                                  });
                                },
                                child: Container(
                                    width: 104,
                                    height: 40,
                                    decoration: isTapOnIndex1 ? roundedBoxDecoration() : null,
                                    child:Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              getTranslation(Strings.NEW),
                                              style: const TextStyle(
                                                  color:  AppColors.primaryText,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 14.0
                                              ),
                                              textAlign: TextAlign.center
                                          ),
//                                          isTapOnIndex1 ?
                                          Container(
                                            margin: EdgeInsets.only(left: 4),
                                            alignment: Alignment.center,
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                                color: AppColors.badge_color,
                                                borderRadius:Radii.border(8)
                                            ),
                                            child: Text(
                                                "3",
                                                style: const TextStyle(
                                                    color:  const Color(0xffffffff),
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle:  FontStyle.normal,
                                                    fontSize: 10.0
                                                ),
                                                textAlign: TextAlign.center
                                            ),
                                          )
//                                              : Container()
                                        ],
                                      ),
                                    )
                                ) ,
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isTapOnIndex1 = false;
                                    isTapOnIndex2 = true;
                                    isTapOnIndex3 = false;
                                  });
                                },
                                child:Container(
                                    width: 104,
                                    height: 40,
                                    decoration: isTapOnIndex2 ? roundedBoxDecoration() : null,
                                    child:Center(
                                      child: Text(
                                          getTranslation(Strings.IN_PROGRESS),
                                          style: const TextStyle(
                                              color:  AppColors.primaryText,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.center
                                      ),
                                    )
                                ) ,
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isTapOnIndex1 = false;
                                    isTapOnIndex2 = false;
                                    isTapOnIndex3 = true;
                                  });
                                },
                                child:Container(
                                    width: 104,
                                    height: 40,
                                    decoration: isTapOnIndex3 ? roundedBoxDecoration() : null,
                                    child:Center(
                                      child: Text(
                                          getTranslation(Strings.COMPLETED),
                                          style: const TextStyle(
                                              color:  AppColors.primaryText,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.center
                                      ),
                                    )
                                ) ,
                              ),
                            ],
                          ),
                        ),
                        getBottomView()
                      ],
                    ),
                  ))
                ],
              )
          ) ,
        )
    );
  }

  Widget getBottomView(){
    if(isTapOnIndex1){
      // New
      return Container(
        margin: EdgeInsets.only(bottom: 32),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context,index){
            return  InkWell(
              onTap: (){
                push(ConversationPage(arrChats: ["items_order"],));
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                padding: EdgeInsets.all(16),
//                            height: 64,
                decoration:
                BoxDecoration(
                    borderRadius: Radii.border(8),
                    boxShadow: Shadows.shadows_list,
                    color: AppColors.primaryBackground
                ),
                child:Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rectangle
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Assets.ic_person1,height: 40,width: 40,),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TODAY • 12:33
                                  Text(
                                      "TODAY • 12:33",
                                      style: const TextStyle(
                                          color:  AppColors.color_black_80_2,
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 10.0
                                      )
                                  ),
                                  Container(height: 6,),

                                  Text(
                                      "Andi Ruhiyat",
                                      style: const TextStyle(
                                          color:  AppColors.primaryText,
                                          fontWeight: FontWeight.w700,
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 14.0
                                      )
                                  ),
                                  Container(height: 6,),
                                  Text(
                                      "Eggs, Flour, Water Gallon…",
                                      style: const TextStyle(
                                          color:  AppColors.battleship_grey,
                                          fontWeight: FontWeight.w400,
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 12.0
                                      )
                                  )
                                ],
                              ) ,
                            ),
                          ]),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 0),
                        child:  RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      style: const TextStyle(
                                          color:  AppColors.pale_turquoise,
                                          fontWeight: FontWeight.w700,
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 14.0
                                      ),
                                      text: "+ "),
                                  TextSpan(
                                      style: const TextStyle(
                                          color:  AppColors.fareColor,
                                          fontWeight: FontWeight.w400,
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 14.0
                                      ),
                                      text: "Rp 335.750")
                                ]
                            )
                        ),
                      )
                    ],
                  ),
                )
                ,
              ),
            );
          },
        ),
      );
    }else if(isTapOnIndex2){
      // inProgress
      return Container(
        margin: EdgeInsets.only(bottom: 32,top: 32),
        padding: EdgeInsets.only(left: 32,right: 32),

        child: Column(
          children: [
            Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                    color: AppColors.light_grey_blue,
                    borderRadius: Radii.border(44)
                )
            ),
            Container(height: 8,),
            Text(
                getTranslation(Strings.NO_PROGRESS_YET),
                style: const TextStyle(
                    color:  AppColors.primaryText,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.0
                ),
                textAlign: TextAlign.center
            ),
            Container(height: 8,),
            Text(
                getTranslation(Strings.SEE_AVAIL_REQ),
                style: const TextStyle(
                    color:  AppColors.battleship_grey,
                    fontWeight: FontWeight.w400,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.center
            )
          ],
        ),
      );
    }else{
      // completed
      return Container(
        margin: EdgeInsets.only(bottom: 32),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context,index){
            return  Container(
              margin: EdgeInsets.only(left: 16, right: 16,top: 16),
              padding: EdgeInsets.all(16),
//                            height: 64,
              decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)
                  ),
                  boxShadow: Shadows.shadows_list ,
                  color: AppColors.primaryBackground
              ),
              child:Center(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rectangle
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(Assets.ic_person1,height: 40,width: 40,),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // TODAY • 12:33
                                Text(
                                    "TODAY • 12:33",
                                    style: const TextStyle(
                                        color:  AppColors.color_black_80_2,
                                        fontWeight: FontWeight.w500,
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 10.0
                                    )
                                ),
                                Container(height: 6,),

                                Text(
                                    "Andi Ruhiyat",
                                    style: const TextStyle(
                                        color:  AppColors.primaryText,
                                        fontWeight: FontWeight.w700,
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                    )
                                ),
                                Container(height: 6,),
                                Text(
                                    "Deposit: Rp 25.000.000",
                                    style: const TextStyle(
                                        color:  AppColors.battleship_grey,
                                        fontWeight: FontWeight.w400,
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 12.0
                                    )
                                )
                              ],
                            ) ,
                          ),
                        ]),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 0),
                      child:  RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    style: const TextStyle(
                                        color:  AppColors.pale_turquoise,
                                        fontWeight: FontWeight.w700,
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                    ),
                                    text: "+ "),
                                TextSpan(
                                    style: const TextStyle(
                                        color:  AppColors.fareColor,
                                        fontWeight: FontWeight.w400,
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                    ),
                                    text: "Rp 335.750")
                              ]
                          )
                      ),
                    )
                  ],
                ),
              )
              ,
            );
          },
        ),
      );
    }
  }
}
