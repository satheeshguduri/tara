import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/models/chat/order.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';

class OrderDetailsDeclinePay extends StatefulWidget {
  final Function(ChatAction) onTapAction;
  final Order order;

  const OrderDetailsDeclinePay(
      {Key key,this.onTapAction,this.order})
      : super(key: key);

  @override
  _OrderDetailsDeclinePayState createState() => _OrderDetailsDeclinePayState();
}

class _OrderDetailsDeclinePayState extends BaseState<OrderDetailsDeclinePay> {

  List<OrderItems> arrItems = [];

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arrItems = widget.order.items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Container(
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
                                  margin:
                                  EdgeInsets.only(bottom: 8, left: 16, right: 8,top: 16),
                                  child: Text(
                                    getTranslation(Strings.order_detail,).toUpperCase(),
                                    style: BaseStyles.itemOrderHeaderTextStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.only(left: 16, right: 8, bottom: 4,top:16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (arrItems!=null&&arrItems.length>0)?"${(arrItems.length)} Items":"Items",
                                        textAlign: TextAlign.left,
                                        style: BaseStyles.itemOrderCostTextStyle,
                                      ),
                                      Text(
                                        "Rp " + widget.order.total.toString(),
                                        textAlign: TextAlign.left,
                                        style: BaseStyles.itemOrderCostTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.only(left: 16, right: 8, bottom: 8,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getTranslation(Strings.delivery_fee),
                                        textAlign: TextAlign.left,
                                        style: BaseStyles.itemOrderCostTextStyle,
                                      ),
                                      Text(
                                        "Rp 0.000",
                                        textAlign: TextAlign.left,
                                        style: BaseStyles.itemOrderCostTextStyle,
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
                                  EdgeInsets.only(left: 16, right: 8, bottom: 8,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getTranslation(Strings.total),
                                        textAlign: TextAlign.left,
                                        style: BaseStyles.backAccountHeaderTextStyle,
                                      ),
                                      Text(
                                        "Rp " + widget.order.total.toString(),
                                        textAlign: TextAlign.left,
                                        style: BaseStyles.backAccountHeaderTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
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
                                                getTranslation(
                                                    Strings.DECLINE),
                                                style: BaseStyles
                                                    .declineButtonTextStyle),
                                          ),
                                        ).onTap(onPressed: (){
                                          widget.onTapAction(ChatAction.decline);
                                        }),
                                      ),
                                      Expanded(
                                        flex: 5,
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
                                                getTranslation(
                                                    Strings.Pay),
                                                style: BaseStyles
                                                    .chatItemButtonTextStyle),
                                          ),
                                        ).onTap(onPressed: (){
                                          widget.onTapAction(ChatAction.pay);
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          DateFormat('kk:mm').format(
                                              DateTime.fromMillisecondsSinceEpoch(
                                                  widget.order.timestamp)),
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
                                          Assets.ic_bag,
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
