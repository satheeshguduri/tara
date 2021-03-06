import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/order_management/orders/order_address.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/shop/shop_add_item.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/orders/order_request.dart';
import 'package:tara_app/models/order_management/orders/order_response.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_extra_data.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';








class MakeAnOrder extends StatefulWidget {
  final bool isFromShopHome;
  final Store merchantStore;
  final CustomerProfile merchantProfile;
  MakeAnOrder({Key key,
    this.isFromShopHome=false,
    this.merchantStore,
    this.merchantProfile
  }) : super(key: key);

  @override
  _MakeAnOrderState createState() => _MakeAnOrderState();
}

class _MakeAnOrderState extends BaseState<MakeAnOrder> {
  List<DeliveryType> arrDeliveryType = List<DeliveryType>();
  DeliveryType deliveryType;

  bool isEdit = false;
  int selectedSegmentIndex = 0;

  OrderController controller = Get.find();
  AuthResponse user = Get.find<AuthController>().user.value;
  List<OrderAddress> address = List<OrderAddress>();
  StoreController storeController = Get.find();



  @override
  void init() {
    // TODO: implement init
    super.init();
    var address1 = OrderAddress(dno: "1-2-3",streetName: "kattedan",city: "Hyderabad",country: "india",zipcode: 500077);
    address.add(address1);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arrDeliveryType.add(DeliveryType(
        "In-house Delivery", "Delivery fee might vary from each merchant."));
    arrDeliveryType.add(DeliveryType(
        "Others (Gojek/Grab)", "Pay the delivery once the order arrived."));
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff7f7fa),
      appBar: CustomAppBarWidget(title:getTranslation(Strings.make_an_order),addNewWidgetShow: false,),
      body:getRootContainer(),
    );
  }
  Widget getRootContainer(){
    return Obx(() => Container(
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _getDeliveryOption(),
            _getItemList(),
            _getSaveAsShoppingList()
          ],
        ),
      ).withProgressIndicator(showIndicator: controller.showProgress.value),
    ));
  }


  Widget _getDeliveryOption() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 16, bottom: 16),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getTranslation(Strings.delivery_option), style: TextStyles.subtitle1222),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 48,
            decoration: BoxDecoration(
                borderRadius: Radii.border(24), color: const Color(0xfff7f7f7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 160,
                  decoration: selectedSegmentIndex == 0 ? _getShadow() : null,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.ic_van),
                        Text(getTranslation(Strings.delivery),
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        selectedSegmentIndex = 0;
                      });
                    },
                  ),
                ),
                Container(
                  height: 40,
                  width: 160,
                  decoration: selectedSegmentIndex == 1 ? _getShadow() : null,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.ic_bag,
                          width: 24,
                        ),
                        Text(getTranslation(Strings.pickup),
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        selectedSegmentIndex = 1;
                      });
                    },
                  ),


                )
              ],
            ),
          ),
          Text(getTranslation(Strings.delivery_to), style: TextStyles.caption222),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 16),
            padding: EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
            decoration: BoxDecoration(
                borderRadius: Radii.border(8),
                border:
                    Border.all(color: AppColors.light_grey_bg_color, width: 1),
                color: Colors.white),
            child: Row(
              children: <Widget>[
                Image.asset(Assets.ic_location),
                Expanded(
                  flex: 7,
                  child: Text(
                      "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota ???",
                      style: TextStyles.body2222),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(getTranslation(Strings.CHANGE),
                          style: TextStyles.bUTTONBlack222,
                          textAlign: TextAlign.center),
                      Container(
                          width: 63,
                          height: 2,
                          decoration:
                              BoxDecoration(color: AppColors.pale_turquoise))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            getTranslation(Strings.prefered_delivery),
            style: TextStyles.caption222,
          ),
          _getDropDownList(),
//          Container(
//              margin: EdgeInsets.only(top: 4,bottom: 16),
//              height: 1,
//              decoration: BoxDecoration(color: Color(0xffb0b4c1)))
        ],
      ),
    );
  }

  Widget _getDropDownList() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 16),
      child: DropdownButton(
        value: deliveryType,
        isExpanded: true,
        icon: Container(),
        underline: Container(),
//      itemHeight: 60,
        onChanged: (DeliveryType val) {
          setState(() {
            deliveryType = val;
          });
        },
        items: _getDropdownItems(),
      ),
    );
  }

 Widget _getItemList() {
    if (controller.items != null && controller.items.length > 0) {
      return _getShopItemList();
    }
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        bottom: 16,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Obx(()=> controller.items.length>0?Container(width: 100,height: 100,color: Colors.blue,):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(getTranslation(Strings.item_list), style: TextStyles.subtitle1222),
          Column(
            children: <Widget>[
              // Container(
              //     margin: EdgeInsets.only(bottom: 16, top: 16),
              //     width: 88,
              //     height: 88,
              //     decoration: BoxDecoration(
              //         borderRadius: Radii.border(44),
              //         color: AppColors.light_grey_blue)
              // ),
              getSvgImage(imagePath: Assets.illustration_shopping_cart_empty, width: 80.0,height: 80.0),
              Text(getTranslation(Strings.start_item_list),
                  style: const TextStyle(
                      color: AppColors.fareColor,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.center),
              Container(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(bottom: 16, top: 16),
                  height: 32,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: Radii.border(8),
                      border: Border.all(
                          color: AppColors.light_grey_blue, width: 1),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getSvgImage(imagePath: Assets.assets_icon_p_plus, width: 20.0,height: 20.0),
                    //  Image.asset(Assets.ic_plus),
                      Text(
                        getTranslation(Strings.add_item),
                        style: TextStyles.bUTTONBlack222,
                      )
                    ],
                  ),
                ).onTap(onPressed: (){
                  _showAddItemBottomSheet(null);
                }),
              )
            ],
          ),
        ],
      ),
      )
    );
  }

  List<DropdownMenuItem<DeliveryType>> _getDropdownItems() {
    return arrDeliveryType
        .map<DropdownMenuItem<DeliveryType>>((DeliveryType value) {
      return DropdownMenuItem(
        child: Container(
//          margin: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value.title, style: TextStyles.subtitle1222),
              Text(value.subTitle, style: BaseStyles.saveToMyContactTextStyle),
              Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4),
                  height: 1,
                  decoration: BoxDecoration(color: Color(0xffb0b4c1)))
            ],
          ),
        ),
        value: value,
      );
    }).toList();
  }

 Widget _getSaveAsShoppingList() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
        child: Column(children: [
          Row(
            children: [
              Image.asset(Assets.ic_check_quare),
              Container(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(getTranslation(Strings.save_as_shoping_list), style: TextStyles.subtitle1222),
                  Container(
                    height: 4,
                  ),
                  Text(getTranslation(Strings.save_for_re_order),
                      style: BaseStyles.saveToMyContactTextStyle)
                ],
              ),
            ],
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 16, bottom: 8),
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: Radii.border(8),
                  color: controller.items.length > 0 ? AppColors.pale_turquoise : AppColors.light_grey_bg_color),
              child: Text(
                getTranslation(Strings.place_order),
                style: controller.items.length > 0 ? TextStyles.bUTTONBlack222 : TextStyles.bUTTONGrey3222,
              ),
            ),
            onTap: () async{
             if (controller.items.length > 0 ){
               // var orderReq = order.Order();
               // orderReq.items = controller.items.value;
               // orderReq.customerId = user.customerProfile.id;
               // orderReq.merchantId = widget.merchantStore.owner.integrationId.toString();
               // orderReq.storeId = widget.merchantStore;
               // orderReq.deliveryAddress = address;
               // orderReq.status = Statuses.PENDING;
               // orderReq.orderDate = DateTime.now();   //"2020-10-09";
               // orderReq.orderType = OrderTypes.TEXT_BASED;
               //
               // var data = OrderExtraData(customer_commid: user.customerProfile.firebaseId,
               //     merchant_commid: widget.merchantProfile.firebaseId,interpret: "true");
               // var orderExtra = JsonbOrderExtra(data:data);
               // orderReq.order_extra = orderExtra;
               // Either<Failure,CreateOrderResponse> response = await controller.createOrder(orderReq);
               //     response.fold((l) => print(l.message),
               //             (r) => {
               //     Navigator.pop(context, false)
               //     });
               var orderReq = OrderRequest(
                   storeId: widget.merchantStore.id,
                   catalogueId: num.parse(storeController.catalogueId.value),
                   items: controller.items.value,
                   customerId: user.customerProfile.id,
                   deliveryAddress:[],
                   status: Statuses.PENDING,
                   price: 99.0, // pending//TODO
                   deliveryDate: DateTime.now(),
                   orderDate: DateTime.now(),
                   orderType: OrderTypes.TEXT_BASED,
                   transactionId: null,
                   merchantId: widget.merchantProfile.id,
                   order_extra: JsonbOrderExtra(data: OrderExtraData(customer_commid: user.customerProfile.firebaseId,
                       merchant_commid: widget.merchantProfile.firebaseId,
                       interpret: "true")
                   )
               );

               Either<Failure, OrderResponse> response = await controller.createOrder(orderReq);
               response.fold(
                       (l) => print(l.message),
                       (r) => {
                     //  Navigator.pop(context, false)
                     Get.to(ConversationPage(
                         entry: ChatEntryPoint.ORDER,
                         selectedContact: ContactInfo(),
                         custInfo: widget.merchantProfile))
                   });
             }
            },
          )
        ]));
  }

  Decoration _getShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
        color: Colors.white);
  }

  dynamic _showAddItemBottomSheet(OrderItems item) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ShopAddItem(
            editItem: item,
            saveItem: (){
            },
          );
        });
  }

  Widget _getShopItemList() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8, bottom: 16),
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
//                  flex: 8,
                  child: Text(getTranslation(Strings.item_list), style: TextStyles.subtitle1222),
                ),
                Container(
//                  flex: 2,
                  child: Column(
                    children: [
                      Text(isEdit ?getTranslation(Strings.Done).toUpperCase() : getTranslation(Strings.edit),
                          style: TextStyles.subtitle1222),
                      Container(
                          width: 29,
                          height: 2,
                          decoration:
                              BoxDecoration(color: AppColors.pale_turquoise))
                    ],
                  ).onTap(onPressed: (){
                    setState(() {
                      // if (isEdit) {
                      //   isEdit = false;
                      // } else {
                      //   isEdit = true;
                      // }
                      isEdit = !isEdit;
                    });
                  }),
                )
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.items[index].name,
                                    style: TextStyles.body2222),
                                Text(controller.items[index].quantity.toString(),
                                    style: BaseStyles.sentOtpTextStyle)
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              height: 1,
                              color: AppColors.light_grey_bg_color,
                            )
                          ],
                        ),
                      ),
                      isEdit
                          ? Container(
                              width: 96,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    getSvgImage(imagePath: Assets.assets_icon_e_edit, width: 24.0,height: 24.0,color: AppColors.color_black_100_2_2_2).onTap(onPressed: (){
                                      _showAddItemBottomSheet(controller.items[index]);
                                    }),
                                    getSvgImage(imagePath: Assets.assets_icon_t_trash, width: 24.0,height: 24.0,color: Colors.pink).onTap(onPressed: (){
                                      setState(() {
                                        controller.items.removeAt(index);
                                      });
                                    }),

                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              }),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.only(bottom: 16, top: 16),
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: Radii.border(8),
                    border:
                        Border.all(color: AppColors.light_grey_blue, width: 1),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.ic_plus),
                    Text(
                      getTranslation(Strings.add_item),
                      style: TextStyles.bUTTONBlack222,
                    )
                  ],
                ),
              ),
              onTap: () {
                // show bottom sheet
                _showAddItemBottomSheet(null);
              },
            ),
          )
        ],
      ),
    );
  }
}

class DeliveryType {
  final String title;
  final String subTitle;

  DeliveryType(this.title, this.subTitle);
}

