import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/controller/order_update_controller.dart';
import 'package:tara_app/models/chat/order.dart' as ChatOrder;
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/screens/base/base_state.dart';

class OnDelivery extends StatefulWidget {

  final bool isConfirmArrived;
  final ChatOrder.Order order;
  final FromScreen fromScreen;
  const OnDelivery({
    Key key,
    this.order,
    this.fromScreen,
    this.isConfirmArrived = false,

  }) : super(key: key);

  @override
  _OnDeliveryState createState() => _OnDeliveryState();
}

class _OnDeliveryState extends BaseState<OnDelivery> {

  OrderUpdateController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
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
                                  getTranslation(Strings.on_delivery).toUpperCase()
                                      .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: BaseStyles.agentConfirmedTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                            child: Text(
                                getTranslation(Strings.on_delivery_text),
                                style: BaseStyles.chatItemSubTextStyle
                            ),
                          ),
                          Visibility(
                            visible:widget.fromScreen == FromScreen.consumer,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8, top: 8),
                              margin:
                              EdgeInsets.only(bottom: 16, left: 16, right: 16,top: 8),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color:widget.isConfirmArrived?Color(0xffb2f7e2):Color(0xffe9ecef),
                                      width: 1),
                                  color: widget.isConfirmArrived?Color(0xffb2f7e2):Color(0xffe9ecef)),
                              child: Center(
                                child: Text(
                                    widget.isConfirmArrived?getTranslation(
                                        Strings.confirm_arrived):getTranslation(
                                        Strings.order_delivered),// + " in 10:00",
                                    style:widget.isConfirmArrived?BaseStyles
                                        .chatItemButtonTextStyle:BaseStyles
                                        .chatItemResendOtpButtonTextStyle).onTap(onPressed: () async{
                                          if(widget.isConfirmArrived){
                                            var response = await orderController.getOrderByOrderId(widget.order.orderId);
                                            response.fold(
                                                    (l) => print(l.message),
                                                    (r) => {
                                                      print("Got the order Info"),
                                                      r.status = Statuses.DELIVERED,
                                                      orderController.updateOrder(r)
                                                });



                                          }
                                }),
                              ),
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
                                    Assets.ic_on_delivery,
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
