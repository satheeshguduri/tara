import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgenttHomeScreen extends StatefulWidget {
  AgenttHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AgentHomeScreenState createState() => AgentHomeScreenState();
}

class AgentHomeScreenState extends BaseState<AgenttHomeScreen> {


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
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar:getBottomNavigation(),
        floatingActionButton: FloatingActionButton(
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
                    height: 230,
                    child: HomeTopBar(appName: "Agent",),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16,top: 16),
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
//                                                  width: 140,
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
                      ) )

                ],
              )



          ) ,
        )

    );
  }
}
