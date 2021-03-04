

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
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
  final String title;
  ShopCategoryDetailsScreen({Key key,this.categoryId,this.title}) : super(key: key);  @override
  ShopCategoryDetailsScreenState createState() => ShopCategoryDetailsScreenState();
}

class ShopCategoryDetailsScreenState extends BaseState<ShopCategoryDetailsScreen> {


  var counter = 0;
  StoreController storeController = Get.find();
  CartController cartController = Get.find();



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
      body:Container(child: getRootContainer()).withPad(padding: EdgeInsets.all(16))
      // body: Obx(() =>getRootContainer().withProgressIndicator(showIndicator: storeController.showProgress.value))

    );
  }

    Widget  getRootContainer() {
    return Obx(()=>GridView.count(crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            shrinkWrap: true,
            childAspectRatio: 0.7,
            children: storeController.filteredList.map((categoryItem) => getCategoryListTile(categoryItem)).toList()
        ));
}

  Widget getCategoryListTile(Item categoryItem) {
    counter++;
    return Container(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getStackWidget(categoryItem),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.only(left: 12),
          child: Text(
              categoryItem.itemName,
              style: TextStyles.body2222
          ),
        )
      ],
    );

  }

  Widget  dealsTileSecondRow(Item categoryItem,int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16),
          child: Text(
                "Price",
             // categoryItem.category[0].name,
              style: const TextStyle(
                  color:  ColorConst.input_field_line_off_2_2_2,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SctoGroteskA",
                  fontStyle:  FontStyle.normal,
                  fontSize: 14.0
              ),
              textAlign: TextAlign.center
          ),
        ),
        SizedBox(height: 6),
        // Rp 5.300-6.600
        Container(
          margin: EdgeInsets.only(left: 16),
          child: Text(
              categoryItem.price.toString(),
              style: BaseTextStyles.subtitle3222
          ),
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
        child: Image.network("https://lh3.googleusercontent.com/proxy/10t-ngg-a9NGNtd9g3wByh41v6KYmwbOrJHob--drM7nBiiqVX9onFxRUjEDcZp7yCYipDdtskS7wfhz7y6Frs0nB9b6p3s_UxHB5ig81hgnpP3d3ex9ehAY5Wd1sdVHxyde",),
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
          child: categoryItem.favouriteItem?getSvgImage(imagePath: cartController.favouriteIcon.value,height: 16.0,width: 16.0,color: Colors.red):getSvgImage(imagePath: cartController.favouriteIcon.value,height: 16.0,width: 16.0,color:AppColors.color_black_100_2_2_2),

        ).onTap(onPressed: (){
           if(cartController.iconColor.value == AppColors.color_black_100_2_2_2){
             cartController.iconColor.value= Colors.red;
             categoryItem.favouriteItem=!categoryItem.favouriteItem;
           }else{
             cartController.iconColor.value= AppColors.color_black_100_2_2_2;
             categoryItem.favouriteItem=!categoryItem.favouriteItem;

           }
           setState(() {

           });
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
    return Text( widget.title,
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

            child: Text(getCartItemsCount(),
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
         Text(getTranslation(Strings.plusadd),
           style: BaseTextStyles.bUTTONBlack222,)
     ).onTap(onPressed: (){
       categoryItem.orderQuantity++;
       cartController.cartItems.add(categoryItem);
     }
     );
   }
  }

  String getCartItemsCount() {
    num totalCount=0;
    for(int i=0;i<cartController.cartItems.length;i++){
       totalCount = totalCount+cartController.cartItems[i].orderQuantity??0;
    }
    return totalCount.toString();
  }



}