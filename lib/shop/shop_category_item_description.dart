import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/constants/fonts.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tara_app/controller/cart_controller.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/shop/shop_bottom_sheet_widget.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/auth/customer_profile.dart';



class ShopCategoryItemDescription extends StatefulWidget {

  final Item categoryItem;
  final Store merchantStore;
  final CustomerProfile merchantProfile;
  ShopCategoryItemDescription({this.categoryItem,this.merchantStore,this.merchantProfile});
  @override
  _ShopCategoryItemDescriptionState createState() => _ShopCategoryItemDescriptionState();
}

class _ShopCategoryItemDescriptionState extends BaseState<ShopCategoryItemDescription> {
  int _current = 0;
  List imageList = ['assets/images/temp_one.png','assets/images/temp_two.png','assets/images/temp_three.png'];
  CartController cartController = Get.find();

  @override
  void init() {
    cartController.loadCartFromDB();
    super.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),

        child: Column(
          children: [
            getItemImagesScrollView(),
            getAddCartContainer(),
            SizedBox(height: 8,),
            getDescriptionWidget(),
            SizedBox(height: 8,),
            getTitleAndSeeAllText(getTranslation(Strings.oftenbougtwith)),
          ],
        ),
      ),
    );
  }

  Widget  getItemImagesScrollView() {
    return Stack(
      children: [
        Container (
          height: 200,
          width: double.infinity,
          child:  CarouselSlider(
            items:imageList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context){
                  return Container(
                    child: Image(image: AssetImage(imgUrl),width: Get.width,height: 200,fit: BoxFit.fill,
                    ),
                  );
                },

              );
            }).toList(),
            options: CarouselOptions(
                enableInfiniteScroll: false,
                aspectRatio: 3.0,
                // enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Positioned(
          top: 40,
          right: 0,
          child:
          Container(
            width: 52,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(206),
                  bottomLeft:    Radius.circular(206),
                ),
                color: const Color(0x33000000)
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Positioned(
                    right: 4,
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 24,
                      width: 24,
                      child: getSvgImage(imagePath: Assets.assets_icon_c_cart,color:AppColors.color_black_100_2_2_2,
                          width: 18.0,
                          height: 18.0),
                    ).onTap(onPressed: (){

                    }
                    )
                ),
                  Positioned(
                  top: 4,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.badge_color,
                      borderRadius: Radii.border(7),
                    ),

                    child:Obx(()=> Text(cartController.getCartItemsCount(),
                      textAlign: TextAlign.center,
                      style: BaseStyles.notificationBadgeTextStyle,
                    ),
                    )
                  ),
                ),
                 ],
            ),

          ).onTap(onPressed: () {
            showCartDetailsInBottomSheet();
          }),
        ),
        Positioned(
          top: 40,
          // left: 8,
          child:
          // Rectangle
          Container(
            width: 52,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight:Radius.circular(206),
                  bottomRight:    Radius.circular(206),
                ),
                color: const Color(0x33000000)
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
                  height: 24.0,
                  width: 24.0, color: AppColors.elevation_off_2_2_2 ),
            ),

          ).onTap(onPressed: () {
            Get.back();
          }),
        ),
        Positioned(
          top: 180,
          left: Get.width/2-30,
          child: Container(
            width: 46,
            height: 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
                color: AppColors.elevation_off_2_2_2
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cartController.mapT<Widget>(imageList,(index,url){
                return Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? AppColors.color_black_100_2_2_2:AppColors.color_black_80_2_2_2
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget  getAddCartContainer() {
    return Container(
      width: double.infinity,
      height: 176,
      decoration: getCartDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width:Get.width*0.8,
                  child: Text(
                      widget.categoryItem.itemName,
                      style: TextStyles.headline6222
                  ),
                ),
                getStackWidgetAddCart()            ],
            ),

          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
                "± 200gr / Ikat",
                style:BaseTextStyles.itemPriceTextStyle
            ),
          ),
          // Rectangle
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 55,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Price / Ikat",
                            style:BaseTextStyles.descriptionPriceStyle
                        ),
                        // Rp 5.300-6.600
                        Text(
                            widget?.categoryItem?.price?.toString()??"",
                            style: TextStyles.subtitle1222
                        )
                      ],
                    ),
                  ),
                  // Container
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Container(
                        alignment: Alignment.center,
                        width: 156,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)
                          ),

                        ),
                        child: Obx(()=> showAddItemOrAddingWidget())
                    ).onTap(onPressed: (){

                    }),
                  )



                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget  getDescriptionWidget() {
    return Container(
      height: 124,
      decoration: getDescDecoration(),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
               getTranslation(Strings.description),
                style: TextStyles.subtitle1222
            ),
            // Fresh Organic Spinac
            Text(
                "Fresh Organic Spinach from reputable farm. Price per pack (200gr). Fresh until 1 week after purchase if stored in fridge.",
                style: BaseTextStyles.descriptionTextStyle
            )

          ],
        ),
      ),

    );

  }

  BoxDecoration  getCartDecoration() {
    return  BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0)),
        boxShadow: [BoxShadow(
            color: AppColors.grey2,
            offset: Offset(0,1),
            blurRadius: 0,
            spreadRadius: 0
        ),
        ] ,
        color: AppColors.elevation_off_2_2_2
    );
  }

  BoxDecoration getDescDecoration() {
    return  BoxDecoration
      (     boxShadow: [BoxShadow(
        color: AppColors.grey2,
        offset: Offset(0,1),
        blurRadius: 0,
        spreadRadius: 0
    ),
    ] ,
        color: AppColors.elevation_off_2_2_2
    );
  }

  Widget getOfterBoughtWidget() {
    return Container(

        height: 260,
        margin: EdgeInsets.only(left: 16),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return getOfterBoughtDealsListTile(); // Container


            })
    );
  }

  Widget getOfterBoughtDealsListTile() {
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
        color: AppColors.elevation_off_2_2_2
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
        Text(
            "Medicine",
            style: BaseTextStyles.ofterBoughtTitleTextStyle,
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
                color: AppColors.color_mint_100_2_2_2
            ),
            alignment: Alignment.center,
            child: Text(getTranslation(Strings.plusadd),
              style: BaseTextStyles.bUTTONBlack222,)).onTap(onPressed: () {

        }
        ),
      ],
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
              color: AppColors.elevation_off_2_2_2
          ),
          child: getSvgImage(imagePath: Assets.assets_icon_f_favorite,
              height: 16.0,
              width: 16.0),

        ).onTap(onPressed: () {

        }),
      )

    ]);
  }
  Widget getStackWidgetAddCart() {
    return Stack(children: [
      Container(
        width: 40,
        height: 40,

      ),
      Positioned(
        top: 8,
        right: 8,
        child:
        Container(
          //  width: 24,
          // height: 24,
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
              color: AppColors.elevation_off_2_2_2
          ),
          child: widget.categoryItem.favouriteItem?getSvgImage(imagePath: cartController.favouriteIcon.value,height: 16.0,width: 16.0,color: Colors.red):getSvgImage(imagePath: cartController.favouriteIcon.value,height: 16.0,width: 16.0,color:AppColors.color_black_100_2_2_2),


        ).onTap(onPressed: () {
          if(cartController.iconColor.value == AppColors.color_black_100_2_2_2){
            cartController.iconColor.value= Colors.red;
            widget.categoryItem.favouriteItem=!widget.categoryItem.favouriteItem;
          }else{
            cartController.iconColor.value= AppColors.color_black_100_2_2_2;
            widget.categoryItem.favouriteItem=!widget.categoryItem.favouriteItem;
          }
          setState(() {

          });

        }),
      )

    ]);
  }


  @override
  BuildContext getContext() {
    return context;
  }

  Widget getTitleAndSeeAllText(String title) {
    return Container(
      decoration: getDescDecoration(),
      child: Padding(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getHeadingText(title),
                  getSeeAllText(),

                ],
              ),
            ),
            SizedBox(height: 18,),
            getOfterBoughtWidget()
          ],
        ),
      ),
    );
  }

  Widget getHeadingText(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: BaseTextStyles.headline6222,
    );
  }

  Widget getSeeAllText() {
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

    });
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

            });
          },minusButton: (){

            setState(() {

            });
          }, merchantProfile: widget.merchantProfile,merchantStore: widget.merchantStore,);


        }
    );
  }


  loadCards() {
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
  }


  Widget showAddItemOrAddingWidget() {
    var list = cartController.cartItems.value.where((e) => e.id == widget.categoryItem.id).toList();
    if(list.isNotEmpty){
      return Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(4)
                ),
                color: AppColors.color_mint_100_2_2_2
            ),

            child:getSvgImage(imagePath: Assets.assets_icon_m_minus, width: 14.0,height: 14.0),

          ).onTap(onPressed: (){ // - minus
            minusWidgetOnTap(list);
          }
          ),
          Expanded(
            child: Text(
                cartController.cartItems.where((e) => e.id ==list[0].id).toList()[0].orderQuantity.toString(),
                style: TextStyles.bUTTONBlack222,
                textAlign: TextAlign.center
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(4)
                ),
                color: AppColors.color_mint_100_2_2_2
            ),
            child: getSvgImage(imagePath: Assets.icon_content_add_24_px, width: 14.0,height: 14.0),
          ).onTap(onPressed: (){
            plusWidgetOnTap(list);
          }
          )
        ],
      );
    }else{
      return  Container(
          height: 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
              color: AppColors.color_mint_100_2_2_2
          ),
          alignment: Alignment.center,
          child: // Text
          Text(getTranslation(Strings.addtocart),

            style: BaseTextStyles.bUTTONBlack222,)
      ).onTap(onPressed: (){
        widget.categoryItem.orderQuantity++;
        cartController.cartItems.add(widget.categoryItem);
        cartController.cartDB.value.write("items", cartController.cartItems);

      }
      );
    }
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
    setState(() { });
  }

  void plusWidgetOnTap(List<Item> list) {
    var matchedProduct = cartController.cartItems.firstWhere((e) => e.id ==list[0].id,orElse:()=>null);
    if(matchedProduct!=null) {
      matchedProduct.orderQuantity++;
      cartController.cartDB.value.write("items", cartController.cartItems);

    }
    setState(() { }
    );
  }




}

