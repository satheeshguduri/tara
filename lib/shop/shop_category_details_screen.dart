

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





class ShopCategoryDetailsScreen extends StatefulWidget {

  final  int categoryId;
  ShopCategoryDetailsScreen({Key key,this.categoryId}) : super(key: key);  @override
  ShopCategoryDetailsScreenState createState() => ShopCategoryDetailsScreenState();
}

class ShopCategoryDetailsScreenState extends BaseState<ShopCategoryDetailsScreen> {


//  List<String> listItems = ["one","two","three","four","five","two","three","four","one","two","three","four","one","two","three","four"];
  var counter = 0;
  StoreController storeController = Get.find();
 List<Item> listItems;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.showProgress.value = true;
    getTheFilteredData();
    storeController.showProgress.value = false;


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("build method");
    counter = 0;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0), // here the desired height
          child: SafeArea(child: getAppBar()),
      ),
      body: Obx(() =>getRootContainer().withProgressIndicator(showIndicator: storeController.showProgress.value))

    );
  }

    Widget  getRootContainer() {
    return GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 0.7,
            children: listItems.map((categoryItem) => getCategoryListTile(categoryItem)).toList()
        );
}

  Widget getCategoryListTile(Item categoryItem) {
    counter++;
    return Container(
      width: 148,
      margin: getTheMargins(counter),
      decoration: getDealsDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dealsTileFirstRow(categoryItem),
          dealsTileSecondRow(categoryItem),
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

  Widget  dealsTileSecondRow(Item categoryItem) {
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
        Container(
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
            style: BaseTextStyles.bUTTONBlack222,)).onTap(onPressed: (){

        }
        ).onTap(onPressed: (){

        }
        ),
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

  EdgeInsetsGeometry getTheMargins(int counter) {
     print("counter value"+counter.toString());


    if(counter%2==0){
          if(counter == 2) {
            print("coming at 0");
            return EdgeInsets.fromLTRB(8, 16, 16, 8);
          }else {
            return EdgeInsets.fromLTRB(8, 8, 16, 8);
               }
     }else{
            if(counter == 1){
              print("coming at 0");
              return EdgeInsets.fromLTRB(16, 16, 8, 8);
            }else{
              return EdgeInsets.fromLTRB(16, 8, 8, 8);
            }

    }
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
          children: [searchIcon(), cartIcon()]);
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
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 24,
      width: 24,
      child: getSvgImage(imagePath: Assets.assets_icon_c_cart,color:ColorConst.color_black_100_2_2_2,
          width: 18.0,
          height: 18.0),
    ).onTap(onPressed: (){

    });
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
          iconsWidget(),
        ],
      ),
    ),
  );
}

  void getTheFilteredData() {
     listItems = storeController.itemsList.where((element) => element.category[0].id==widget.categoryId).toList();

  }



}