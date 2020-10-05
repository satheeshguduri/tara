


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';


class AgentUINOROTP extends StatefulWidget {
  final bool isAgentUINCode;

  const AgentUINOROTP( {
    Key key,
    this.isAgentUINCode=false,
  }) : super(key: key);

  @override
  _AgentUINOROTPState createState() => _AgentUINOROTPState();
}

class _AgentUINOROTPState extends State<AgentUINOROTP> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 16,right: 8,top: 12,bottom: 4),
                child: Text(
                  widget.isAgentUINCode?Strings.AGENT_UIN_CODE:Strings.YOUR_OTP_CODE,
                  textAlign: TextAlign.left,
                  style: BaseStyles.agentConfirmedTextStyle,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 8,bottom: 8),
            child:Text(
                widget.isAgentUINCode?"TAR112322421":"133-252",
                style: BaseStyles.agentUIN_OTP_CODE_TextStyle
            ),
          ),
          Container(
            padding:  EdgeInsets.only(bottom: 8,top: 8),
            margin: EdgeInsets.only(bottom: 8,left: 16,right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
                border: Border.all(
                    color: const Color(0xffb0b4c1),
                    width: 1
                ),
                color: const Color(0xffffffff)
            ),
            child: Center(
              child: Text(
                  widget.isAgentUINCode?Strings.CONFIRM_UIN_CODE:Strings.SHARE_TO_AGENT,
                  style: BaseStyles.chatItemButtonTextStyle
              ),
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
    );
  }

}
