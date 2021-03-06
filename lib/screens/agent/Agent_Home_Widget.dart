import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/screens/agent/agent_widgets/agent_inprogress_handshake.dart';
import 'package:tara_app/screens/base/base_state.dart';

import 'agent_widgets/agent_empty_inprogress.dart';
import 'agent_widgets/agent_inprogress_transaction.dart';
import 'agent_widgets/agent_prepair_to_collect_cash.dart';
import 'balance_history.dart';

class AgentHomeWidget extends StatefulWidget{

  @override
  AgentHomeWidgetState createState() => AgentHomeWidgetState();
}

class AgentHomeWidgetState extends BaseState<AgentHomeWidget>{

  int selectedSegmentIndex = 0;
  bool isAccepted = false;
  bool isHandShake = false;
  bool isConfirmHandShake = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
            SafeArea(
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
                                child: Text(
                                    getTranslation(Strings.AVAIL_BALANCE),
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
                                      child: InkWell(
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
                                                Text(
                                                    getTranslation(
                                                        Strings.TODAY_COLLECTION),
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
                                        ),
                                        onTap: (){
                                          push(BalanceHistory(selectedIndex: 0,));
                                        },
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      width: 146,
                                      height: 64,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          boxShadow: Shadows.shadows_list,
                                          color: AppColors.primaryBackground),
                                      child: InkWell(
                                        child:Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    getTranslation(
                                                        Strings.TODAY_PAYOUT),
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
                                        ) ,
                                        onTap: (){
                                          push(BalanceHistory(selectedIndex: 1,));
                                        },
                                      )

                                  ),
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
                                      decoration: selectedSegmentIndex == 0
                                          ? roundedBoxDecoration()
                                          : null,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                getTranslation(
                                                    Strings.INCOMING),
                                                style: const TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.center),
//                                            selectedSegmentIndex == 0 ?
                                            Container(
                                              margin: EdgeInsets.only(left: 4),
                                              alignment: Alignment.center,
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                  color: AppColors.badge_color,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text("1",
                                                  style: const TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 10.0),
                                                  textAlign: TextAlign.center),
                                            )
//                                                : Container()
                                          ],
                                        ),
                                      ))),
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
                                        child: Text(
                                            getTranslation(Strings.IN_PROGRESS),
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
                                        child: Text(
                                            getTranslation(Strings.COMPLETE),
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
        );
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
                                      "Jl Kedoya Barat No.21-22, Jakarta Barat ??? 2 Km",
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
                                    child: Text(
                                        getTranslation(Strings.REJECT),
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
                                    child: InkWell(
                                      child: Center(
                                        child: Text(
                                            getTranslation(Strings.ACCEPT),
                                            style: const TextStyle(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isAccepted = true;
                                          selectedSegmentIndex = 1;
                                        });
                                      },
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
                                "Jl Kedoya Barat No.21-22, Jakarta Barat ??? 2 Km",
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
      if (isHandShake) {
        return AgentInProgressHandShake(confirmHandShake: (){
          setState(() {
            isHandShake = false;
            isConfirmHandShake = true;
          });
        });
      }
      if (isConfirmHandShake){
        return AgentInProgressTransaction(
          tapOnConfirm: (){
            setState(() {
              isAccepted = false;
              isHandShake = false;
              isConfirmHandShake = false;
              selectedSegmentIndex = 2;
            });
          },
          tapOnDecline: (){
            setState(() {
              isHandShake = true;
              isConfirmHandShake = false;
            });
          },
        );
      }
      if (isAccepted) {
        return AgentPrepareToCollectCash(confirmDelivery: () {
          setState(() {
            isHandShake = true;
          });
        });
      } else {
        return AgentEmptyInProgress();
      }
    } else if (selectedSegmentIndex == 2) {
      return Container(
        margin: EdgeInsets.only(bottom: 32),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              padding: EdgeInsets.all(16),
//                            height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: Shadows.shadows_list,
                  color: AppColors.primaryBackground),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rectangle
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        Assets.ic_person1,
                        height: 40,
                        width: 40,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TODAY ??? 12:33
                            Text("TODAY ??? 12:33",
                                style: const TextStyle(
                                    color: AppColors.color_black_80_2,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0)),
                            Container(
                              height: 6,
                            ),

                            Text("Andi Ruhiyat",
                                style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0)),
                            Container(
                              height: 6,
                            ),
                            Text("Deposit: Rp 25.000.000",
                                style: const TextStyle(
                                    color: AppColors.battleship_grey,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0))
                          ],
                        ),
                      ),
                    ]),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 0),
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                style: const TextStyle(
                                    color: AppColors.pale_turquoise,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                                text: "+ "),
                            TextSpan(
                                style: const TextStyle(
                                    color: AppColors.fareColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                                text: "Rp 335.750")
                          ])),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  BoxDecoration roundedBoxDecoration() {
    return BoxDecoration(
        borderRadius: Radii.border(20),
        boxShadow: Shadows.shadows_list,
        color: AppColors.primaryBackground);
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }



}