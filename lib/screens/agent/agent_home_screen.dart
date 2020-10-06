import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgentHomeScreen extends StatefulWidget {
  AgentHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AgentHomeScreenState createState() => AgentHomeScreenState();
}

class AgentHomeScreenState extends BaseState<AgentHomeScreen> {
  int _currentIndex = 0;
  int selectedSegmentIndex = 0;

  BoxDecoration roundedBoxDecoration() {
    return BoxDecoration(
        borderRadius: Radii.border(20),
        boxShadow:Shadows.shadows_list ,
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
            icon: getTabImage(Assets.ic_home),
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
              child: getTabText(TabTitle.SCAN)),
        ),
        BottomNavigationBarItem(
          icon: getTabImage(Assets.ACCOUNTS_ACTIVE),
          activeIcon: getTabImage(Assets.ACCOUNTS_IN_ACTIVE),
          title: getTabText(TabTitle.ACCOUNTS),
        ),
        BottomNavigationBarItem(
            icon: getTabImage(Assets.ic_settings),
            activeIcon: getTabImage(Assets.ic_settings),
            title: getTabText(TabTitle.SETTINGS)),
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
        body: SafeArea(
          top: false,
          child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Container(
                    child: HomeTopBar(
                      appName: "Agent",
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                          padding: EdgeInsets.all(16),
                          height: 152,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              gradient: Gradients.primaryGradient),
                          child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: 0.6,
                                child: Text(getTranslation(Strings.AVAIL_BALANCE),
                                    style: const TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center),
                              ),
                              Text("Rp 1.256.000",
                                  style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24.0)),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      width: 146,
                                      height: 64,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          boxShadow: Shadows.shadows_list,
                                          color: AppColors.primaryBackground),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(getTranslation(Strings.TODAY_COLLECTION),
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12.0)),
                                              Icon(
                                                Icons.chevron_right,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          Text("5 Collections",
                                              style: const TextStyle(
                                                  color: AppColors.primaryText,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0))
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      width: 146,
                                      height: 64,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          boxShadow: Shadows.shadows_list,
                                          color: AppColors.primaryBackground),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(getTranslation(Strings.TODAY_PAYOUT),
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12.0)),
                                              Icon(
                                                Icons.chevron_right,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          Text("Rp 450.000",
                                              style: const TextStyle(
                                                  color: AppColors.primaryText,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0))
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getTranslation(Strings.REQUEST),
                                  style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20.0)),
                              Row(
                                children: [
                                  Text(getTranslation(Strings.ACCEPT_REQUEST),
                                      style: const TextStyle(
                                          color: AppColors.primaryText,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.right),
                                  Switch(
                                      value: true,
                                      activeColor: Colors.greenAccent,
                                      onChanged: (_) {})
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              color: const Color(0xfff7f7f7)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedSegmentIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      width: 104,
                                      height: 40,
                                      decoration: selectedSegmentIndex == 0 ? roundedBoxDecoration() : null,
                                      child:Center(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                            getTranslation(Strings.INCOMING),
                                                style: const TextStyle(
                                                    color:  AppColors.primaryText,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:  FontStyle.normal,
                                                    fontSize: 14.0
                                                ),
                                                textAlign: TextAlign.center
                                            ),
//                                            selectedSegmentIndex == 0 ?
                                            Container(
                                              margin: EdgeInsets.only(left: 4),
                                              alignment: Alignment.center,
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                  color: AppColors.badge_color,
                                                  borderRadius:BorderRadius.circular(8)
                                              ),
                                              child: Text(
                                                  "1",
                                                  style: const TextStyle(
                                                      color:  Color(0xffffffff),
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: 10.0
                                                  ),
                                                  textAlign: TextAlign.center
                                              ),
                                            )
//                                                : Container()
                                          ],
                                        ),
                                      )
                                  ) ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedSegmentIndex = 1;
                                    });
                                  },
                                  child: Container(
                                      width: 104,
                                      height: 40,
                                      decoration: selectedSegmentIndex == 1
                                          ? roundedBoxDecoration()
                                          : null,
                                      child: Center(
                                        child: Text(getTranslation(Strings.IN_PROGRESS),
                                            style: const TextStyle(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center),
                                      ))),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedSegmentIndex = 2;
                                    });
                                  },
                                  child: Container(
                                      width: 104,
                                      height: 40,
                                      decoration: selectedSegmentIndex == 2
                                          ? roundedBoxDecoration()
                                          : null,
                                      child: Center(
                                        child: Text(getTranslation(Strings.COMPLETE),
                                            style: const TextStyle(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center),
                                      ))),
                            ],
                          ),
                        ),
                        loadBottomView()
                      ],
                    ),
                  ))
                ],
              )),
        ));
  }

  Widget loadBottomView() {
    if (selectedSegmentIndex == 0) {
      return Container(
        margin: EdgeInsets.only(bottom: 32),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  height: 184,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: Shadows.shadows_list,
                      color: AppColors.primaryBackground),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Rectangle
                          Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 16),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    color: AppColors.ternaryBackground,
                                    width: 1),
                                color: AppColors.primaryBackground),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(getTranslation(Strings.CASH_DEPOSIT),
                                    style: const TextStyle(
                                        color: AppColors.color_black_80_2,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0)),
                                Text("Rp 1.000.000",
                                    style: const TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0))
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 16),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    color: AppColors.ternaryBackground,
                                    width: 1),
                                color: AppColors.primaryBackground),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(getTranslation(Strings.COMMISSION),
                                    style: const TextStyle(
                                        color: AppColors.color_black_80_2,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0)),
                                Text("Rp 500.000",
                                    style: const TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0))
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Rectangle
                            Image.asset(
                              Assets.ic_person1,
                              height: 32,
                              width: 32,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Andi Ruhiyat",
                                      style: const TextStyle(
                                          color: AppColors.primaryText,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0)),
                                  Text(
                                      "Jl Kedoya Barat No.21-22, Jakarta Barat • 2 Km",
                                      style: const TextStyle(
                                          color: AppColors.battleship_grey,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0, right: 0, top: 16, bottom: 0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.ternaryBackground,
                                        offset: Offset(0, 1),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    color: AppColors.primaryBackground,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8))),
                                child: // Text
                                    Center(
                                        child: Text(getTranslation(Strings.REJECT),
                                            style: const TextStyle(
                                                color: Color(0Xfff95074),
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center)),
                              ),
                            ),
                            Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                    width: 164,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0Xffb2f7e2),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8))),
                                    child: Center(
                                      child: Text(getTranslation(Strings.ACCEPT),
                                          style: const TextStyle(
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center),
                                    ) // Text
                                    // Text
                                    )),
                          ],
                        ),
                      )
                    ],
                  ));
            } else {
              return Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                padding: EdgeInsets.all(16),
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: Shadows.shadows_list,
                    color: AppColors.primaryBackground),
                child: Center(
                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rectangle
                      Image.asset(
                        Assets.ic_person1,
                        height: 32,
                        width: 32,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Andi Ruhiyat",
                                style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0)),
                            Text(
                                "Jl Kedoya Barat No.21-22, Jakarta Barat • 2 Km",
                                style: const TextStyle(
                                    color: AppColors.battleship_grey,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
    } else if (selectedSegmentIndex == 1) {
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
    } else if (selectedSegmentIndex == 2) {
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
    }else{
      return Container();
    }
  }
}
