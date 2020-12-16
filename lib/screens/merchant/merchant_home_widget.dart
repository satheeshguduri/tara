import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/screens/agent/balance_history.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/common/constants/values.dart';

class MerchantHomeWidget extends StatefulWidget{

  @override
  MerchantHomeWidgetState createState() => MerchantHomeWidgetState();


}

class MerchantHomeWidgetState extends BaseState<MerchantHomeWidget>{

  bool isTapOnIndex1 = true;
  bool isTapOnIndex2 = false;
  bool isTapOnIndex3 = false;

  OrderController controller = Get.find();

  @override
  void init() {
    // TODO: implement init
    super.init();
    controller.getMerchantOrders();
  }

@override
  void initState(){
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
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
                                  child: InkWell(
                                    child:Column(
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
                                    ) ,
                                    onTap: (){
                                      push(BalanceHistory(selectedIndex: 0, fromScreen: "merchant"));
                                    },
                                  ),

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
                                  child: InkWell(
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
                                    ),
                                    onTap: (){
                                      push(BalanceHistory(selectedIndex: 1,fromScreen: "merchant"));
                                    },
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
    ).withProgressIndicator(showIndicator: controller.showProgress.value);
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  Widget getBottomView(){
    if(isTapOnIndex1){
      // New
      if(controller.orderList.length != 0){
        return Container(
          margin: EdgeInsets.only(bottom: 32),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.orderList.length,
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
                                        controller.orderList[index].orderDate.toString(),
//                                        "TODAY • 12:33",
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
      }
      return Container();
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

  BoxDecoration roundedBoxDecoration(){
    return BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(20)
        ),
        boxShadow: Shadows.shadows_list ,
        color: AppColors.primaryBackground
    );
  }



}