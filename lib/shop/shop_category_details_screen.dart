

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



class ShopCategoryDetailsScreen extends StatefulWidget {
  @override
  ShopCategoryDetailsScreenState createState() => ShopCategoryDetailsScreenState();
}

class ShopCategoryDetailsScreenState extends BaseState<ShopCategoryDetailsScreen> {


  List<String> listItems = ["one","two","three","four","five","two","three","four","one","two","three","four","one","two","three","four"];
  var counter = 0;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0), // here the desired height
          child: SafeArea(child: getAppBar()),
      ),
      body: getRootContainer(),
    );
  }

    Widget  getRootContainer() {
    return GridView.count(crossAxisCount: 2,

           shrinkWrap: true,
           childAspectRatio: 0.7,
            children: listItems.map((e) => getCategoryListTile()).toList()

        );
}

  Widget getCategoryListTile() {
    counter++;
    return Container(
      width: 148,
      //margin: EdgeInsets.only(left:16,right: 16,bottom: 24),
      margin: getTheMargins(counter),
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

  Widget  dealsTileSecondRow() {
    return Column(
      children: [
        //  250gr
        // Text
        Text(
            "Medicine",
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
            "Rp 5.300-6.600",
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
          RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                        style: BaseTextStyles.bUTTONBlack222,
                        text: "+ "),
                    TextSpan(
                        style: BaseTextStyles.bUTTONBlack222,
                        text: "Add")
                  ]
              )
          ),
        ).onTap(onPressed: (){

        }
        ),
      ],
    );
  }

  Widget getStackWidget() {

    return  Stack(children: [
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
    if(counter%2==0){
      print("even"+counter.toString());
     return EdgeInsets.fromLTRB(8, 8, 16, 8);
    }else{
      print("odd"+counter.toString());
      return EdgeInsets.fromLTRB(16, 8, 8, 8);
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
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [searchIcon(), cartIcon()]);


  }

  Widget searchIcon() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 20,
      width: 20,
      child: getSvgImage(imagePath: Assets.assets_icon_s_search,
          width: 13.0,
          height: 13.0),
    ).onTap(onPressed: (){

    });
  }

  Widget cartIcon() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 20,
      width: 20,
      child: getSvgImage(imagePath: Assets.assets_icon_s_search,
          width: 13.0,
          height: 13.0),
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



}