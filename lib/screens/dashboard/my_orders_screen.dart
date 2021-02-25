


import 'package:flutter/material.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/fonts.dart';


class MyOrderScreen extends StatefulWidget{

  @override
  MyOrderScreenState createState() => MyOrderScreenState();
}

class MyOrderScreenState extends BaseState<MyOrderScreen>{

  OrderController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getConsumerOrders();

  }

  @override
  Widget build(BuildContext context) {
    return  Obx(() => SafeArea(
            child: getRootWidget()
            .withProgressIndicator(showIndicator: controller.showProgress.value),
      )
      );
  }


  Widget  getRootWidget() {
    return Scaffold(
        appBar: CustomAppBarWidget(title: "My Orders",addNewWidgetShow: false,),
        body: Container(
          margin: EdgeInsets.only(top: 16),
          child: ListView.builder(
              itemCount: controller.orderList.length,
              itemBuilder: (BuildContext context, int index) {
                var order = controller.orderList[index];
                return customListTile(order);
              }
          ),
        )
    );
  }

  Widget customListTile(var order) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: getDecoration(),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDateRow(order),
          SizedBox(height: 6),
          getShopNameRow(order),
          SizedBox(height: 12),
          getOrderDataRow(order)
        ],
      ),

    );
  }

 Decoration getDecoration() {
   return BoxDecoration(
       borderRadius: BorderRadius.all(
           Radius.circular(8)
       ),
       boxShadow: [BoxShadow(
           color: Color(0x1f000000),
           offset: Offset(0, 4),
           blurRadius: 6,
           spreadRadius: 0
       ), BoxShadow(
           color: Color(0x14000000),
           offset: Offset(0, 0),
           blurRadius: 2,
           spreadRadius: 0
       )
       ],
       color: AppColors.primaryBackground
   );
 }

Widget  getDateRow(var order) {
 return   Text(
     DateFormat('dd MMM yyyy • kk:mm').format(order
         .orderDate),
         style:BaseTextStyles.myOrdersDateTextStyle
 );
}

Widget getShopNameRow(var order) {

    return  Text(
        order.storeId.name,
        style: BaseStyles.bottomSheetTitleStyle
    );

}

Widget  getOrderDataRow(var order) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getItemsColumn(order),
        getOrderAgainWidget()
      ],
    );

}

Widget  getItemsColumn(var order) {
    return // 8 Items - Rp 180.000
      Text(
          order.items.length.toString() + " "+
             getTranslation(Strings.itemrp)+" " +
              order.price.toString(),
             style: BaseTextStyles.myOrdersItemsTextStyle
      );

}

Widget  getOrderAgainWidget() {
    return // Container
      Container(
        width: 88,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(6)
            ),
            color: AppColors.pale_turquoise
        ),
        child: Text(
            getTranslation(Strings.order_again),
            style: BaseStyles
                .shopPreviousOrderAgain
        ),
      ).onTap(onPressed: (){

      });

}
  @override
  BuildContext getContext() {
    return context;
  }



}