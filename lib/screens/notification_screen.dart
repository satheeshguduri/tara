import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';

import 'base/base_state.dart';

class NotificationScreen extends StatefulWidget{

  @override
  NotificationState createState() => NotificationState();

}

class NotificationState extends BaseState<NotificationScreen>{


  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        child: _getBodyContent(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: Visibility(
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.notifications),
          style: TextStyles.headline6222,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right:16),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslation(Strings.mark_all_read),style: TextStyles.bUTTONBlack222),
                Container(
                    width: 117,
                    height: 2,
                    decoration: BoxDecoration(
                        color: AppColors.pale_turquoise
                    )
                )
              ],
            ),
            onTap: (){

            },
          ),
        )

      ],
    );
  }

  _getBodyContent(){

    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          if(index == 0){
            return Column(
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 16),
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      getTranslation(Strings.recent),
                      style: TextStyles.subtitle2222
                  ),
                ),
                Divider(height: 2)
              ],
            );
          }else if(index == 1){
            return Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        color: AppColors.light_grey_bg_color,
                        offset: Offset(0,1),
                        blurRadius: 0,
                        spreadRadius: 0
                    )] ,
                    color: const Color(0xfffcf9f3)
                ),
                margin: EdgeInsets.only(bottom: 1),
                padding: EdgeInsets.only(top: 16,left: 16,bottom: 16,),
                child: Stack(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(Assets.ic_person1),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(
                            margin: EdgeInsets.only(left: 16,bottom: 16,right: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          "Today, 16:21",
                                          style: const TextStyle(
                                              color:  AppColors.color_black_80_2,
                                              fontWeight: FontWeight.w500,
                                              
                                              fontSize: 12.0
                                          )
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 8,bottom: 8),
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: Radii.border(3)
                                        )
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8,top: 8,right: 40),
                                  child: Text(
                                      "Transaction of BLIBLI was successful",
                                      style: const TextStyle(
                                          color:  AppColors.header_top_bar_color,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0
                                      )
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              style: const TextStyle(
                                                  color:  Colors.pink,
                                                  fontWeight: FontWeight.w400,
                                                  
                                                  fontSize: 14.0
                                              ),
                                              text: "- "),
                                          TextSpan(
                                              style: const TextStyle(
                                                  color:  AppColors.battleship_grey,
                                                  fontWeight: FontWeight.w400,
                                                  
                                                  fontSize: 14.0
                                              ),
                                              text: "Rp 1.350.000")
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),

                        ),
                      ],
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0.9999999999999998,
                                        0.49999999999999983),
                                    end: Alignment(-2.220446049250313e-16,
                                        0.5000000000000002),
                                    colors: [
                                      Color(0xffb2f7e2),
                                      const Color(0xffa1f0f8)
                                    ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(40.0),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 8,
                                bottom: 4,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  Assets.ic_bag,
                                  fit: BoxFit.fill,
                                  color: AppColors.header_top_bar_color,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          }else if(index == 2){
            return Container(
                margin: EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        color: AppColors.light_grey_bg_color,
                        offset: Offset(0,1),
                        blurRadius: 0,
                        spreadRadius: 0
                    )] ,
                    color: const Color(0xfffcf9f3)
                ),
                padding: EdgeInsets.only(top: 16,left: 16),
                child: Stack(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(Assets.ic_person1),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(
                            margin: EdgeInsets.only(left: 16,bottom: 16,right: 40),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          "Today, 12:33",
                                          style: const TextStyle(
                                              color:  AppColors.color_black_80_2,
                                              fontWeight: FontWeight.w500,
                                              
                                              fontSize: 12.0
                                          )
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 8,bottom: 8),
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: Radii.border(3)
                                        )
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8,top: 8),
                                  child: Text(
                                      "Candy requested Rp 100.000",
                                      style: const TextStyle(
                                          color:  AppColors.header_top_bar_color,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0
                                      )
                                  ),
                                ),
                                Text(
                                    "“Buat patungan kado Bambang”",
                                    style: const TextStyle(
                                        color:  AppColors.battleship_grey,
                                        fontWeight: FontWeight.w400,
                                        
                                        fontSize: 14.0
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 16, bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: 8, top: 8),
                                          margin: EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              border: Border.all(
                                                  color:
                                                  const Color(0xffb0b4c1),
                                                  width: 1),
                                              color: const Color(0xffffffff)),
                                          child: Center(
                                            child: Text(
                                                getTranslation(
                                                    Strings.DECLINE),
                                                style: TextStyles.bUTTONBlack222),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: 8, top: 8),
                                          margin: EdgeInsets.only(
                                            left: 8,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              border: Border.all(
                                                  color:
                                                  const Color(0xffb2f7e2),
                                                  width: 1),
                                              color: const Color(0xffb2f7e2)),
                                          child: Center(
                                            child: Text(
                                                getTranslation(
                                                    Strings.Pay),
                                                style: BaseStyles
                                                    .chatItemButtonTextStyle),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0.9999999999999998,
                                        0.49999999999999983),
                                    end: Alignment(-2.220446049250313e-16,
                                        0.5000000000000002),
                                    colors: [
                                      Color(0xffb2f7e2),
                                      const Color(0xffa1f0f8)
                                    ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(40.0),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 8,
                                bottom: 4,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  Assets.SHOP_ICON,
                                  fit: BoxFit.fill,
                                  color: AppColors.header_top_bar_color,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          }else if(index == 3){
            return Column(
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 16),
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "August",
                      style: TextStyles.subtitle2222
                  ),
                ),
                Divider(height: 2)
              ],
            );
          }else if(index == 4){
            return Container(
                margin: EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        color: AppColors.light_grey_bg_color,
                        offset: Offset(0,1),
                        blurRadius: 0,
                        spreadRadius: 0
                    )] ,
                    color: Colors.white
                ),
                padding: EdgeInsets.only(top: 16,left: 16),
                child: Stack(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(Assets.pln_notification),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(
                            margin: EdgeInsets.only(left: 16,bottom: 16,right: 40),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          "6 Aug, 08:12",
                                          style: const TextStyle(
                                              color:  AppColors.color_black_80_2,
                                              fontWeight: FontWeight.w500,
                                              
                                              fontSize: 12.0
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8,top: 8),
                                  child: Text(
                                      "Transaction of PLN Prepaid was successful",
                                      style: const TextStyle(
                                          color:  AppColors.header_top_bar_color,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0
                                      )
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              style: const TextStyle(
                                                  color:  Colors.pink,
                                                  fontWeight: FontWeight.w400,
                                                  
                                                  fontSize: 14.0
                                              ),
                                              text: "- "),
                                          TextSpan(
                                              style: const TextStyle(
                                                  color:  AppColors.battleship_grey,
                                                  fontWeight: FontWeight.w400,
                                                  
                                                  fontSize: 14.0
                                              ),
                                              text: "Rp 100.000")
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0.9999999999999998,
                                        0.49999999999999983),
                                    end: Alignment(-2.220446049250313e-16,
                                        0.5000000000000002),
                                    colors: [
                                      Color(0xffb2f7e2),
                                      const Color(0xffa1f0f8)
                                    ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(40.0),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 8,
                                bottom: 4,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  Assets.PLN_ICON,
                                  fit: BoxFit.fill,
                                  color: AppColors.header_top_bar_color,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          }else if(index == 5){
            return Container(
                margin: EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        color: AppColors.light_grey_bg_color,
                        offset: Offset(0,1),
                        blurRadius: 0,
                        spreadRadius: 0
                    )] ,
                    color: Colors.white
                ),
                padding: EdgeInsets.only(top: 16,left: 16),
                child: Stack(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(Assets.avatar11),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(
                            margin: EdgeInsets.only(left: 16,bottom: 16,right: 40),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          "6 Aug, 08:12",
                                          style: const TextStyle(
                                              color:  AppColors.color_black_80_2,
                                              fontWeight: FontWeight.w500,
                                              
                                              fontSize: 12.0
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8,top: 8),
                                  child: Text(
                                      "Agus just paid your request of Rp 20.000",
                                      style: const TextStyle(
                                          color:  AppColors.header_top_bar_color,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0.9999999999999998,
                                        0.49999999999999983),
                                    end: Alignment(-2.220446049250313e-16,
                                        0.5000000000000002),
                                    colors: [
                                      Color(0xffb2f7e2),
                                      const Color(0xffa1f0f8)
                                    ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(40.0),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 8,
                                bottom: 4,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  Assets.ic_download_1,
                                  fit: BoxFit.fill,
                                  color: AppColors.header_top_bar_color,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          }
          return Container();
        });
  }

}