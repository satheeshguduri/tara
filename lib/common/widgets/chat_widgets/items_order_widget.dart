import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/models/chat/order.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/review_and_confirm.dart';
import 'package:tara_app/screens/chat/review_and_deliver.dart';

class ItemsOrder extends StatefulWidget {

  final bool isFromAcceptedOrder;
  final bool isFromCancelledOrder;
  final bool isFromCancelledOrderByStore;
  final Function onTapAction;
  final bool selfOrder;
  final Order order;
  final FromScreen fromScreen;
  const ItemsOrder({
    this.isFromAcceptedOrder=false,
    this.onTapAction,
    this.selfOrder = false,
    this.order,
    this.fromScreen,
    this.isFromCancelledOrder=false,
    this.isFromCancelledOrderByStore=false,
    Key key,
  }) : super(key: key);

  @override
  _ItemsOrderState createState() => _ItemsOrderState();
}

class _ItemsOrderState extends BaseState<ItemsOrder> {
  List<OrderItems> arrItems = [];

  @override
  BuildContext getContext() {
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
      alignment: widget.selfOrder ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                  EdgeInsets.only(bottom: 8, left: 16, right: 8,top: 16),
                  child: Text(
                    getTranslation(Strings.items_ordered,),
                    style: BaseStyles.itemOrderHeaderTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                (arrItems!=null&&arrItems.isNotEmpty)?getItemsListWidget():Container(),
                InkWell(
                  onTap: (){
                    if(widget.fromScreen == FromScreen.merchant){
                      if (widget.isFromAcceptedOrder==false){
                        push(ReviewAndConfirm(orderId: widget.order.orderId,callBackToConfirmOrder: (){
//                        widget.onTapAction(val);
                          push(ReviewAndDeliver());
                        },));
                      }
                    }else if(widget.fromScreen == FromScreen.consumer){
                      widget.onTapAction();
                    }
                    else{
                      widget.onTapAction(Strings.order_detail);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    margin:
                    EdgeInsets.only(bottom: 16, left: 8, right: 8,top: 8),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: widget.selfOrder ? AppColors.light_grey_bg_color : widget.isFromAcceptedOrder?const Color(0xfff1e4c6):const Color(0xffb2f7e2), width: 1),
                        color: widget.selfOrder ? Colors.white : widget.isFromAcceptedOrder?const Color(0xfff1e4c6):const Color(0xffb2f7e2)),
                    child: Center(
                      child: Text(
                          widget.isFromCancelledOrderByStore ? getTranslation(
                              Strings.cancelled_order_by_store):
                          widget.isFromCancelledOrder ?getTranslation(
                              Strings.you_have_cancelled_order):widget.selfOrder ? getTranslation(Strings.see_order_details) :
                            widget.isFromAcceptedOrder ? getTranslation(
                              Strings.you_have_accepted_order):getTranslation(
                              Strings.review_and_confirm),
                          style: widget.isFromAcceptedOrder?BaseStyles.chatItemSubTextStyle:BaseStyles.chatItemButtonTextStyle),
                    ),
                  ),
                ),
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
                        margin: EdgeInsets.only(bottom: 8.0, right: 8),
                      )
                    ])
              ],
            ),
          ),
        ),
        width: 230,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }

  Widget getItemsListWidget()
  {
    var items = widget.order.items;
    return  Container(
        margin:
        EdgeInsets.only(bottom: 8, left: 8, right: 8,),
        color: Colors.transparent,
        height: (items?.isNotEmpty??false)? (items.length * 40).toDouble():0,
        child: ListView.builder(
          itemBuilder: (context, index) => getOrderItemWidget(items[index]),
          itemCount: items.length,
          physics: NeverScrollableScrollPhysics(),
          padding:EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
        ));
  }

  Widget getOrderItemWidget(OrderItems itemOrderModel)
  {
    return Container(
        height: 40,
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8,top: 8,left: 8,right: 8),
                  child: Text(
                      itemOrderModel.name,
                      style: BaseStyles.itemOrderTextStyle
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8,top: 8,right: 8),
                  child: Text(
                      itemOrderModel.quantity.toString(),
                      style: BaseStyles.itemOrderQuantityTextStyle
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 8,right: 8),
              height: 1,
              color: Color(0xffe9ecef),
            )
          ],
        ));
  }
}
class ItemOrderModel {
  String itemName;
  String quantity;
  String cost;
}


