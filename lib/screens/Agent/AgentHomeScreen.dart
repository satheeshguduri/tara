import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';

class AgenttHomeScreen extends StatefulWidget {
  AgenttHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AgentHomeScreenState createState() => AgentHomeScreenState();
}

class AgentHomeScreenState extends State<AgenttHomeScreen> {


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
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 230,
              child: HomeTopBar(),
            ),
            Container(
                margin: EdgeInsets.only(left: 16, right: 16,top: 64),
                padding: EdgeInsets.all(16),
                height: 152,
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
                  Text(
                      "Rp 1.256.000",
                      style: const TextStyle(
                          color:  AppColors.primaryText,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SctoGroteskA",
                          fontStyle:  FontStyle.normal,
                          fontSize: 24.0
                      )
                  ),
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
                                      "Today's Collection",
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
                                  "5 Collections",
                                  style: const TextStyle(
                                      color:  AppColors.primaryText,
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
                                    "Today’s Payout",
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
                                "Rp 450.000",
                                style: const TextStyle(
                                    color:  AppColors.primaryText,
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
                    "Request",
                    style: const TextStyle(
                        color:  AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SctoGroteskA",
                        fontStyle:  FontStyle.normal,
                        fontSize: 20.0
                    )
                ),
                Row(
                  children: [
                    Text(
                        "Accept Request",
                        style: const TextStyle(
                            color:  AppColors.primaryText,
                            fontWeight: FontWeight.w500,
                            fontFamily: "SctoGroteskA",
                            fontStyle:  FontStyle.normal,
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.right
                    ),
                    Switch(value: true,
                        activeColor: Colors.greenAccent,
                        onChanged: (bool){

                    })
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
                  Container(
                      width: 104,
                      height: 40,
                      decoration: roundedBoxDecoration(),
                    child:Center(
                      child: Text(
                          "Incoming",
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
                  ),
                  Container(
                      width: 104,
                      height: 40,
//                      decoration: roundedBoxDecoration(),
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
                  ),
                  Container(
                      width: 104,
                      height: 40,
//                      decoration: roundedBoxDecoration(),
                      child:Center(
                        child: Text(
                            "Complete",
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
                  ),
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
                  if(index == 0){
                    return Container(
                        margin: EdgeInsets.only(left: 16, right: 16,top: 16),

                        height: 184,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Rectangle
                                Container(
                                  width: 140,
                                  height: 52,
                                  margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                                  padding: EdgeInsets.only(left:16,right: 16,top: 8,bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)
                                      ),
                                      border: Border.all(
                                          color: AppColors.ternaryBackground,
                                          width: 1
                                      ),
                                      color: AppColors.primaryBackground
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Cash Deposit",
                                          style: const TextStyle(
                                              color:  Color(0Xff889aac),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "SctoGroteskA",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 12.0
                                          )
                                      ),
                                      Text(
                                          "Rp 1.000.000",
                                          style: const TextStyle(
                                              color:  AppColors.primaryText,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "SctoGroteskA",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 16.0
                                          )
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  height: 52,
                                  margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                                  padding: EdgeInsets.only(left:16,right: 16,top: 8,bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)
                                      ),
                                      border: Border.all(
                                          color: AppColors.ternaryBackground,
                                          width: 1
                                      ),
                                      color: AppColors.primaryBackground
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Commission",
                                          style: const TextStyle(
                                              color:  Color(0Xff889aac),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "SctoGroteskA",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 12.0
                                          )
                                      ),
                                      Text(
                                          "Rp 500.000",
                                          style: const TextStyle(
                                              color:  AppColors.primaryText,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "SctoGroteskA",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 16.0
                                          )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                              child:Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Rectangle
                                  Image.asset(Assets.ic_person1,height: 32,width: 32,),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                        Text(
                                            "Jl Kedoya Barat No.21-22, Jakarta Barat • 2 Km",
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
                                ],
                              ) ,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 0, right: 0,top: 16,bottom: 0),
                              child:Row(
                                children: [
                                  Flexible(
                                    child:Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(
                                              color: AppColors.ternaryBackground,
                                              offset: Offset(0,1),
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                          )] ,
                                          color: AppColors.primaryBackground,
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                                      ),
                                      child: // Text
                                      Center(child:
                                      Text(
                                          "Reject",
                                          style: const TextStyle(
                                              color:  Color(0Xfff95074),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "SctoGroteskA",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.center
                                      ))
                                      ,
                                    ) ,
                                  ),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Container(
                                          width: 164,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Color(0Xffb2f7e2),
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))
                                          ),
                                          child: Center(
                                            child: Text(
                                                "Accept",
                                                style: const TextStyle(
                                                    color:  AppColors.primaryText,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "SctoGroteskA",
                                                    fontStyle:  FontStyle.normal,
                                                    fontSize: 14.0
                                                ),
                                                textAlign: TextAlign.center
                                            ),
                                          )// Text
                                        // Text
                                      )),
                                ],
                              ) ,
                            )
                          ],
                        )
                    );
                  }else{
                    return  Container(
                      margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                      padding: EdgeInsets.all(16),
                      height: 64,
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
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Rectangle
                            Image.asset(Assets.ic_person1,height: 32,width: 32,),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  Text(
                                      "Jl Kedoya Barat No.21-22, Jakarta Barat • 2 Km",
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
                          ],
                        ),
                      )
                      ,
                    );
                  }
                },
              ),
            )
          ],
        ),
      )
    )
    );
  }
}
