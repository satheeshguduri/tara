import 'package:flutter/material.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/constants/fonts.dart';
import 'package:tara_app/controller/cart_controller.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/orders/create_order_req.dart';
import 'package:tara_app/models/order_management/orders/create_order_res.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_extra_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/screens/consumer/Data.dart';


class ShopBottomSheetWidget extends StatefulWidget {
final  VoidCallback plusButton,minusButton;
final Store merchantStore;
final CustomerProfile merchantProfile;

  ShopBottomSheetWidget({this.plusButton,this.minusButton,this.merchantProfile,this.merchantStore});
  @override
  _ShopBottomSheetWidgetState createState() => _ShopBottomSheetWidgetState();
}

class _ShopBottomSheetWidgetState extends BaseState<ShopBottomSheetWidget> {

  int selectedSegmentIndex = 0;
  CartController cartController = Get.find();
  StoreController storeController = Get.find();
  AuthResponse user = Get.find<AuthController>().user.value;
  OrderController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    void Function(VoidCallback fn) setModelState;
    return Obx(()=> StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          setModelState = setState;
          return Container(
            //padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  color: Colors.white
              ),
              child: Wrap(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 53,
                        height: 4,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(4)
                            ),
                            color: AppColors.light_grey_bg_color
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                          getTranslation(Strings.mycart),
                          style: TextStyles.myAccountsCardTextStyle
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16,right: 16),
                            child: Container(
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
                                              style:  BaseTextStyles.deliveryTextStyle,
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                      onTap: (){
                                        setModelState(() {
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
                                              style: BaseTextStyles.pickUpTextStyle,
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                      onTap: (){
                                        setModelState(() {
                                          selectedSegmentIndex = 1;
                                        });
                                      },
                                    ),


                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(height: 8,width: double.infinity,color: Color(0xfff7f7f7)),
                          SizedBox(height: 8,),
                          Padding(
                              padding: EdgeInsets.only(left: 16,right: 16),
                              child:selectedSegmentIndex==0?getAddressWidget():Container()),
                          SizedBox(height: 8,),
                          Padding(
                              padding: EdgeInsets.only(left: 16,right: 16),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cartController.cartItems.length,
                                  itemBuilder: (context,index){
                                    // return customCartListTile(cartController.cartItems[index]);
                                    var list = cartController.cartItems.value.where((e) => e.id == cartController.cartItems[index].id).toList();
                                    return Container(
                                      height: 88,
                                      width: double.infinity,
                                      child: Row(

                                        children: [
                                          Container(alignment: Alignment.center,
                                             child: Image(image: AssetImage('assets/images/temp_tomatoes.png'),width: 56,height: 56,fit: BoxFit.fitWidth,)),
                                          Expanded(
                                            child: Container(
                                              height: 62,
                                              margin: EdgeInsets.only(left: 16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      list[0].itemName,
                                                      style: BaseTextStyles.body222BottomListItem
                                                  ),
                                                  SizedBox(height: 8,),
                                                  Text(
                                                      "Price / 100gr",
                                                      style:BaseTextStyles.descriptionPriceStyle
                                                  ),
                                                  SizedBox(height: 6,),
                                                  Text(
                                                     list[0].price.toString(),
                                                      style: TextStyles.subtitle3222
                                                  ),



                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 16),
                                            alignment: Alignment.topCenter,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(4)
                                                      ),
                                                      color: AppColors.color_mint_100_2_2_2
                                                  ),

                                                  child:getSvgImage(imagePath: Assets.assets_icon_m_minus, width: 16.0,height: 16.0),

                                                ).onTap(onPressed: (){ // - minus
                                                  setModelState(() {
                                                    minusWidgetOnTap(list);
                                                  }
                                                  );


                                                }
                                                ),
                                                Container(
                                                  width: 28,
                                                  child: Obx(()=>
                                                      Text(
                                                          cartController.cartItems.where((e) => e.id ==list[0].id).toList()[0].orderQuantity.toString(),
                                                          style: TextStyles.bUTTONBlack222,
                                                          textAlign: TextAlign.center
                                                      ),
                                                  ),

                                                ),
                                                Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(4)
                                                      ),
                                                      color: AppColors.color_mint_100_2_2_2
                                                  ),
                                                  child: getSvgImage(imagePath: Assets.icon_content_add_24_px, width: 16.0,height: 16.0),
                                                ).onTap(onPressed: (){
                                                  setModelState(() {
                                                    plusWidgetOnTap(list);
                                                  });


                                                }
                                                )
                                              ],
                                            ),
                                          )
                                        ],

                                      ),
                                    );


                                  })

                          ),
                        //  SizedBox(height: 16,),
                          Container(height: 8,width: double.infinity,color: Color(0xfff7f7f7)),
                          SizedBox(height: 16,),
                          Padding(
                            padding: EdgeInsets.only(left: 16,right: 16),
                            child: Container(
                              height: 136,
                              decoration: BoxDecoration(
                                  color: AppColors.elevation_off_2_2_2
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      getTranslation(Strings.youmayalsolike),
                                      style: TextStyles.subtitle1222
                                  ),
                                  Expanded(child: getYouMayLikeList())
                                ],
                              ),
                            ),
                          ),
                          Container(height: 8,width: double.infinity,color: Color(0xfff7f7f7)),
                          getPlaceOrderWidget()



                        ],
                      ),
                    )
                  ]
              )
          );
        }).withProgressIndicator(showIndicator: controller.showProgress.value));



  }

  @override
  BuildContext getContext() {
    return context;
  }

  Widget getYouMayLikeList() {
    return Container(
        height: 136,
        margin: EdgeInsets.only(left: 16),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return youMayAlsoLikeListTile(); // Container

            }
        )
    );
  }
  Widget getPlaceOrderWidget() {
    return Container(
      height: 56,
      decoration: BoxDecoration(color: AppColors.elevation_off_2_2_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  width: 40,
                  height: 56,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Positioned(
                        //   left: 0,
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            height: 24,
                            width: 24,
                            child: getSvgImage(
                                imagePath: Assets.assets_icon_c_cart,
                                color: AppColors.color_black_100_2_2_2,
                                width: 18.0,
                                height: 18.0),
                          ).onTap(onPressed: () {})),
                      Obx(
                            () => Positioned(
                          top: 10,
                          left: 16,
                          child: Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: AppColors.badge_color,
                              borderRadius: Radii.border(7),
                            ),
                            child: Text(
                              getCartItemsCount(),
                              textAlign: TextAlign.center,
                              style: BaseStyles.notificationBadgeTextStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //  SizedBox(width: 16,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Estimation
                  Text(getTranslation(Strings.priceestimation),
                      style: BaseTextStyles.descriptionPriceStyle),
                  SizedBox(
                    height: 6,
                  ),
                  Obx(() => Text(cartController.getCartItemsTotalAmount(),
                      style: TextStyles.subtitle1222))
                ],
              )
            ],
          ),
          // Container
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              width: 164,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.color_mint_100_2_2_2),
              child: Row(
                children: [
                  // Place Order
                  Expanded(
                    child: Text(getTranslation(Strings.place_order),
                        style: TextStyles.bUTTONBlack222,
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: getSvgImage(
                          imagePath: Assets.assets_icon_f_forward_arrow,
                          width: 24.0,
                          height: 24.0)),
                ],
              ).onTap(onPressed: () async {
                if (cartController.cartItems.length > 0) {
                  var orderReq = CreateOrderRequest(
                      storeId: widget.merchantStore.id,
                      catalogueId: num.parse(storeController.catalogueId.value),
                      items: getOrderItems(),
                      customerId: user.customerProfile.id,
                      deliveryAddress:[],
                      status: Statuses.PENDING,
                      price: cartController.getCartItemsTotalAmount(),
                      deliveryDate: DateTime.now(),
                      orderDate: DateTime.now(),
                      orderType: OrderTypes.CATALOGUE_BASED,
                      transactionId: null,
                      merchantId: widget.merchantProfile.id,
                      order_extra: JsonbOrderExtra(data: OrderExtraData(customer_commid: user.customerProfile.firebaseId,
                          merchant_commid: widget.merchantProfile.firebaseId,
                          interpret: "true")
                      )
                  );

                  Either<Failure, CreateOrderResponse> response = await controller.createOrder(orderReq);
                  response.fold(
                          (l) => print(l.message),
                          (r) => {
                        Get.to(ConversationPage(
                            entry: ChatEntryPoint.ORDER,
                            selectedContact: ContactInfo(),
                            custInfo: widget.merchantProfile)
                        )
                      });
                }
              }),
            ),
          )
        ],
      ),
    );
  }


  Widget getAddressWidget() {
    return  Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)
          ),
          border: Border.all(
              color: AppColors.grey2,
              width: 1
          ),
          color: AppColors.elevation_off_2_2_2
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSvgImage(imagePath: Assets.assets_icon_l_location_outline, width: 24.0,height: 24.0),
          // Jl. Kedoya Raya, Kot
          Container(
            width: Get.width*0.6,
            child: Text(
                "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …",
                style:BaseTextStyles.body222BottomListItem
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          // getSeeAllText(),

        ],
      ),

    );
  }

  _getShadow() {
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



  Widget youMayAlsoLikeListTile() {
    return // Container
      Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          width: 208,
          //   height: 72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
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
              color: AppColors.elevation_off_2_2_2
          ),
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 8,right: 8),
                  child: Image(image: AssetImage('assets/images/temp_tomatoes.png'),width: 46,height: 56,)),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Jamur Kuping (100…",
                        style: BaseTextStyles.body222BottomListItem
                    ),
                    SizedBox(height: 8,),
                    Text(
                        "Price / 100gr",
                        style: BaseTextStyles.descriptionPriceStyle
                    ),
                    SizedBox(height: 6,),
                    Text(
                        "Rp 3.000 - 4.100",
                        style: TextStyles.subtitle3222
                    )
                  ],
                ),
              )
            ],
          ),
        ),

      );
  }

  String getCartItemsCount() {
    num totalCount=0;
    for(int i=0;i<cartController.cartItems.length;i++){
      totalCount = totalCount+cartController.cartItems[i].orderQuantity??0;
    }
    return totalCount.toString();
  }

  // String getCartItemsTotalAmount() {
  //   double totalAmount=0;
  //   for(int i=0;i<cartController.cartItems.length;i++){
  //     totalAmount = totalAmount+cartController.cartItems[i].orderQuantity*cartController.cartItems[i].price??0;
  //   }
  //   return totalAmount.toString();
  // }

  void plusWidgetOnTap(List<Item> list) {
    var matchedProduct = cartController.cartItems.firstWhere((e) => e.id ==list[0].id,orElse:()=>null);
    if(matchedProduct!=null) {
      matchedProduct.orderQuantity++;
      cartController.cartDB.value.write("items", cartController.cartItems);
    }
     widget.plusButton();
    // setState(() { }
    // );
  }

  void minusWidgetOnTap(List<Item> list) {
    var matchedProduct = cartController.cartItems.firstWhere((e) => e.id ==list[0].id,orElse:()=>null);
    if(matchedProduct!=null) {
      matchedProduct.orderQuantity--;
      if(matchedProduct.orderQuantity==0){
        cartController.cartItems.remove(matchedProduct);
      }
      cartController.cartDB.value.write("items", cartController.cartItems);
    }
    // setState(() { });
    widget.minusButton();
  }

  List<OrderItems> getOrderItems() {
    List<OrderItems> items = [];
    for (int i = 0; i < cartController.cartItems.length; i++) {
      print("length = " + cartController.cartItems.length.toString());
      items.add(OrderItems(
          name: cartController.cartItems[i].itemName,
          price: cartController.cartItems[i].price,
          quantity: cartController.cartItems[i].orderQuantity,
          currency: "Rp",
          metric: "Kg"));
    }
    return items;
  }
}
































