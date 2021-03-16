import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/controller/order_update_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/orders/order.dart'
    as OrderModel;
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/orders/order_response.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/review_and_deliver.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/utils/locale/utils.dart';

class MerchantReviewAndConfirmScreen extends StatefulWidget {
  final Function callBackToConfirmOrder;
  final  orderId;
  MerchantReviewAndConfirmScreen({Key key, this.callBackToConfirmOrder, this.orderId})
      : super(key: key);
  @override
  _MerchantReviewAndConfirmScreenState createState() => _MerchantReviewAndConfirmScreenState();
}

class _MerchantReviewAndConfirmScreenState extends BaseState<MerchantReviewAndConfirmScreen> {

  OrderResponse orderResponse;
  OrderUpdateController controller = OrderUpdateController();
  FocusNode deliveryFocusNode = FocusNode();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    super.initState();
    addListenersToRequiredTextField();
  }

  void addListenersToRequiredTextField() {
    deliveryFocusNode.addListener(() {
      bool hasFocus = deliveryFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  FutureBuilder getOrdersFuture() {
    return FutureBuilder<Either<Failure, OrderResponse>>(
      future: getIt.get<OrderRepository>().getOrderByOrderId(widget.orderId),
      builder:
          (context, AsyncSnapshot<Either<Failure, OrderResponse>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          if (snapshot.hasData) {
            Either<Failure, OrderResponse> result = snapshot.data;
            result.fold((l) => Text("Unable to fetch the Order details"),
                (r) => {orderResponse = r, controller.arrItems.value = orderResponse.items});
            return getPageContainer();
          }
          return Container();
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: BaseWidgets.getIndicator);
        }
      },
    );
  }

  Widget getPageContainer() {
    return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            getItemsOrderTotalWidget(),
            getDeliveryInfoWidget(),
            getDeliveryMethodWidget(),
            getBillingInfoWidget()
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7fa),
        appBar: _buildAppBar(context),
        body: Obx(
          () => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: controller.arrItems.length == 0
                    ? getOrdersFuture()
                    : getPageContainer(),
              ).withProgressIndicator(
                  showIndicator: controller.showProgress.value)),
        ));
  }

  Widget getItemsOrderTotalWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(getTranslation(Strings.items_ordered_small_letter),
                style: BaseStyles.reviewAndConfirmHeaderTextStyle),
          ),
          getItemsListWidget(),
          getEmptyItemOrderWidget(),
          getAddMoreItemWidget(),
        ],
      ),
    );
  }

  Widget getEmptyItemOrderWidget() {
    if (controller.arrEmptyOrder.length > 0) {
      return ListView.builder(
          itemCount: controller.arrEmptyOrder.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor))),
              child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(bottom: 4, top: 4, right: 8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.light_grey_blue))),
                            child: TextFieldWidget(
                              hint: getTranslation(Strings.item_name),
                              placeHolderStyle: BaseStyles.placeholderStyle,
                            )),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 4, top: 4, right: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  AppColors.light_grey_blue))),
                                  child: TextFieldWidget(
                                    hint: getTranslation(Strings.quantity),
                                    inputType: TextInputType.number,
                                    placeHolderStyle:
                                        BaseStyles.placeholderStyle,
                                  )),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 4, top: 4, right: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  AppColors.light_grey_blue))),
                                  child: TextFieldWidget(
                                    hint: getTranslation(Strings.price),
                                    placeHolderStyle:
                                        BaseStyles.placeholderStyle,
                                    inputType: TextInputType.number,
                                    onFieldSubmitted: (val) {},
                                    onChanged: (val) {},
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: InkWell(
                          child: Image.asset(Assets.ic_delete),
                          onTap: () {
                            if (controller.arrEmptyOrder.length > 0) {
                              controller.arrEmptyOrder.removeLast();
                            }
                          },
                        ),
                      )),
                ],
              ),
            );
          });
    } else {
      return Container();
    }
  }

  Widget getAddMoreItemWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      height: 40,
      decoration: BoxDecoration(
          borderRadius: Radii.border(8),
          border: Border.all(color: AppColors.light_grey_blue, width: 1),
          color: const Color(0xffffffff)),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.ic_plus,
              width: 20,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 8,
              ),
              child: Text(getTranslation(Strings.items_ordered_small_letter),
                  style: BaseStyles.reviewAndConfirmHeaderTextStyle),
            )
          ],
        ),
        onTap: () {
          controller.arrEmptyOrder.add("");
        },
      ),
    );
  }

  Widget getItemsListWidget() {
    return Container(
        color: Colors.transparent,
        child: ListView.builder(
          itemBuilder: (context, index) =>
              getOrderItemWidget(controller.arrItems[index], index),
          itemCount: controller.arrItems.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
        ));
  }

  Widget getOrderItemWidget(OrderItems itemOrderModel, int index) {
    controller.textCtrls.add(new TextEditingController());
    controller.textCtrls[index].text = itemOrderModel.price.toString();
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4, right: 8),
                    child: Text(itemOrderModel.name,
                        style: BaseStyles.itemOrderTextStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4, right: 8),
                    child: Text(itemOrderModel.quantity.toString(),
                        style: BaseStyles.itemOrderQuantityTextStyle),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 4, top: 4, right: 8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.light_grey_blue))),
                        child: TextField(
                          controller: controller.textCtrls[index],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.start,
                          style: BaseStyles.itemOrderCostTextStyle,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            itemOrderModel.price = double.parse(val);
                          },
                        )),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: InkWell(
                          child: Image.asset(Assets.ic_delete),
                          onTap: () {
                            controller.arrItems.removeAt(index);
                            controller.textCtrls.removeAt(index);
                          },
                        ),
                      )),
                ],
              ),
            )
          ],
        ));
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
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.review_and_confirm),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  Widget getDeliveryInfoWidget() {
    return Container(
      color: AppColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 8, top: 8),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Text(getTranslation(Strings.delivery_info),
              style: BaseStyles.reviewAndConfirmHeaderTextStyle),
        ),
        Container(
          height: 16,
        ),
        Text(getTranslation(Strings.RECIPIENT),
            style: const TextStyle(
                color:  Color(0xff889aac),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 12.0)),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          child: Text("Andi Ruhiyat",
              style: const TextStyle(
                  color: AppColors.header_top_bar_color,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0)),
        ),
        Container(
          height: 16,
        ),
        Text(getTranslation(Strings.PHONE_NUMBER),
            style: const TextStyle(
                color: Color(0xff889aac),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 12.0)),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          child: Text("082212345678",
              style: const TextStyle(
                  color: AppColors.header_top_bar_color,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0)),
        ),
        Container(
          height: 16,
        ),
        Text(getTranslation(Strings.address),
            style: const TextStyle(
                color: Color(0xff889aac),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 12.0)),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(getOrderAddress(),
              style: const TextStyle(
                  color: AppColors.header_top_bar_color,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0)),
        ),
        Container(
          height: 16,
        ),
      ]),
    );
  }

  Widget getDeliveryMethodWidget() {
    return Container(
      color: AppColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 8, top: 8),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(bottom: 16, top: 0),
          child: Text(getTranslation(Strings.delivery_method),
              style: BaseStyles.reviewAndConfirmHeaderTextStyle),
        ),
        Container(
//      margin:
//      EdgeInsets.only(left: 16, right: 16,top: 16,bottom: 16),
          decoration: BoxDecoration(
              borderRadius: Radii.border(8),
              border: Border.all(color: AppColors.fareColor, width: 1),
              color: const Color(0xffffffff)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: IconButton(
                    icon: Icon(Icons.radio_button_checked), onPressed: () {}),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(bottom: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(getTranslation(Strings.inhouse_delivery),
                          style: const TextStyle(
                              color: AppColors.header_top_bar_color,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                      Text(getTranslation(Strings.custom_deliver_fee),
                          style: const TextStyle(
                              color: AppColors.battleship_grey,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                      Container(
                          margin: EdgeInsets.only(bottom: 8, right: 8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.light_grey_blue))),
                          child: TextFieldWidget(
                            textController: controller.textDeliveryCtrl.value,
                            hint: "Rp 1.000",
                            placeHolderStyle: BaseStyles.placeholderStyle,
                            focusNode: deliveryFocusNode,
                            inputType: TextInputType.number,
                            onChanged: (val) {
                              // assign data to UI
                              updateOrderDetails();
                            },
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: Radii.border(8),
              border: Border.all(color: AppColors.light_grey_blue, width: 1),
              color: const Color(0xffffffff)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: IconButton(
                    icon: Icon(Icons.radio_button_unchecked), onPressed: () {}),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(bottom: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(getTranslation(Strings.others),
                          style: const TextStyle(
                              color: AppColors.header_top_bar_color,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                      Text(getTranslation(Strings.delivery_fee_paid_cash),
                          style: const TextStyle(
                              color: AppColors.battleship_grey,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void updateOrderDetails() {
    controller.deliveryCharge.value = controller.textDeliveryCtrl.value.text;
  }

  Widget getBillingInfoWidget() {
    return Container(
      color: AppColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 8, top: 8),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(bottom: 16, top: 0),
          child: Text(getTranslation(Strings.bill_details),
              style: BaseStyles.reviewAndConfirmHeaderTextStyle),
        ),
        Container(
            color: Colors.transparent,
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  getBillingItemWidget(controller.arrItems[index]),
              itemCount: controller.arrItems.length,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
            )),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Expanded(
              flex: 8,
              child: Text(getTranslation(Strings.subtotal),
                  style: BaseStyles.itemOrderTextStyle)),
          Expanded(
              flex: 2,
              child: Text("Rp " + controller.getSubTotal().toString(),
                  style: BaseStyles.itemOrderTextStyle)),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Expanded(
              flex: 8,
              child: Text(getTranslation(Strings.delivery_fee),
                  style: BaseStyles.itemOrderTextStyle)),
          Expanded(
              flex: 2,
              child: Text("Rp " + controller.deliveryCharge.value,
                  style: BaseStyles.itemOrderTextStyle)),
        ]),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 16),
          height: 1,
          color: AppColors.light_grey_bg_color,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 32),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(getTranslation(Strings.total),
                    style: BaseStyles.reviewAndConfirmHeaderTextStyle),
                Text("Rp " + controller.getTotal().toString(),
                    style: BaseStyles.reviewAndConfirmHeaderTextStyle)
              ]),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 32),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                        width: 156,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: Radii.border(8),
                            border: Border.all(
                                color: AppColors.light_grey_blue, width: 1),
                            color: const Color(0xffffffff)),
                        child: Text(getTranslation(Strings.decline_order),
                            style: TextStyle(
                                color: const Color(0xfff95074),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)))
                    .onTap(onPressed: () async {

//                  order.tax = double.parse(controller.deliveryCharge.value);
//                   print(orderResponse.toJson().toString());

                  var request = controller.getOrderRequestFromOrderResponse(orderResponse);
                  request.status = Statuses.CANCELLED;
                  request.price = controller.getTotal();
                  var response = await controller.updateOrder(request);
                  response.fold(
                      (l) => showToast(message:l.message), (r) => Navigator.pop(context, false));
                }),
                Container(
                        width: 156,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: Radii.border(8),
                            color: Color(0xffb2f7e2)),
                        child: Text(getTranslation(Strings.confirm_order),
                            style: TextStyle(
                                color: const Color(0xff123456),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)))
                    .onTap(onPressed: () async {
                  var orderRequest = controller.getOrderRequestFromOrderResponse(orderResponse);
                  orderRequest.status = Statuses.ACCEPTED;
                  orderRequest.price = controller.getTotal();
                  print(orderRequest.toJson().toString());
                  var response = await controller.updateOrder(orderRequest);
                  print("Order Status ACCEPTED and Updated");
                  response.fold(
                      (l) => print(l), (r) => Navigator.pop(context, false));
//                  widget.callBackToConfirmOrder();
//                  push(ReviewAndDeliver());
                })
              ]),
        )
      ]),
    );
  }

  Widget getBillingItemWidget(OrderItems itemOrderModel) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemOrderModel.name, style: BaseStyles.itemOrderTextStyle),
              Container(
                height: 4,
              ),
              Text("${itemOrderModel.quantity}",
                  style: BaseStyles.itemOrderQuantityTextStyle),
              Container(
                height: 16,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text("${itemOrderModel.price}",
              style: BaseStyles.itemOrderTextStyle),
        )
      ],
    ));
  }

  String getOrderAddress() {
    // if (order != null && order.deliveryAddress != null) {
    //   var address = order?.deliveryAddress?.first;
    //   return "${address.dno},${address.streetName},${address.city},${address.zipcode},${address.country}";
    // }
    return "show addrss here";
  }
}
