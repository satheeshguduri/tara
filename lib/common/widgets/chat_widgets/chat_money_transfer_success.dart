import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';

class ChatMoneyTransferSuccess extends StatefulWidget {
  @override
  _ChatMoneyTransferSuccessState createState() => _ChatMoneyTransferSuccessState();
}

class _ChatMoneyTransferSuccessState extends BaseState<ChatMoneyTransferSuccess> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
      child:Expanded(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child:  Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x1f000000),
                            offset: Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: 0),
                        BoxShadow(
                            color: const Color(0x14000000),
                            offset: Offset(0, 0),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ],
                      color: AppColors.primaryBackground),
                  child:Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(right: 8,top: 12,bottom: 4,left: 16),
                                child: Text(getTranslation(Strings.YOU_TRANSFERED),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.agentConfirmedTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 8,bottom: 8),
                            child:Text(
                                "Rp 450.000",
                                style: BaseStyles.agentUIN_OTP_CODE_TextStyle
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    color: Color(0xffe9ecef)
                                )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16,top: 8),
                            child: Text(
                                "“Sushi yg kemarin on me ya. Thanks udah nalangin!”",
                                style: BaseStyles.saveToMyContactTextStyle
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child:InkWell(
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Image.asset(Assets.ic_download),
                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Container(
//                                                margin: EdgeInsets.only(left: 4),
                                                child: Text(getTranslation(Strings.DOWNLOAD).toUpperCase(),style: BaseStyles.chatItemButtonTextStyle,),
                                              ),
                                              Container(
                                                  width: 78,
                                                  height: 2,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.pale_turquoise
                                                  )
                                              )
                                            ],
                                          )
                                          ,
                                        ],
                                      ),
                                    ),
                                    onTap: (){

                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child:InkWell(
                                    child: Container(
//                                      margin: EdgeInsets.only(left: 8),
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Image.asset(Assets.ic_share),
                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Container(
//                                                margin: EdgeInsets.only(left: 4),
                                                child: Text(getTranslation(Strings.SHARE).toUpperCase(),style: BaseStyles.chatItemButtonTextStyle,),
                                              ),
                                              Container(
                                                  width: 46,
                                                  height: 2,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.pale_turquoise
                                                  )
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: (){

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    DateFormat('dd MMM kk:mm')
                                        .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  margin: EdgeInsets.only(bottom:8.0,right: 8),
                                )])
                        ],
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Opacity(
                            opacity : 0.6,
                            child: Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment(0.9999999999999998, 0.49999999999999983),
                                      end: Alignment(-2.220446049250313e-16, 0.5000000000000002),
                                      colors: [Color(0xffb2f7e2), const Color(0xffa1f0f8)]),
                                  borderRadius: new BorderRadius.only(
                                    bottomLeft: const Radius.circular(40.0),
                                  )
                              ),
                              child: Container(
                                margin: EdgeInsets.only(right: 8,bottom: 4,),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    Assets.SEND_ICON,
                                    fit: BoxFit.fill,
                                    color: AppColors.header_top_bar_color,
                                    width: 24, height: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
              width: 242,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
            )
          ],
        ),
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );

  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }
}
