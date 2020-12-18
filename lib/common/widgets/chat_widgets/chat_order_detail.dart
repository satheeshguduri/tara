import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';

class ChatOrderDetail extends StatefulWidget {
  final Function onTapAction;
  const ChatOrderDetail({Key key,this.onTapAction}) : super(key: key);

  @override
  _ChatOrderDetailState createState() => _ChatOrderDetailState();
}

class _ChatOrderDetailState extends BaseState<ChatOrderDetail> {
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
                                  getTranslation(Strings.order_detail)
                                      .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.orderDetailsHeaderTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 8, bottom: 4,top:24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "4 Items",
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.placeholderStyle,
                                ),
                                Text(
                                  "Rp 120.500",
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.placeholderStyle,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 16, right: 8, bottom: 8,top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslation(Strings.delivery_fee),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.placeholderStyle,
                                ),
                                Text(
                                  "Rp 8.000",
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.placeholderStyle,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 16, right: 8, bottom: 8,top: 4),
                            height: 1,
                            color: AppColors.light_grey_bg_color,
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(left: 16, right: 8, bottom: 8,top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslation(Strings.total),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.orderTotalStyle,
                                ),
                                Text(
                                  "Rp 128.500",
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.orderTotalStyle,
                                )
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
                                    color: const Color(0xfff1e4c6),
                                    width: 1
                                ),
                                color: const Color(0x80f1e4c6)
                            ),
                            child: Center(
                              child: Text(
                                  getTranslation(
                                      Strings.trans_has_been_paid),
                                  style: BaseStyles.chatItemSubTextStyle),
                            ),
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
                                  color: AppColors.light_grey_bg_color,
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
                                    color: AppColors.uncheck_color,
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
