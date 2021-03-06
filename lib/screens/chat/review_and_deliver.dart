
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/map_widget.dart';
import 'package:tara_app/controller/order_update_controller.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/models/order_management/orders/order.dart'
as OrderModel;
import 'package:tara_app/common/constants/values.dart';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/orders/order.dart'
as OrderModel;
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:async/async.dart';




class ReviewAndDeliver extends StatefulWidget {

 final String orderId;
  ReviewAndDeliver({Key key, this.orderId})
      : super(key: key);
  @override
  _ReviewAndDeliverState createState() => _ReviewAndDeliverState();

}

class _ReviewAndDeliverState extends BaseState<ReviewAndDeliver> {

  OrderUpdateController controller = OrderUpdateController();
//  OrderModel.Order order = OrderModel.Order();
//  List<OrderItems> arrItems = [];

  double positionX = 0;


  @override
  void init(){
    // TODO: implement init
    super.init();
    controller.getOrderByOrderId(widget.orderId);
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  void initState(){
    // TODO: implement initState
    super.initState();
//    if(order == null){
//      order =  controller.orderMerchat.value;
//      arrItems = order.items;
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
        top: false,
        child: Scaffold(
            backgroundColor: Color(0xfff7f7fa),
            appBar: _buildAppBar(context), // Custom app bar for chat screen
            body:SingleChildScrollView(
              child: Column(
                children: [
                  getItemsOrderTotalWidget(),
                  getIBillDetailsTotalWidget(),
                  getDeliveryInfoWidget()
                ],
              ),
            )
        )
    ).withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  AppBar _buildAppBar(BuildContext context) {
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

  Widget getItemsOrderTotalWidget()
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

  Widget getItemsListWidget()
  {
    return  Container(
        margin:
        EdgeInsets.only(left: 16, right: 16,top: 8,bottom: 8),
        color: Colors.transparent,
        height: (controller.arrItems!=null&&controller.arrItems.length>0)? (controller.arrItems.length * 50).toDouble() + 20:0,
        child: ListView.builder(
          itemBuilder: (context, index) => getOrderItemWidget(controller.arrItems[index]),
          itemCount: controller.arrItems.length,
          physics: NeverScrollableScrollPhysics(),
          padding:EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
        ));
  }

  Widget getOrderItemWidget(OrderItems itemOrderModel)
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
                          itemOrderModel.name ?? "",
                          style: BaseStyles.itemOrderTextStyle
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4,top: 4,right: 8),
                      child: Text(
                          "Rp " + itemOrderModel.price.toString() ?? "0.00",
                          style: BaseStyles.itemOrderCostTextStyle,
                          textAlign: TextAlign.right
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4,top: 4,right: 8),
                  child: Text(
                      itemOrderModel.quantity.toString() ?? "",
                      style: BaseStyles.itemOrderQuantityTextStyle
                  ),
                ),
              ],
            ),
          ],
        ));
  }
  Either<Failure,CustomerProfile> snapData;
  Widget getIBillDetailsTotalWidget()
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
                  getTranslation(Strings.order_id) + ": TR005523",
                  style: BaseStyles.itemOrderCostTextStyle
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.arrItems.length.toString() + " " + getTranslation(Strings.items),
                      style: BaseStyles.itemOrderCostTextStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Rp " + controller.orderMerchat.value.price.toString() ?? "0.0",
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
                      "Rp " + controller.orderMerchat.value.price.toString() ?? "0.0",
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

  Future<Either<Failure,CustomerProfile>> getSnapData() async{
    if(snapData!=null){
      return Future.value(snapData);
    }
    return await getIt.get<AuthRepository>().getCustomerInfoByFirebaseId(controller.orderMerchat.value.order_extra.data.customer_commid);
  }
  Widget getDeliveryInfoWidget(){

    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),

        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Text(
            getTranslation(Strings.delivery_info),
        style: BaseStyles.reviewAndConfirmHeaderTextStyle
    ),
    Container(
    height: 150,
    decoration: BoxDecoration(
    borderRadius: Radii.border(8)
    ),
    child: MapWidget(),
    ),

    FutureBuilder<Either<Failure,CustomerProfile>>(
    future:getSnapData(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              snapData = snapshot.data;
            Either<Failure,CustomerProfile> response = snapshot.data;
            if (response.isRight()) {
              CustomerProfile profile= response.getOrElse(() => null);
            return Container(
              margin: EdgeInsets.only(top: 16,bottom: 16),
              child:Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset(Assets.ic_person1),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                           profile?.firstName??"",
                          style: BaseStyles.reviewAndConfirmHeaderTextStyle
                      ),
                      Container(height: 4,),
                      Text(
                          profile?.mobileNumber??"000",
                          style: BaseStyles.placeholderStyle
                      )
                    ],
                  )
                ],
              ) ,
            );
            }else{
              getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(desc: "Error occurred"));
            }
         }
      }
    return const Center(child: BaseWidgets.getIndicator);
    }
    ),
    Text(
        getTranslation(Strings.address),
        style: const TextStyle(
        color:  const Color(0xff889aac),
        fontWeight: FontWeight.w500,

        fontSize: 12.0
        )
        ),
            Container(
            margin: EdgeInsets.only(top: 8,bottom: 8),
            child: Text(
            getOrderAddress(),
            style: const TextStyle(
            color:  AppColors.header_top_bar_color,
            fontWeight: FontWeight.w400,

            fontSize: 14.0
    )
    ),
    ),

    Container(
    margin: EdgeInsets.only(top: 16,bottom: 16),
    height: 40,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
    Radius.circular(8)
    ),
    color: const Color(0xffb2f7e2)
    ),
    child:  Stack(
    children: [
    Positioned(
    left: 0,
    right: 0,
    top: 12,
    bottom: 12,
    child: Text(
    getTranslation(Strings.confirm_delivery),
    style: const TextStyle(
    color:  AppColors.fareColor,
    fontWeight: FontWeight.w700,

    fontSize: 14.0
    ),
    textAlign: TextAlign.center
    ),
    ),
    Positioned(
    left: positionX,
    child:
    /*GestureDetector(
                    onHorizontalDragUpdate: (dragDetails) async{
                      double screenWidth = MediaQuery.of(context).size.width - 88;
                      double dragPos = dragDetails.globalPosition.dx;
                      if(dragPos >= screenWidth){
                        // push to confirm delivery
                        var orderTemp = controller.orderMerchat.value;
                        orderTemp.status = Statuses.IN_TRANSIT;
                        print(orderTemp.toJson().toString());
                        var response = await controller.updateOrder(orderTemp);
                        print("Order Status IN_TRANSIT and Updated");
                        pop();
                      }else{
                        setState(() {
                          positionX = dragPos;
                        });
                      }
                    },
                    child:*/Container(
    width: 56,
    height: 40,
    decoration: BoxDecoration(
    borderRadius: Radii.border(8),
    boxShadow: [BoxShadow(
    color: const Color(0x1f000000),
    offset: Offset(0,4),
    blurRadius: 6,
    spreadRadius: 0
    ), BoxShadow(
    color: const Color(0x14000000),
    offset: Offset(0,0),
    blurRadius: 2,
    spreadRadius: 0
    )] ,
    color: const Color(0xffffffff)
    ),
    child: Center(
    child: Image.asset(Assets.ic_right_arrow_long),
    ),
    ),
    ),
    // )
    ],
    ).onTap(onPressed: () async {

    var orderTemp = controller.orderMerchat.value;
    var orderRequest = controller.getOrderRequestFromOrderResponse(orderTemp);
    orderRequest.status = Statuses.IN_TRANSIT;
    print(orderRequest.toJson().toString());
    await controller.updateOrder(orderRequest);
    print("Order Status IN_TRANSIT and Updated");
    pop();
    }),
    )
    ],
    ),
    );
    }


  String getOrderAddress() {
    // if (controller.orderMerchat != null && controller.orderMerchat.value.deliveryAddress != null) {
    //   var address = controller.orderMerchat.value.deliveryAddress.first;
    //   return "${address.dno},${address.streetName},${address.city},${address.zipcode},${address.country}";
    // }
    return "show addrss here";
  }

}