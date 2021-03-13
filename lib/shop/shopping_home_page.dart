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
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/customer_orders_screen.dart';
import 'package:tara_app/screens/consumer/shop/make_an_order.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/constants/color_const.dart';
import 'package:tara_app/common/constants/fonts.dart';
import 'package:tara_app/shop/shop_category_details_screen.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart' as store;
import 'package:tara_app/shop/shop_bottom_sheet_widget.dart';
import 'package:tara_app/controller/cart_controller.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/auth/customer_profile.dart';


class ShoppingHomePage extends StatefulWidget {
  final Store merchantStore;
  final CustomerProfile merchantProfile;
  ShoppingHomePage({Key key,
    this.merchantStore,
    this.merchantProfile
  }) : super(key: key);

  @override
  ShoppingHomePageState createState() => ShoppingHomePageState();
}

class ShoppingHomePageState extends BaseState<ShoppingHomePage> {

  int _current = 0;
  OrderController controller = Get.find();
  StoreController storeController = Get.find();
  CartController cartController = Get.find();


  // @override
  // void init() async {
  //   // TODO: implement init
  //   super.init();
  //   controller.getConsumerOrders();
  //   controller.getAllStore();
  //   print(controller.storeTypesList);
  // }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.getItems(storeController.catalogueId.value);
    storeController.getBanners();
    storeController.getCategories();
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
    return Obx(() =>
        SafeArea(
          top: false,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                      gradient: Gradients.primaryGradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(16.0),
                        bottomRight: const Radius.circular(16.0),
                      )),
                  child: Column(
                    children: [
                      buildNavBar(),
                      getSearchWidget(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 180,
                left: 0,
                right: 0,
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 188,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: loadContent(),
                ),
              )
            ],
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
                        Navigator.pop(
                            context, false) //Navigator.pop(context, false),
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
                        getSvgImage(imagePath: Assets.assets_icon_a_arrow_right,
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
                    icon: getSvgImage(imagePath: Assets.assets_icon_f_favorite,
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
                          onPressed: () {

                          }),
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
                          child: Obx(()=>Text(
                            cartController.getCartItemsCount(),
                            textAlign: TextAlign.center,
                            style: BaseStyles.notificationBadgeTextStyle,
                          )
                          ),
                        ),
                      ),
                    ],
                  ),
                ).onTap(onPressed: (){
                  showCartDetailsInBottomSheet();
                }
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
              child: getSvgImage(imagePath: Assets.assets_icon_s_search,
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
      children: <Widget>[
        carouselWidget(),
        dotsAndSeeAllPromoWidget(),
        SizedBox(height: 24),
        getTitleAndSeeAllText(Strings.categories),
        SizedBox(height: 18),
        getCategoriesListView(),
        SizedBox(height: 24),
        getTitleAndSeeAllText(Strings.todaysdeal),
        SizedBox(height: 18),
        todayDealsListView(),
      ],
    );
  }

  List<Widget> loadCards() {
    if (storeController.bannersList.length > 0) {
      List<Widget> arrList = [];
      for (int i = 0; i < storeController.bannersList.length; i++) {
        arrList.add(Container(
          margin: EdgeInsets.only(left: 2, right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              storeController.bannersList[i].url,fit: BoxFit.fitHeight,
              height: 120.0,
              width: Get.width*0.9,
            ),
          ),
         )
        );
      }
      return arrList;
    } else {
      List<Widget> arrList = [];
      for (int i = 0; i <= 4; i++) {
        arrList.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              )
          ),
          height: 180,
          margin: EdgeInsets.only(left: 2, right: 16),
          child: Image.asset(Assets.ic_shop_banner),
        ));
      }
      return arrList;
    }
  }


  CarouselSlider carouselWidget() {
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

  Widget dotsAndSeeAllPromoWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7.5.toInt(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: loadCards().map((url) {
                int index = loadCards().indexOf(url);
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? AppColors.fareColor
                        : AppColors.light_grey_blue,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            flex: 4.toInt(),
            child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          getTranslation(Strings.see_all_promo),
                          textAlign: TextAlign.center,
                          style: BaseStyles.seeAllTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        gradient: Gradients.primaryGradient,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }


  Widget getTitleAndSeeAllText(String title) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getHeadingText(title),
          getSeeAllText(title),

        ],
      ),
    );
  }

  Widget getHeadingText(String title) {
    return Text(
      getTranslation(title),
      textAlign: TextAlign.left,
      style: BaseTextStyles.headline6222,
    );
  }

  Widget getSeeAllText(String title) {
    return Column(
        children: [
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
            decoration: BoxDecoration(gradient: Gradients.primaryGradient,),
          )
        ]
    ).onTap(onPressed: () {
      if (title == Strings.categories) {
        showAllCategoriesInBottomSheet(context);
      } else {}
    });
  }

  Widget getCategoriesListView() {
    // return FutureBuilder(
    //   future: storeController.getCategories(),
    //   builder: (context,snapshot){
    //     if(snapshot.connectionState==ConnectionState.done)
    //     {
    //       if(snapshot.hasData){
    //         List<store.Category> data = snapshot.data;
    //         return getCategoryWidget(data);
    //       }else if (snapshot.hasError){
    //         return Container();
    //       }else{
    //         return Container();
    //       }
    //     }else{
    //       return BaseWidgets.getIndicator;
    //     }
    //   },
    // );

    return getCategoryWidget(storeController.categoryList.value);
  }

  Widget getListTile(store.Category category,[bool isDecorationNeeded]) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 16, bottom: 24),
      decoration: getCategoryDecoration(isDecorationNeeded),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          tileFirstRow(category),
          tileSecondRow(category),
        ],
      ),


    ).onTap(onPressed: () {
      //here sort the data and send to next screen
      //  print("catalogue"+category.items[0].catalogue[0]);
      Get.to(ShopCategoryDetailsScreen(categoryId: category.id,title: category.name,merchantProfile: widget.merchantProfile,merchantStore: widget.merchantStore,));
    });
  }

  Widget tileFirstRow(store.Category category) {
    return Container(
      //  alignment: Alignment.bottomCenter,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black12,),
      child: Image.network(
          category.imageUrl
      ),

    );
  }

  Widget tileSecondRow(store.Category category) {
    return Text(category.name,
        style: BaseTextStyles.subtitle2222,
        textAlign: TextAlign.center
    );
  }

  BoxDecoration getCategoryDecoration(bool isNeeded) {
     if(isNeeded){
       return BoxDecoration(
           borderRadius: BorderRadius.all(
               Radius.circular(8)
           ),
           boxShadow: [BoxShadow(
               color: const Color(0x1f000000),
               offset: Offset(0, 4),
               blurRadius: 6,
               spreadRadius: 0
           ), BoxShadow(
               color: const Color(0x14000000),
               offset: Offset(0, 0),
               blurRadius: 2,
               spreadRadius: 0
           )
           ],
           color: ColorConst.elevation_off_2_2_2
       );
     }else{
       return BoxDecoration();
     }
  }

  Widget todayDealsListView() {
    return Container(
        height: 260,
        margin: EdgeInsets.only(left: 16),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return getTodayDealsListTile(); // Container


            })
    );
  }

  Widget getTodayDealsListTile() {
    return Container(
      width: 148,
      margin: EdgeInsets.only(right: 16, bottom: 24),
      decoration: getDealsDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          dealsTileFirstRow(),
          dealsTileSecondRow(),
        ],
      ),


    );
  }

  Widget dealsTileFirstRow() {
    return Column(
      children: [
        getStackWidget(),
        SizedBox(height: 12),
        Text(
            "Buncis (250gr)",
            style: TextStyles.body2222
        )
      ],
    );
  }

  Widget dealsTileSecondRow() {
    return Column(
      children: [
        //  250gr
        // Text
        Text(
            "Medicine",
            style: const TextStyle(
                color: ColorConst.input_field_line_off_2_2_2,
                fontWeight: FontWeight.w500,
                fontFamily: "SctoGroteskA",
                fontStyle: FontStyle.normal,
                fontSize: 14.0
            ),
            textAlign: TextAlign.center
        ),
        SizedBox(height: 6),
        // Rp 5.300-6.600
        Text(
            "Rp 5.300-6.600",
            style: BaseTextStyles.subtitle3222
        ),
        SizedBox(height: 8),
        Container(
            height: 32,
            margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
                color: ColorConst.color_mint_100_2_2_2
            ),
            alignment: Alignment.center,
            child: Text("+ Add",
              style: BaseTextStyles.bUTTONBlack222,)).onTap(onPressed: () {

        }
        ),
      ],
    );
  }

  BoxDecoration getDealsDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(8)
        ),
        boxShadow: [BoxShadow(
            color: const Color(0x24000000),
            offset: Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0
        ), BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 0
        )
        ],
        color: ColorConst.elevation_off_2_2_2
    );
  }

  Widget getStackWidget() {
    return Stack(children: [
      Container(
        width: 148,
        height: 100,
        color: Colors.blue,
      ),
      Positioned(
        top: 8,
        right: 8,
        child:
        Container(
          width: 24,
          height: 24,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                  color: const Color(0x1f000000),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: 0
              ), BoxShadow(
                  color: const Color(0x14000000),
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 0
              )
              ],
              color: ColorConst.elevation_off_2_2_2
          ),
          child: getSvgImage(imagePath: Assets.assets_icon_f_favorite,
              height: 16.0,
              width: 16.0),

        ).onTap(onPressed: () {

        }),
      )

    ]);
  }

  Widget getCategoryWidget(List<store.Category> categories) {
    return Container(
        height: 116,
        margin: EdgeInsets.only(left: 16),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return getListTile(categories[index],true); // Container


            })
    );
  }


  Future showAllCategoriesInBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: ColorConst.elevation_off_2_2_2,
        context: context,
        builder: (BuildContext context) {
          return ShopBottomSheetWidget(plusButton: (){
            setState(() {
              print("plus click");

            });
          },minusButton: (){
            print("minus click");
            setState(() {

            });
          },merchantProfile: widget.merchantProfile,merchantStore: widget.merchantStore,);
        }
    );
  }

  Widget bottomSheetWidget() {
    return Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.only(top: 6),
        decoration:getBottomSheetDecoration(),
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
                          Radius.circular(8)
                      ),
                      color: AppColors.light_grey_bg_color
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 18),
                  getHeadingText(Strings.allcategories),
                  SizedBox(height: 16),
                  categoriesGridView()
                ],
              ),
            ]
        )
    );
  }

  Widget categoriesGridView() {
    return GridView.count(crossAxisCount: 4,
        shrinkWrap: true,
        childAspectRatio: 0.7,
        children: storeController.categoryList.map((categoryItem) =>
            getListTile(categoryItem,false)).toList()
    );
  }

  BoxDecoration getBottomSheetDecoration() {
    return  BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(64), topRight: Radius.circular(8)),
        color: Colors.white
    );
  }

  void showCartDetailsInBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return ShopBottomSheetWidget(plusButton: (){
            setState(() {
              print("plus click");

            });
          },minusButton: (){
            print("minus click");
            setState(() {

            });
          },merchantProfile: widget.merchantProfile,merchantStore: widget.merchantStore,);


        }
    );
  }



}

