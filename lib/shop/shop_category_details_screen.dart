

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
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/constants/color_const.dart';
import 'package:tara_app/common/constants/fonts.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/controller/cart_controller.dart';









class ShopCategoryDetailsScreen extends StatefulWidget {

  final  int categoryId;
  ShopCategoryDetailsScreen({Key key,this.categoryId}) : super(key: key);  @override
  ShopCategoryDetailsScreenState createState() => ShopCategoryDetailsScreenState();
}

class ShopCategoryDetailsScreenState extends BaseState<ShopCategoryDetailsScreen> {


  var counter = 0;
  StoreController storeController = Get.find();
  CartController cartController = Get.find();

  //List<Item> listItems;


  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.showProgress.value = true;
    storeController.filteredList.value = storeController.itemsList.where((element) => element.category[0].id==widget.categoryId).toList();
    storeController.showProgress.value = false;


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    counter = 0;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0), // here the desired height
          child: SafeArea(child: getAppBar()),
      ),
      body:getRootContainer()
      // body: Obx(() =>getRootContainer().withProgressIndicator(showIndicator: storeController.showProgress.value))

    );
  }

    Widget  getRootContainer() {
    return Obx(()=>GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 0.7,
            children: storeController.filteredList.map((categoryItem) => getCategoryListTile(categoryItem)).toList()
        ));
}

  Widget getCategoryListTile(Item categoryItem) {
    counter++;
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 148,
        //margin: getTheMargins(counter),
        decoration: getDealsDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dealsTileFirstRow(categoryItem),
            dealsTileSecondRow(categoryItem,storeController.filteredList.indexOf(categoryItem)),
          ],
        ),


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
            offset: Offset(0,2),
            blurRadius: 6,
            spreadRadius: 0
        ), BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0,0),
            blurRadius: 2,
            spreadRadius: 0
        )] ,
        color: ColorConst.elevation_off_2_2_2
    );

  }

  Widget dealsTileFirstRow(Item categoryItem) {

    return Column(
      children: [
        getStackWidget(categoryItem),
        SizedBox(height: 12),
        Text(
            categoryItem.itemName,
            style: TextStyles.body2222
        )
      ],
    );

  }

  Widget  dealsTileSecondRow(Item categoryItem,int index) {
    return Column(
      children: [
        Text(
            categoryItem.category[0].name,
            style: const TextStyle(
                color:  ColorConst.input_field_line_off_2_2_2,
                fontWeight: FontWeight.w500,
                fontFamily: "SctoGroteskA",
                fontStyle:  FontStyle.normal,
                fontSize: 14.0
            ),
            textAlign: TextAlign.center
        ),
        SizedBox(height: 6),
        // Rp 5.300-6.600
        Text(
            categoryItem.price.toString(),
            style: BaseTextStyles.subtitle3222
        ),
        SizedBox(height: 8),
        showAddItemOrAddingWidget(categoryItem),

      ],
    );
  }

  Widget getStackWidget(Item categoryItem) {

    return  Stack(children: [
      Container(
        width: 148,
        height: 100,
        child: Image.network(categoryItem.category[0].imageUrl),
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
                  offset: Offset(0,4),
                  blurRadius: 6,
                  spreadRadius: 0
              ), BoxShadow(
                  color: const Color(0x14000000),
                  offset: Offset(0,0),
                  blurRadius: 2,
                  spreadRadius: 0
              )] ,
              color: ColorConst.elevation_off_2_2_2
          ),
          child: getSvgImage(imagePath: Assets.assets_icon_f_favorite,height: 16.0,width: 16.0),

        ).onTap(onPressed: (){

        }),
      )

    ]);

  }




  Widget backArrowIcon() {
    return Container(
      margin: EdgeInsets.only(left:16,right: 12),
      child: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
          width: 24.0,
          height: 24.0),
    ).onTap(onPressed: (){
      pop();
    });
  }

  Widget titleWidget() {
    return Text( getTranslation(Strings.meatandseafood),
      overflow: TextOverflow.ellipsis,
      style: BaseStyles.topBarTextStyle,
    );

  }

  Widget iconsWidget() {
      return  Row(
         mainAxisAlignment: MainAxisAlignment.end,
          children: [searchIcon(),
           Container( width: 48,height: 48,child:cartIcon())
          //  )
          ]
      );
  }


  Widget searchIcon() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 24,
      width: 24,
      child: getSvgImage(imagePath: Assets.assets_icon_s_search,color:ColorConst.color_black_100_2_2_2,
          width: 18.0,
          height: 18.0),
    ).onTap(onPressed: (){

    });
  }

  Widget cartIcon() {
  return  Stack(
      alignment: Alignment.centerRight,
      children: [
        Positioned(
          right: 4,
          child: Container(
            margin: EdgeInsets.only(right: 16),
            height: 24,
            width: 24,
            child: getSvgImage(imagePath: Assets.assets_icon_c_cart,color:ColorConst.color_black_100_2_2_2,
                width: 18.0,
                height: 18.0),
          ).onTap(onPressed: (){

          }
        )
      ),
       Obx(()=> Positioned(
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
            child: Text(
              cartController.cartItems.length.toString(),
              textAlign: TextAlign.center,
              style: BaseStyles.notificationBadgeTextStyle,
            ),
          ),
        ),
       ) ],
    );
  }

 Widget getAppBar() {
  return Container(

    decoration: BoxDecoration(
      boxShadow: [BoxShadow(
          color: AppColors.billerPaymentNextButtonColor,
          offset: Offset(0,1),
          blurRadius: 0,
          spreadRadius: 0
      )] ,
      color: AppColors.primaryElement,),
    height: 56,
    child: Center(
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              backArrowIcon(),
              titleWidget(),
            ],
          ),
          Expanded(child: iconsWidget()),
        ],
      ),
    ),
  );
}




  bool isMatched(String current,String index){

   // print("checking match ==> $current == $index");
    return current==index;

  }

 Widget showAddItemOrAddingWidget(Item categoryItem) {

   var list = cartController.cartItems.value.where((e) => e.id == categoryItem.id).toList();
   if(list.isNotEmpty){
     return Container(
       height: 32,
       margin: EdgeInsets.only(bottom: 12,left: 12,right: 12),

       child: Row(
         children: [
         Container(
         width: 32,
         height: 32,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.all(
                 Radius.circular(4)
             ),
             color: ColorConst.color_mint_100_2_2_2
         ),

         child:getSvgImage(imagePath: Assets.assets_icon_m_minus, width: 14.0,height: 14.0),

       ).onTap(onPressed: (){ // - minus
           var matchedProduct = cartController.cartItems.firstWhere((e) => e.id ==list[0].id,orElse:()=>null);
           if(matchedProduct!=null) {
             matchedProduct.orderQuantity--;
              if(matchedProduct.orderQuantity==0){
                cartController.cartItems.remove(matchedProduct);
              }
           }


         setState(() {

         });

       }),
           Expanded(
             child: Text(
                 cartController.cartItems.where((e) => e.id ==list[0].id).toList()[0].orderQuantity.toString(),
                // list[0].orderQuantity.toString(),
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
             color: ColorConst.color_mint_100_2_2_2
         ),
         child: getSvgImage(imagePath: Assets.icon_content_add_24_px, width: 14.0,height: 14.0),
       ).onTap(onPressed: (){
         var matchedProduct = cartController.cartItems.firstWhere((e) => e.id ==list[0].id,orElse:()=>null);
         if(matchedProduct!=null) {
           matchedProduct.orderQuantity++;
         }
         setState(() {

         }
         );
       })        ],
       ),
     );
   }else{
     return  Container(
         height: 32,
         margin: EdgeInsets.only(bottom: 12,left: 12,right: 12),
         decoration: BoxDecoration(
             borderRadius: BorderRadius.all(
                 Radius.circular(8)
             ),
             color: ColorConst.color_mint_100_2_2_2
         ),
         alignment: Alignment.center,
         child: // Text
         Text("+ Add",
           style: BaseTextStyles.bUTTONBlack222,)
     ).onTap(onPressed: (){
       categoryItem.orderQuantity++;
       cartController.cartItems.add(categoryItem);
     }
     );
   }
  }



}