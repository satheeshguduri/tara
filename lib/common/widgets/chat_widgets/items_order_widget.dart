import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/models/chat/order.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/review_and_confirm.dart';
import 'package:tara_app/screens/chat/review_and_deliver.dart';
import 'package:tara_app/utils/locale/utils.dart';

class ItemsOrder extends StatefulWidget {

  final bool isFromAcceptedOrder;
  final Function onTapAction;
  final bool selfOrder;
  final Order orderId;
  const ItemsOrder({
    this.isFromAcceptedOrder=false,
    this.onTapAction,
    this.selfOrder = false,
    this.orderId,
    Key key,
  }) : super(key: key);

  @override
  _ItemsOrderState createState() => _ItemsOrderState();
}

class _ItemsOrderState extends BaseState<ItemsOrder> {

  List<String> itemOrderList = ["Nanas", "Bengkoang", "Minyak Bimoli", "Telor Ayam"];
  List<String> itemOrderQuantityList = ["500gr", "200gr", "1", "0.5kg"];
  List<ItemOrderModel> arrItems = [];


  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()
  {
    arrItems = [];
    for (var i = 0; i < itemOrderList.length; i++) {
      var itemOrderModel = ItemOrderModel();
      itemOrderModel.itemName = itemOrderList[i];
      itemOrderModel.quantity = itemOrderQuantityList[i];
      arrItems.add(itemOrderModel);
    }
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
                (arrItems!=null&&arrItems.length>0)?getItemsListWidget():Container(),
                InkWell(
                  onTap: (){
                    if (widget.isFromAcceptedOrder==false){
                      push(ReviewAndConfirm(callBackToConfirmOrder: (val){
                        widget.onTapAction(val);
                      },));
                    }else{
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
                          widget.selfOrder ? getTranslation(Strings.see_order_details) :
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

  getItemsListWidget()
  {
    return  Container(
        margin:
        EdgeInsets.only(bottom: 8, left: 8, right: 8,),
        color: Colors.transparent,
        height: (arrItems!=null&&arrItems.length>0)? (arrItems.length * 40).toDouble():0,
        child: ListView.builder(
          itemBuilder: (context, index) => getOrderItemWidget(arrItems[index]),
          itemCount: arrItems.length,
          physics: NeverScrollableScrollPhysics(),
          padding:EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
        ));
  }

  getOrderItemWidget(ItemOrderModel itemOrderModel)
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
                      itemOrderModel.itemName,
                      style: BaseStyles.itemOrderTextStyle
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8,top: 8,right: 8),
                  child: Text(
                      itemOrderModel.quantity,
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


