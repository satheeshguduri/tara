import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';

class ShopHome extends StatefulWidget {
  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends BaseState<ShopHome> {
  int _current = 0;

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
      body: SafeArea(
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
              height: MediaQuery.of(context).size.height - 240,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: loadContent(),
              ),
            )
          ],
        ),
      ),
    );
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
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(
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
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.favorite_border), onPressed: () => {}),
                Container(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      IconButton(
                          icon: Icon(Icons.shopping_cart), onPressed: () => {}),
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
              child: getTabImage(Assets.SEARCH_ICON),
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
        CarouselSlider(
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
        ),
        Container(
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
                          margin: EdgeInsets.only(top: 4, left: 20),
                          decoration: BoxDecoration(
                            gradient: Gradients.primaryGradient,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        loadPreviousOrders(),
        loadMerchantNearYou(),

      ],
    );
  }

  List<Widget> loadCards() {
    List<Widget> arrList = List<Widget>();
    for (int i = 0; i <= 4; i++) {
      arrList.add(Container(
        height: 180,
        margin: EdgeInsets.only(left: 2, right: 16),
        child: Image.asset(Assets.ic_shop_banner),
      ));
    }
    return arrList;
  }

  loadPreviousOrders(){
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7.5.toInt(),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    getTranslation(Strings.past_purchase),
                    textAlign: TextAlign.left,
                    style: BaseStyles.bottomSheetTitleStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 2.5.toInt(),
                child: Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16),
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
                          margin: EdgeInsets.only(top: 4, left: 4, right: 16),
                          decoration: BoxDecoration(
                            gradient: Gradients.primaryGradient,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          CarouselSlider(
            items: loadPreviousOrderCards(),
            options: CarouselOptions(
//              viewportFraction: 0.2,
              // autoPlay: true,
                enableInfiniteScroll: false,
                aspectRatio: 3.3,
//                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          )
        ],
      )
    );
  }

  List<Widget> loadPreviousOrderCards() {
    List<Widget> arrList = List<Widget>();
    for (int i = 0; i <= 4; i++) {
      arrList.add(
          Container(
        margin:EdgeInsets.only(right: 8,top: 16,bottom: 8),
        padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
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
            color: AppColors.primaryBackground
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "9 Sep 2020 • 14:30",
                style: const TextStyle(
                    color:  AppColors.light_grey_blue,
                    fontWeight: FontWeight.w500,
                    fontStyle:  FontStyle.normal,
                    fontSize: 10.0
                )
            ),
            Text(
                "Toko Surya Jaya",
                style: BaseStyles.bottomSheetTitleStyle
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "8 Items - Rp 180.000",
                    style: const TextStyle(
                        color:  AppColors.light_grey_blue,
                        fontWeight: FontWeight.w500,
                        fontStyle:  FontStyle.normal,
                        fontSize: 10.0
                    )
                ),
                Container(
                    width: 88,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(6)
                        ),
                        color: AppColors.pale_turquoise
                    ),
                  child: Text(
                      getTranslation(Strings.order_again),
                      style: BaseStyles.shopPreviousOrderAgain
                  ),
                )
              ],
            )
          ],
        ),
      ));
    }
    return arrList;
  }

  loadMerchantNearYou(){
    return Column(
      children: [
        Container(
            height: 120,
            margin: EdgeInsets.only(left: 16, right: 16,top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  getTranslation(Strings.merchant_near_u),
                  textAlign: TextAlign.left,
                  style: BaseStyles.bottomSheetTitleStyle,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context,index){
                        return Container(
                          margin:EdgeInsets.only(left: 8, right: 8,top: 16,bottom: 8),
                          padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
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
                              color: AppColors.primaryBackground
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 32,
                                  height: 32,
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                      color: AppColors.light_grey_bg_color,
                                      borderRadius: Radii.border(16)
                                  )
                              ),
                              Text(
                                  "Fresh\nVeggie",
                                  style: const TextStyle(
                                      color:  AppColors.fareColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0
                                  )
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            )
        ),
        Container(
//          height: 72,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context,index){
                  return InkWell(
                    child: Container(
                      margin:EdgeInsets.only(left: 16, right: 16,top: 4,bottom:4),
                      padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
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
                          color: AppColors.primaryBackground
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 16),
                                child: Image.asset(Assets.PERSON_ICON,width: 40,height: 40,),
                              ),
                              Column(
                                children: [
                                  Text(
                                      "Toko Surya Jaya",
                                      style: const TextStyle(
                                          color:  AppColors.fareColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0
                                      )
                                  ),
                                  Container(height: 8,),
                                  Text(
                                      "Groceries • 1.5 km",
                                      style: const TextStyle(
                                          color:  AppColors.light_grey_blue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            child: Image.asset(Assets.ic_chat,),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      push(ConversationPage(arrChats: ["make_an_order"],));
                    },
                  );
                })
        )
      ],
    );
  }



}