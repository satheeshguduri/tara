import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/widgets/custom_button.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';

class MerchantHomeScreen extends StatefulWidget {
  MerchantHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MerchantHomeScreenState createState() => MerchantHomeScreenState();
}

class MerchantHomeScreenState extends State<MerchantHomeScreen> {

  bool isTapOnIndex1 = true;
  bool isTapOnIndex2 = false;
  bool isTapOnIndex3 = false;

  BoxDecoration roundedBoxDecoration(){
    return BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(20)
        ),
        boxShadow: [BoxShadow(
            color: const Color(0x1f000000),
            offset: Offset(0,4),
            blurRadius: 6,
            spreadRadius: 0
        ), BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0,0),
            blurRadius: 2,
            spreadRadius: 0
        )] ,
        color: AppColors.primaryBackground
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar:SafeArea(
        bottom: true,
        child:Container(
          height: 84,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 28,
                right: 0,
                bottom: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primaryElement,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(36, 0, 0, 0),
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Container(),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 76,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                              ),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      margin: EdgeInsets.only(top: 8),
                                      child: Image.asset(
                                        Assets.ic_home,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(left: 21, right: 21, bottom: 4),
                                    child: Text(
                                      "Home",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 76,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      margin: EdgeInsets.only(top: 8),
                                      child: Image.asset(
                                        Assets.ic_chat,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 4),
                                    child: Text(
                                      "Chat",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 76,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      margin: EdgeInsets.only(top: 8),
                                      child: Image.asset(
                                        "assets/images/icon-24.png",
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 4),
                                    child: Text(
                                      "Accounts",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 76,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      margin: EdgeInsets.only(top: 8),
                                      child: Image.asset(
                                        Assets.ic_settings,
                                        fit: BoxFit.none,
                                        color: AppColors.ternaryBackground,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 4),
                                    child: Text(
                                      "Settings",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            right: 0,
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
                              child: Container(),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 13,
                            right: 10,
                            child: Image.asset(
                              Assets.ic_Scan,
                              fit: BoxFit.none,
                            ),
                          ),
                        ],
                      ),
                    ),
//                  Spacer(),
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Scan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) ,

      ),
        body: SafeArea(
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8)
                              ),
                              gradient: Gradients.primaryGradient
                          ),
                          child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity : 0.6,
                                child:   Text(
                                    "Available Balance",
                                    style: const TextStyle(
                                        color:  AppColors.primaryText,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "SctoGroteskA",
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
                                            fontFamily: "SctoGroteskA",
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
                                          boxShadow: [BoxShadow(
                                              color: const Color(0x1f000000),
                                              offset: Offset(0,4),
                                              blurRadius: 6,
                                              spreadRadius: 0
                                          ), BoxShadow(
                                              color: const Color(0x14000000),
                                              offset: Offset(0,0),
                                              blurRadius: 2,
                                              spreadRadius: 0
                                          )] ,
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
                                                  "Incoming",
                                                  style: const TextStyle(
                                                      color:  AppColors.primaryText,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "SctoGroteskA",
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
                                                  fontFamily: "SctoGroteskA",
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
                                          boxShadow: [BoxShadow(
                                              color: const Color(0x1f000000),
                                              offset: Offset(0,4),
                                              blurRadius: 6,
                                              spreadRadius: 0
                                          ), BoxShadow(
                                              color: const Color(0x14000000),
                                              offset: Offset(0,0),
                                              blurRadius: 2,
                                              spreadRadius: 0
                                          )] ,
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
                                                  "Outgoing",
                                                  style: const TextStyle(
                                                      color:  AppColors.primaryText,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "SctoGroteskA",
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
                                                  fontFamily: "SctoGroteskA",
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
                                  "Orders",
                                  style: const TextStyle(
                                      color:  AppColors.fareColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "SctoGroteskA",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 20.0
                                  )
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                    child:Text(
                                        "SEE ALL",
                                        style: const TextStyle(
                                            color:  AppColors.fareColor,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "SctoGroteskA",
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(24)
                              ),
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
                                              "New",
                                              style: const TextStyle(
                                                  color:  AppColors.primaryText,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "SctoGroteskA",
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 14.0
                                              ),
                                              textAlign: TextAlign.center
                                          ),
                                          isTapOnIndex1 ? Container(
                                            margin: EdgeInsets.only(left: 4),
                                            alignment: Alignment.center,
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                                color: const Color(0xfff95074),
                                                borderRadius:BorderRadius.circular(8)
                                            ),
                                            child: Text(
                                                "3",
                                                style: const TextStyle(
                                                    color:  const Color(0xffffffff),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Roboto",
                                                    fontStyle:  FontStyle.normal,
                                                    fontSize: 10.0
                                                ),
                                                textAlign: TextAlign.center
                                            ),
                                          ) : Container()
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
                                          "In Progress",
                                          style: const TextStyle(
                                              color:  AppColors.primaryText,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "SctoGroteskA",
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
                                          "Completed",
                                          style: const TextStyle(
                                              color:  AppColors.primaryText,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "SctoGroteskA",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.center
                                      ),
                                    )
                                ) ,
                              )

                              ,
                            ],
                          ),
                        ),
                        Container(
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
                                    boxShadow: [BoxShadow(
                                        color: const Color(0x1f000000),
                                        offset: Offset(0,4),
                                        blurRadius: 6,
                                        spreadRadius: 0
                                    ), BoxShadow(
                                        color: const Color(0x14000000),
                                        offset: Offset(0,0),
                                        blurRadius: 2,
                                        spreadRadius: 0
                                    )] ,
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
                                                          color:  const Color(0xff889aac),
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: "SctoGroteskA",
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
                                                          fontFamily: "SctoGroteskA",
                                                          fontStyle:  FontStyle.normal,
                                                          fontSize: 14.0
                                                      )
                                                  ),
                                                  Container(height: 6,),
                                                  Text(
                                                      "Eggs, Flour, Water Gallon…",
                                                      style: const TextStyle(
                                                          color:  Color(0Xff697683),
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Roboto",
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
                                                          color:  const Color(0xff4afbc3),
                                                          fontWeight: FontWeight.w700,
                                                          fontFamily: "Roboto",
                                                          fontStyle:  FontStyle.normal,
                                                          fontSize: 14.0
                                                      ),
                                                      text: "+ "),
                                                  TextSpan(
                                                      style: const TextStyle(
                                                          color:  const Color(0xff123456),
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Roboto",
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
                        )
                      ],
                    ),
                  ))

                ],
              )


          ) ,
        )
    );
  }
}
