import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/page_indicator.dart';
import 'package:tara_app/common/widgets/underline_text.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/customer_orders_screen.dart';
import 'package:tara_app/screens/consumer/shop/make_an_order.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/shop/shopping_home_page.dart';
import 'package:tara_app/common/constants/fonts.dart';

class ShopHome extends StatefulWidget {
  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends BaseState<ShopHome> {
  int _current = 0;
  OrderController controller = Get.find();
  StoreController storeController = Get.find();

  @override
  void init() async {
    // TODO: implement init
    super.init();
    controller.getConsumerOrders();
    controller.getAllStore();
    print(controller.storeTypesList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      extendBodyBehindAppBar: true,
      body: getRootContainer(),
    );
  }

  Widget getRootContainer() {
    return Obx(() => SafeArea(
          top: false,
          child: Stack(
            children: [headingTopBar(), getBodyWidget()],
          ),
        ).withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  buildNavBar() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Container(
//        alignment: Alignment.center,
//        height: 56,
        margin: EdgeInsets.only(top: 18, left: 0, bottom: 18, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                IconButton(
                  // icon: Icon(Icons.arrow_back),
                  icon: getSvgImage(
                      imagePath: Assets.assets_icon_b_back_arrow,
                      width: 24.0,
                      height: 24.0),
                  onPressed: () =>
                      // Navigator.pop(context, false) //Navigator.pop(context, false),
                      Get.back(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(getTranslation(Strings.deliver_to),
                        style: BaseStyles.agentConfirmedTextStyle),
                    Row(
                      children: <Widget>[
                        Text("Jl Kedoya Barat No. 20",
                            style: BaseStyles.cannotFindTextStyle),
                        // Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 16,
                        // )
                        getSvgImage(
                            imagePath: Assets.assets_icon_a_arrow_right,
                            width: 24.0,
                            height: 24.0),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    //icon: Icon(Icons.favorite_border),
                    icon: getSvgImage(
                        imagePath: Assets.assets_icon_f_favorite,
                        width: 24.0,
                        height: 24.0),
                    onPressed: () => {}),
                Container(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      IconButton(
                          //   icon: Icon(Icons.shopping_cart),
                          icon: getSvgImage(
                              imagePath: Assets.assets_icon_c_cart,
                              width: 24.0,
                              height: 24.0,
                              color: AppColors.header_top_bar_color),
                          onPressed: () => {}),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.badge_color,
                            borderRadius: Radii.border(7),
                          ),
                          child: Text(
                            "3",
                            textAlign: TextAlign.center,
                            style: BaseStyles.notificationBadgeTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getSearchWidget() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        margin: EdgeInsets.only(left: 16, top: 16, right: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(179, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(26, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(left: 8),
              //child: getTabImage(Assets.SEARCH_ICON),
              child: getSvgImage(
                  imagePath: Assets.assets_icon_s_search,
                  width: 24.0,
                  height: 24.0),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                getTranslation(Strings.search_prd_cat),
                textAlign: TextAlign.left,
                style: BaseStyles.searchBarTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadContent() {
    return Column(
      children: [
        getCarouselWidget(),
        getCarouselSelectionWidget(),
        loadPreviousOrders(),
        loadMerchantNearYou(),
      ],
    );
  }

  List<Widget> loadCards() {
    List<Widget> arrList = [];

    for (int i = 0; i <= 4; i++) {
      arrList.add(Container(
        height: 180,
        margin: EdgeInsets.only(left: 2, right: 16),
        child: Image.asset(Assets.ic_shop_banner),
      ));
    }
    return arrList;
  }

  loadPreviousOrders() {
    if (controller.orderList.length != 0) {
      return Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       flex: 7.5.toInt(),
              //       child: Align(
              //         alignment: Alignment.topLeft,
              //         child: Text(
              //           getTranslation(Strings.past_purchase),
              //           textAlign: TextAlign.left,
              //           style: BaseStyles.bottomSheetTitleStyle,
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 2.5.toInt(),
              //       child: Container(
              //           padding: EdgeInsets.only(top: 8, bottom: 8),
              //           child: Column(
              //             children: [
              //               Container(
              //                // margin: EdgeInsets.only(right: 16),
              //                 child: Align(
              //                   alignment: Alignment.topRight,
              //                   child: Text(
              //                     getTranslation(Strings.SEE_ALL),
              //                     textAlign: TextAlign.center,
              //                     style: BaseStyles.seeAllTextStyle,
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 height: 2,
              //                 width: 59,
              //                 margin: EdgeInsets.only(
              //                     top: 4, ),
              //                 decoration: BoxDecoration(
              //                   gradient: Gradients.primaryGradient,
              //                 ),
              //               ),
              //             ],
              //           )).onTap(
              //           onPressed: () => Get.to(CustomerOrdersScreen())),
              //     ),
              //   ],
              // ),
              Container(
                // margin: EdgeInsets.only(left: 16,right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getHeadingText(
                      getTranslation(Strings.past_purchase),
                    ),
                    getSeeAllText(),
                  ],
                ),
              ),
              Container(
                  height: 120,
                  margin: EdgeInsets.only(left: 0, right: 0, top: 16),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.orderList.length,
                      itemBuilder: (context, index) {
                        var order = controller.orderList.value[index];
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: EdgeInsets.only(right: 8, top: 16, bottom: 8),
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x1f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 6,
                                    spreadRadius: 0),
                                BoxShadow(
                                    color: Color(0x14000000),
                                    offset: Offset(0, 0),
                                    blurRadius: 2,
                                    spreadRadius: 0)
                              ],
                              color: AppColors.primaryBackground),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  DateFormat('dd MMM yyyy • kk:mm')
                                      .format(order.orderDate),
                                  style: BaseTextStyles.myOrdersDateTextStyle),
                              Text(order.storeId.name,
                                  style: BaseStyles.bottomSheetTitleStyle),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      order.items.length.toString() +
                                          " " +
                                          getTranslation(Strings.itemrp) +
                                          " " +
                                          order.price.toString(),
                                      style: BaseTextStyles
                                          .myOrdersItemsTextStyle),
                                  InkWell(
                                    child: Container(
                                      width: 88,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          color: AppColors.pale_turquoise),
                                      child: Text(
                                          getTranslation(Strings.order_again),
                                          style: BaseStyles
                                              .shopPreviousOrderAgain),
                                    ),
                                    onTap: () {
//                                  push(MakeAnOrder(isFromShopHome: true,callBack: (arr){
//                                    Navigator.pop(
//                                        context, false);
//                                  },));
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })),
            ],
          ));
    }
    return Container();
  }

  Widget getHeadingText(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: BaseStyles.bottomSheetTitleStyle,
    );
  }

  Widget getSeeAllText() {
    return Column(children: [
      Container(
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            getTranslation(Strings.SEE_ALL),
            textAlign: TextAlign.center,
            style: BaseStyles.seeAllTextStyle,
          ),
        ),
      ),
      Container(
        height: 2,
        width: 60,
        decoration: BoxDecoration(
          gradient: Gradients.primaryGradient,
        ),
      )
    ]);
  }

  loadMerchantNearYou() {
    return Column(
      children: [
        controller.storeTypesList != null &&
                controller.storeTypesList.length != 0
            ? Container(
                height: 108,
                // margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      getTranslation(Strings.merchant_near_u),
                      textAlign: TextAlign.left,
                      style: BaseStyles.bottomSheetTitleStyle,
                    ).paddingSymmetric(horizontal: 16, vertical: 8),
                    Expanded(
                      child: ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.storeTypesList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 32,
                                    height: 32,
                                    margin: EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                        color: AppColors.light_grey_bg_color,
                                        borderRadius: Radii.border(16))),
                                Text(controller.storeTypesList[index].type,
                                    style: const TextStyle(
                                        color: AppColors.fareColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0)),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: 12,
                        ),
                      ),
                    ),
                  ],
                ))
            : Container(),
        SizedBox(
          height: 8,
        ),
        controller.arrStores != null && controller.arrStores.length != 0
            ? Container(
//          height: 72,
                child: ListView.builder(
                    // listView does have default padding which is pretty large on iOS
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.arrStores.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 4),
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Image.asset(
                                      Assets.PERSON_ICON,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.arrStores[index].name,
                                          style: const TextStyle(
                                              color: AppColors.fareColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0)),
                                      Container(
                                        height: 8,
                                      ),
                                      Text(
                                          controller.getStoreType(
                                                  controller.arrStores[index]) +
                                              " • 1.5 km",
                                          style: const TextStyle(
                                              color: AppColors.light_grey_blue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0))
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 16),
                                child: Image.asset(
                                  Assets.ic_chat,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          if (controller.arrStores.length > 0) {
                            storeController.catalogueId.value = controller
                                .arrStores[index].catalogue?.id
                                .toString();
                            Get.to(ShoppingHomePage());

                            // int integrationID = controller.arrStores[index].owner
                            //     .integrationId;
                            // if (integrationID != null) {
                            //   var response = await controller.getCustomerInfo(
                            //       integrationID.toString());
                            //   response.fold((l) => print(l.message), (r) =>
                            //   {
                            //     if(r.firebaseId != null){
                            //       push(ConversationPage(arrChats: ["make_an_order"],
                            //         custInfo: r,
                            //         merchantStore: controller.arrStores[index],
                            //       ))}
                            //   });
                            // }
                          }
                        },
                      );
                    }))
            : Container()
      ],
    );
  }

  Widget headingTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 240,
        decoration: getTopBarDecoration(),
        child: Column(
          children: [
            buildNavBar(),
            getSearchWidget(),
          ],
        ),
      ),
    );
  }

  BoxDecoration getTopBarDecoration() {
    return BoxDecoration(
        gradient: Gradients.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(16.0),
          bottomRight: const Radius.circular(16.0),
        ));
  }

  Widget getCarouselWidget() {
    return CarouselSlider(
      items: loadCards(),
      options: CarouselOptions(
          // autoPlay: true,
          enableInfiniteScroll: false,
          aspectRatio: 3.0,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }

  Widget getCarouselSelectionWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DotsIndicator(_current, 5),
          UnderlineText(
            text: Text(
              getTranslation(Strings.see_all_promo),
              textAlign: TextAlign.center,
              style: BaseStyles.seeAllTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget getBodyWidget() {
    return Positioned(
      top: 180,
      left: 0,
      right: 0,
      height: Get.height - 188,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: loadContent(),
      ),
    );
  }
}
