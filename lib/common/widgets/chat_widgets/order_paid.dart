import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/review_and_deliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';

class ChatOrderPaid extends StatefulWidget {
  final bool isFromOrderDelivered;
  const ChatOrderPaid({Key key,this.isFromOrderDelivered=false}) : super(key: key);

  @override
  _ChatOrderPaidState createState() => _ChatOrderPaidState();
}

class _ChatOrderPaidState extends BaseState<ChatOrderPaid> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                                  widget.isFromOrderDelivered?getTranslation(Strings.order_delivered)
                                      .toUpperCase():getTranslation(Strings.order_paid)
                                      .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.agentConfirmedTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 8,top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)
                                        ),
                                        border: Border.all(
                                            color: const Color(0xffe9ecef),
                                            width: 1
                                        ),
                                        color: const Color(0xffffffff),
                                    ),
                                  padding: EdgeInsets.only(top: 4,right: 12,left: 6,bottom: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          getTranslation(Strings.order_id),
                                          style: BaseStyles.itemOrderQuantityTextStyle
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        child: Text(
                                            "TR005523",
                                            style:BaseStyles.mobileNoTextStyle
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)
                                      ),
                                      border: Border.all(
                                          color: const Color(0xffe9ecef),
                                          width: 1
                                      ),
                                      color: const Color(0xffffffff)
                                  ),
                                  padding: EdgeInsets.only(top: 4,right: 12,left: 6,bottom: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.isFromOrderDelivered?getTranslation(Strings.total_earning):getTranslation(Strings.amount_paid),
                                          style: BaseStyles.itemOrderQuantityTextStyle
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        child: Text(
                                            "Rp 45.500",
                                            style:BaseStyles.mobileNoTextStyle
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 16, right: 8, bottom: 8,top: 8),
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: Radii.border(8),
                                border: Border.all(
                                    color: const Color(0xffb2f7e2),
                                    width: 1
                                ),
                                color: const Color(0xffb2f7e2)
                            ),
                            child: Center(
                              child: Text(
                                  getTranslation(
                                      Strings.review_and_deliver),
                                  style: BaseStyles.chatItemButtonTextStyle),
                            ),
                          ).onTap(onPressed: (){
                            push(ReviewAndDeliver());
                          }),
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
                                    bottomLeft: const Radius.circular(36.0),
                                  )),
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 8,
                                  bottom: 4,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.check,color: AppColors.header_top_bar_color,size: 24,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              width: 245,
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
