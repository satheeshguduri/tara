import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_input_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_list_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class ReviewAndDeliver extends StatefulWidget {
  @override
  _ReviewAndDeliverState createState() => _ReviewAndDeliverState();
}

class _ReviewAndDeliverState extends BaseState<ReviewAndDeliver> {

  List<String> itemOrderList = ["Nanas", "Bengkoang", "Minyak Bimoli", "Telor Ayam"];
  List<String> itemOrderQuantityList = ["500gr", "200gr", "1", "0.5kg"];
  List<String> itemOrderCostList = ["Rp 10.000", "Rp 25.000", "Rp 17.000", "Rp 9.000"];
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
      itemOrderModel.cost = itemOrderCostList[i];
      arrItems.add(itemOrderModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Color(0xfff7f7fa),
            appBar: _buildAppBar(context), // Custom app bar for chat screen
            body:SingleChildScrollView(
              child: Column(
                children: [
                  getItemsOrderTotalWidget(),
                  getIBillDetailsTotalWidget()
                ],
              ),
            )
        )
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.review_and_deliver),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  getItemsOrderTotalWidget()
  {
    return Container(
      color: Colors.white,
      margin:
      EdgeInsets.only(bottom: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left:16,right: 16,top: 16),
            child: Text(
                getTranslation(Strings.items_ordered_small_letter),
                style: BaseStyles.reviewAndConfirmHeaderTextStyle
            ),
          ),
          getItemsListWidget()
        ],
      ),
    );
  }

  getItemsListWidget()
  {
    return  Container(
        margin:
        EdgeInsets.only(left: 16, right: 16,top: 8,bottom: 8),
        color: Colors.transparent,
        height: (arrItems!=null&&arrItems.length>0)? (arrItems.length * 50).toDouble() + 20:0,
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
        margin: EdgeInsets.only(top:4,bottom: 4,),
        child:Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4,top: 4,right: 8),
                      child: Text(
                          itemOrderModel.itemName,
                          style: BaseStyles.itemOrderTextStyle
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4,top: 4,right: 8),
                      child: Text(
                          itemOrderModel.cost,
                          style: BaseStyles.itemOrderCostTextStyle,
                          textAlign: TextAlign.right
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4,top: 4,right: 8),
                  child: Text(
                      itemOrderModel.quantity,
                      style: BaseStyles.itemOrderQuantityTextStyle
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  getIBillDetailsTotalWidget()
  {
    return Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4,top: 4),
            child: Text(
                getTranslation(Strings.bill_details),
                style: BaseStyles.reviewAndConfirmHeaderTextStyle
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(
                getTranslation(Strings.order_id) + " TR005523",
                style: BaseStyles.itemOrderCostTextStyle
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  arrItems.length.toString() + " " + getTranslation(Strings.items),
                  style: BaseStyles.itemOrderCostTextStyle,
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Rp 45.500",
                  style: BaseStyles.itemOrderCostTextStyle,
                  textAlign: TextAlign.right,
                ),
              ],
            )
          ),
          Container(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslation(Strings.delivery_fee),
                  style: BaseStyles.itemOrderCostTextStyle,
                  textAlign: TextAlign.right,
                ),
                Text(
                  "Rp 8.000",
                  style: BaseStyles.itemOrderCostTextStyle,
                  textAlign: TextAlign.right,
                ),
              ],
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 8,bottom: 8),
            height: 1,
            color: Colors.grey[200],
          ),
          Container(
              margin: EdgeInsets.only(bottom: 8),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslation(Strings.total),
                  style: BaseStyles.reviewAndConfirmHeaderTextStyle,
                  textAlign: TextAlign.right,
                ),
                Text(
                  "Rp 53.500",
                  style: BaseStyles.reviewAndConfirmHeaderTextStyle,
                  textAlign: TextAlign.right,
                ),
              ],
            )
          )
        ],
      )
    );
  }

}