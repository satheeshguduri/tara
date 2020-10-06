
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/utils/locale/utils.dart';


class DepositSuccess extends StatefulWidget {
  const DepositSuccess( {
    Key key,
  }) : super(key: key);

  @override
  _DepositSuccessState createState() => _DepositSuccessState();
}

class _DepositSuccessState extends State<DepositSuccess> {
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
                  Utils().getTranslation(Strings.DEPOSIT_SUCCESS,context),
                  textAlign: TextAlign.left,
                  style: BaseStyles.chatItemHeaderTextStyle,
                ),
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(left: 8,right: 16,top: 4,bottom: 4),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: new BoxDecoration(
                      color: Color(0xffd8d8d8),
                      shape: BoxShape.circle,
                    ),
                    child:Container()),
              ),
          Expanded(
            flex: 8,
            child: Container(
                  margin: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                  child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                style: BaseStyles.chatItemDepositSuccessMoneyTextStyle,
                                text: "Rp 500.000 "),
                            TextSpan(
                                style: BaseStyles.chatItemDepositSuccessTextStyle,
                                text: "has been deposited to your Tara wallet.")
                          ]
                      )
                  )
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
