import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/base/base_state.dart';

class ChatRequestCashDeposit extends StatefulWidget {
  final bool isConfirmed;
  final String requestedAmount;
  final Function onTapCancel;
  const ChatRequestCashDeposit(
      {Key key,
      this.isConfirmed = false,
      this.requestedAmount,
      this.onTapCancel})
      : super(key: key);

  @override
  _RequestCashDepositState createState() => _RequestCashDepositState();
}

class _RequestCashDepositState extends BaseState<ChatRequestCashDeposit> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Container(
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
                                  getTranslation(Strings.YOU_REQ_DEPOSITE)
                                      .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.agentConfirmedTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 8, bottom: 8),
                            child: Text(
                                (widget.requestedAmount != null)
                                    ? "Rp " + widget.requestedAmount + ".000"
                                    : "Rp 500.000",
                                style: BaseStyles.agentUIN_OTP_CODE_TextStyle),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(top: 8, bottom: 8),
                                    alignment: Alignment.center,
                                    width: 188,
                                    height: 32,
//                                  margin: EdgeInsets.only(left:16,right:16),
                                    decoration: BoxDecoration(
                                        borderRadius: Radii.border(8),
                                        border: widget.isConfirmed
                                            ? null
                                            : Border.all(
                                                color:
                                                    AppColors.light_grey_blue,
                                              ),
                                        color: widget.isConfirmed
                                            ? AppColors.light_grey_bg_color
                                            : const Color(0xffffffff)),
                                    child: Text(
                                      getTranslation(Strings.CANCEL_REQ),
                                      style: widget.isConfirmed
                                          ? BaseStyles.requestNowTextStyle
                                          : BaseStyles
                                              .cancel_request_text_style,
                                    )),
                                onTap: () {
                                  widget.onTapCancel("cancel_Req");
                                },
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    DateFormat('kk:mm aa').format(
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
                                    Assets.ic_cash_deposit,
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
