import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/utils/locale/utils.dart';

class DeclinePay extends StatefulWidget {
  final bool isAgentUINCode;
  final bool isSender;
  final bool isDeclined;
  final Function onTapAction;

  const DeclinePay(
      {Key key,
      this.isAgentUINCode = false,
      this.isSender = false,
      this.isDeclined = false, this.onTapAction})
      : super(key: key);

  @override
  _DeclinePayState createState() => _DeclinePayState();
}

class _DeclinePayState extends State<DeclinePay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Expanded(
        child: Row(
          mainAxisAlignment: widget.isSender == true
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Container(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: widget.isDeclined
                                  ? Color(0x24000000)
                                  : Color(0x1f000000),
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
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 32,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 8, top: 12, bottom: 4, left: 16),
                                  child: Text(
                                    widget.isSender == false
                                        ? Utils().getTranslation(
                                            Strings.TANIA_REQUESTED, context)
                                        : widget.isDeclined
                                            ? Utils().getTranslation(
                                                Strings.REQUEST_DECLINED,
                                                context)
                                            : Utils().getTranslation(
                                                Strings.YOU_REQUESTED, context),
                                    textAlign: TextAlign.left,
                                    style: widget.isDeclined
                                        ? BaseStyles.error_text_style
                                        : BaseStyles.agentConfirmedTextStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: 8, bottom: 8),
                              child: Text("Rp 100.000",
                                  style: widget.isDeclined
                                      ? BaseStyles.requestNowTextStyle
                                      : BaseStyles.agentUIN_OTP_CODE_TextStyle),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                  height: 1,
                                  decoration:
                                      BoxDecoration(color: Color(0xffe9ecef))),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 8),
                              child: Text("“Buat patungan kado Bambang”",
                                  style: BaseStyles.saveToMyContactTextStyle),
                            ),
                            widget.isSender == false
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: InkWell(
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
                                                    Utils().getTranslation(
                                                        Strings.DECLINE, context),
                                                    style: BaseStyles
                                                        .chatItemButtonTextStyle),
                                              ),
                                            ),
                                            onTap: (){
                                              widget.onTapAction("decline");
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: InkWell(
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
                                                    Utils().getTranslation(
                                                        Strings.Pay, context),
                                                    style: BaseStyles
                                                        .chatItemButtonTextStyle),
                                              ),
                                            ),
                                            onTap: (){
                                              widget.onTapAction("pay");
                                            },
                                          )
                                          ,
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      DateFormat('dd MMM kk:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              1565888474278)),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    margin:
                                        EdgeInsets.only(bottom: 8.0, right: 8),
                                  )
                                ])
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
                                      bottomLeft: const Radius.circular(36.0),
                                    )),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 8,
                                    bottom: 4,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      Assets.RECEIVE_ICON,
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
                        )
                      ],
                    )),
              ),
              width: 230,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
            )
          ],
        ),
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    ));
  }
}
