


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';


class DeclinePay extends StatefulWidget {
  final bool isAgentUINCode;

  const DeclinePay( {
    Key key,
    this.isAgentUINCode=false,
  }) : super(key: key);

  @override
  _DeclinePayState createState() => _DeclinePayState();
}

class _DeclinePayState extends State<DeclinePay> {
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
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Column(
               children: [
                 Container(
                   height: 32,
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child: Container(
                       margin: EdgeInsets.only(right: 8,top: 12,bottom: 4),
                       child: Text(
                         Strings.TANIA_REQUESTED,
                         textAlign: TextAlign.left,
                         style: BaseStyles.agentConfirmedTextStyle,
                       ),
                     ),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(left: 16,right: 8,bottom: 8),
                   child:Text(
                       "Rp 100.000",
                       style: BaseStyles.agentUIN_OTP_CODE_TextStyle
                   ),
                 ),
               ],
             ),
             // Oval
             Container(
               margin: EdgeInsets.only(right: 8,),
               child: Opacity(
                 opacity : 0.6,
                 child: Container(
                     width: 46,
                     height: 46,
                     decoration: BoxDecoration(
                         gradient: LinearGradient(
                             begin: Alignment(0.9999999999999998, 0.49999999999999983),
                             end: Alignment(-2.220446049250313e-16, 0.5000000000000002),
                             colors: [Color(0xffb2f7e2), const Color(0xffa1f0f8)])
                     )
                 ),
               ),
             )
           ],
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
                "“Buat patungan kado Bambang”",
                style: BaseStyles.saveToMyContactTextStyle
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding:  EdgeInsets.only(bottom: 8,top: 8),
                  margin: EdgeInsets.only(right: 8),
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
                          Strings.DECLINE,
                          style: BaseStyles.chatItemButtonTextStyle
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding:  EdgeInsets.only(bottom: 8,top: 8),
                  margin: EdgeInsets.only(left: 8,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)
                        ),
                        border: Border.all(
                            color: const Color(0xffb2f7e2),
                            width: 1
                        ),
                        color: const Color(0xffb2f7e2)
                    ),
                    child: Center(
                      child: Text(
                          Strings.Pay,
                          style: BaseStyles.chatItemButtonTextStyle
                      ),
                    ),
                  ),
                )
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