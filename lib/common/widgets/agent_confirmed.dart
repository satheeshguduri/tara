


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';


class AgentConfirmed extends StatefulWidget {
  final bool isArrived;

  const AgentConfirmed( {
    Key key,
    this.isArrived=false,
  }) : super(key: key);

  @override
  _AgentConfirmedState createState() => _AgentConfirmedState();
}

class _AgentConfirmedState extends State<AgentConfirmed> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
//      padding: EdgeInsets.all(8),
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
                margin: EdgeInsets.only(left: 16,right: 8),
                child: Text(
                  Strings.AGENT_CONFIRMED,
                  textAlign: TextAlign.left,
                  style: BaseStyles.agentConfirmedTextStyle,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 8,bottom: 8),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/avatar-11.png",
                  height: 32,
                  width: 32,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Pasek Sujana",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          "ID No.324 567",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemDateTextStyle,
                        ),
                      ),
                    ],
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
    );
  }

}
