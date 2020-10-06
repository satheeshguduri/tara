
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';


class OnTheWay extends StatefulWidget {
  final bool isArrived;
  final bool isVerifyingAgent;

  const OnTheWay( {
    Key key,
    this.isArrived=false,
    this.isVerifyingAgent=false
  }) : super(key: key);

  @override
  _OnTheWayState createState() => _OnTheWayState();
}

class _OnTheWayState extends State<OnTheWay> {
  @override
  Widget build(BuildContext context) {
    return Container(

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
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(8),
                    topRight:Radius.circular(8)
                ),
                color: AppColors.header_top_bar_color
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 8,right: 8),
                child: Text(
                  widget.isVerifyingAgent?Strings.VERIFYING_AGENT:widget.isArrived?Strings.AGENT_ARRIVED:Strings.AGENT_ON_THE_WAY,
                  textAlign: TextAlign.left,
                  style: BaseStyles.chatItemHeaderTextStyle,
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
              child: // Agent has Arrived
              Text(
                widget.isVerifyingAgent?Strings.VERIFYING_AGENT_SUBTEXT:widget.isArrived?Strings.AGENT_ARRIVED_SUBTEXT:Strings.AGENT_ON_THE_WAY_SUBTEXT,
                style: BaseStyles.chatItemSubTextStyle,
                maxLines: 3,
              )
          ),
          // Please input Agent’s
          (widget.isArrived||widget.isVerifyingAgent)?Container(
            padding:  EdgeInsets.only(bottom: 8,top: 8),
            margin: EdgeInsets.only(bottom: 8,left: 8,right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
                border: Border.all(
                    color: widget.isVerifyingAgent?Color(0xffe9ecef):const Color(0xffb0b4c1),
                    width: 1
                ),
                color: widget.isVerifyingAgent?Color(0xffe9ecef):const Color(0xffffffff)
            ),
            child: Center(
              child: Text(
                  widget.isVerifyingAgent?Strings.RESEND_OTP:Strings.ASK_FOR_UIN_CODE,
                  style: widget.isVerifyingAgent?BaseStyles.chatItemResendOtpButtonTextStyle:BaseStyles.chatItemButtonTextStyle
              ),
            ),
          ):Container(),
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
    );
  }
}
