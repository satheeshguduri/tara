import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as OrderModel;
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/services/error/failure.dart';

class ReviewAndConfirm extends StatefulWidget {
  Function(String) callBackToConfirmOrder;
  String orderId;
  ReviewAndConfirm({Key key,this.callBackToConfirmOrder, this.orderId}) : super(key: key);
  @override
  _ReviewAndConfirmState createState() => _ReviewAndConfirmState();
}

class _ReviewAndConfirmState extends BaseState<ReviewAndConfirm> {
  // List<String> itemOrderList = [
  //   "Nanas",
  //   "Bengkoang",
  //   "Minyak Bimoli",
  //   "Telor Ayam"
  // ];
  // List<String> itemOrderQuantityList = ["500gr", "200gr", "1", "0.5kg"];
  // List<String> itemOrderCostList = [
  //   "Rp 10.000",
  //   "Rp 25.000",
  //   "Rp 17.000",
  //   "Rp 9.000"
  // ];
  List<OrderItems> arrItems = [];
  List<String> arrEmptyOrder = [];
  OrderModel.Order order;

  List<TextEditingController> _controllers = new List();

  @override
  BuildContext getContext() {
    return context;
  }
  
  FutureBuilder getOrdersFuture(){
    return FutureBuilder<Either<Failure,OrderModel.Order>>(
      future: getIt.get<OrderRepository>().getOrderByOrderId(widget.orderId),
      builder: (context, AsyncSnapshot<Either<Failure,OrderModel.Order>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          if(snapshot.hasData) {
            Either<Failure,OrderModel.Order> result = snapshot.data;
            result.fold((l) => Text("Unable to fetch the Order details"), (r)=>{
                order = r,
                arrItems = order.items
            });
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

  Widget getPageContainer(){
    return Column(
      children: [
        getItemsOrderTotalWidget(),
        getDeliveryInfoWidget(),
        getDeliveryMethodWidget(),
        getBillingInfoWidget()
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7fa),
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: getOrdersFuture(),
        ));
  }

  getItemsOrderTotalWidget() {
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

  getEmptyItemOrderWidget() {
    if (arrEmptyOrder.length > 0) {
      return ListView.builder(
          itemCount: arrEmptyOrder.length,
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
                            setState(() {
                              arrEmptyOrder.removeLast();
                            });
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

  getAddMoreItemWidget() {
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
          setState(() {
            arrEmptyOrder.add("");
          });
        },
      ),
    );
  }

  getItemsListWidget() {
    return Container(
        color: Colors.transparent,
//        height: (arrItems!=null&&arrItems.length>0)? (arrItems.length * 50).toDouble() + 20:0,
        child: ListView.builder(
          itemBuilder: (context, index) =>
              getOrderItemWidget(arrItems[index], index),
          itemCount: arrItems.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
        ));
  }

  getOrderItemWidget(OrderItems itemOrderModel, int index) {
    _controllers.add(new TextEditingController());
    _controllers[index].text = itemOrderModel.price.toString();
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
                          controller: _controllers[index],
                          decoration: InputDecoration(border: InputBorder.none),
                          textAlign: TextAlign.start,
                          style: BaseStyles.itemOrderCostTextStyle,
                        )),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: InkWell(
                          child: Image.asset(Assets.ic_delete),
                          onTap: () {},
                        ),
                      )),
                ],
              ),
            )
          ],
        ));
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

  getDeliveryInfoWidget() {
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
                color: const Color(0xff889aac),
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
                color: const Color(0xff889aac),
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
                color: const Color(0xff889aac),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 12.0)),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
              "Jl. Kedoya Raya 4 Blok BC 2 No. 32 RT/RW 012/002, Kedoya Selatan, Jakarta Barat, DKI Jakarta 11520",
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

  getDeliveryMethodWidget() {
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
                            hint: "Rp 1.000",
                            placeHolderStyle: BaseStyles.placeholderStyle,
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

  getBillingInfoWidget() {
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
                  getBillingItemWidget(arrItems[index]),
              itemCount: arrItems.length,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
            )),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Expanded(
              flex: 8,
              child: Text(getTranslation(Strings.subtotal), style: BaseStyles.itemOrderTextStyle)),
          Expanded(
              flex: 2,
              child: Text("Rp 45.500", style: BaseStyles.itemOrderTextStyle)),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Expanded(
              flex: 8,
              child: Text(getTranslation(Strings.delivery_fee), style: BaseStyles.itemOrderTextStyle)),
          Expanded(
              flex: 2,
              child: Text("Rp 8.000", style: BaseStyles.itemOrderTextStyle)),
        ]),
        Container(
          margin: EdgeInsets.only(top: 16,bottom: 16),
          height: 1,
          color: AppColors.light_grey_bg_color,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 32),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(getTranslation(Strings.total), style: BaseStyles.reviewAndConfirmHeaderTextStyle),
                Text("Rp 53.500", style: BaseStyles.reviewAndConfirmHeaderTextStyle)
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
            border: Border.all(color: AppColors.light_grey_blue, width: 1),
            color: const Color(0xffffffff)),
             child:
                Text(getTranslation(Strings.decline_order), style: TextStyle(
                    color:  const Color(0xfff95074),
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ))
          ),
                InkWell(
                  child:Container(
                      width: 156,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          borderRadius: Radii.border(8),
                          color: Color(0xffb2f7e2)),
                      child:
                      Text(getTranslation(Strings.confirm_order), style: TextStyle(
                          color:  const Color(0xff123456),
                          fontWeight: FontWeight.w700,
                          fontStyle:  FontStyle.normal,
                          fontSize: 14.0
                      ))
                  ) ,
                  onTap: ()async {
//                    push(ReviewAndDeliver());
                  //wrote a controlle and show progress
                  //   YAKUB: Uncomment to update the status.
                   /* order.status = Statuses.ACCEPTED;
                    print(order.toJson().toString());
                    await getIt.get<OrderRepository>().updateOrder(order);
                    print("Order Status ACCEPTED and Updated");*/
                  widget.callBackToConfirmOrder(Strings.confirm_order);
                  Navigator.pop(context, false);
                  },
                )

              ]),
        )
      ]),
    );
  }

  getBillingItemWidget(OrderItems itemOrderModel) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemOrderModel.name,
                  style: BaseStyles.itemOrderTextStyle),
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
          child:
              Text("${itemOrderModel.price}", style: BaseStyles.itemOrderTextStyle),
        )
      ],
    ));
  }
}
