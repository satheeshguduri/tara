import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

import 'connect_new_account_select_ank.dart';



class MyAccountsSeeAllScreen  extends StatefulWidget {
  @override
  MyAccountsSeeAllScreenState createState() => MyAccountsSeeAllScreenState();
}

class MyAccountsSeeAllScreenState extends BaseState<MyAccountsSeeAllScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBarWidget(title: getTranslation(Strings.myAccounts),onPressed: (){
        showBottomSheet(context);
      },addNewWidgetShow: true,),
      body: SafeArea(child: getRootContainer()),
    );
  }

  Widget getRootContainer() {
    return ListView(
      children: [
        debitCardsHeadingWidget(),
        debitCardsListView(),
        creditCardsHeadingWidget(),
        creditCardsListView(),
      ],
    );
  }

  Widget  debitCardsHeadingWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16,top: 16),
      child: Text(getTranslation(Strings.debitCards),style:TextStyles.myAccountsCardTextStyle),
    );
  }
  Widget  debitCardsListView() {
    return ListView.builder(
        physics:  ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context,index){
          return customListTile();
        });
  }
  Widget  creditCardsHeadingWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16,top: 16),
      child: Text(getTranslation(Strings.creditCards),style:TextStyles.myAccountsCardTextStyle),
    );
  }
  Widget  creditCardsListView() {
    return ListView.builder(
        physics:  ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context,index){
          return customListTile();
        });
  }

  @override
  BuildContext getContext() => context;


  Widget customListTile() {
    return Container(
      height: 64,
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)
          ),
          boxShadow: [BoxShadow(
              color: const Color(0x2307c9cf),
              offset: Offset(0,4),
              blurRadius: 4,
              spreadRadius: 0
          )] ,
          gradient: LinearGradient(
              begin: Alignment(1, 1),
              end: Alignment(0, 0),
              colors: [AppColors.myAccountGradientFirstColor, AppColors.productListPriceColor])
      ),
      child:
      //Center(
      // child:
      Row(
           children: [
            Expanded(child: Row(children: [getLogo(),getCardNumber()
            ],)
            ),
            Row(children: [getDefault(),getArrow()],)
          ]),
      //),

    );
  }

  Widget  getLogo() {
    return  Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(3)
        ),
        boxShadow: [BoxShadow(
            color: const Color(0x17000000),
            offset: Offset(0,2),
            blurRadius: 4,
            spreadRadius: 0
        )] ,
        color: AppColors.primaryElement,
      ),
      child: getSvgImage(imagePath: Assets.logo_tara, width: 55.0,height: 21.0),
    );

  }
  Widget getCardNumber() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [cardNumberOnly(),bankNameOnly()
        ],),

    );

  }
  Widget getDefault() {
    return  Container(
      height: 16,
      width: 67,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(4)
        ),
        color: AppColors.primaryElement,
      ),
      child: Row(
        children: [getCheckIcon(),getDefaultText()],
      ),
    );

  }
  Widget  getArrow() {
    return  Container(
      margin: EdgeInsets.only(right: 16),
      child: getSvgImage(imagePath: Assets.assets_icon_a_arrow_right,
          width: 20.0,
          height: 20.0),
    );

  }

  Widget  cardNumberOnly() {

    return Container(
        child: Text("4*** 1234",
            style: TextStyles.subtitle1222
        )
    );


  }

  Widget bankNameOnly() {
    return  Container(
      child: Text(
        getTranslation(Strings.taraCash),
        style: TextStyles.caption222WithHeight2,
      ),
    );
  }

  Widget getCheckIcon() {
    return  Container(
      margin: EdgeInsets.only(left:8,right: 4),
      child: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
          width: 12.0,
          height: 12.0),
    );
  }

  Widget getDefaultText() {
    return // Default
      Text(
          getTranslation(Strings.defaultString),
          style:TextStyles.myAccountsDefaultTextStyle
      );
  }


  Future  showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return bottomSheetWidget();
        });
  }

  Widget bottomSheetWidget() {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
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
              Text(
                  getTranslation(Strings.addNewAccount),
                  style:TextStyles.myAccountsCardTextStyle
              ),
              Container(
                child:Column(
                  children: [ getCardTextWidget(getTranslation(Strings.addDebitCard)),getDivider(color: AppColors.light_grey_bg_color),getCardTextWidget(getTranslation(Strings.addCreditCard))


                  ],
                ),
              )
            ]
        )
    );
  }

  Widget  getCardTextWidget(String cardType) {
    return   Container(
      padding: EdgeInsets.only(top: 8,bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child:Text(
                cardType,
                style:TextStyles.bottomSheetCardTextStyle
            ) ,
          )
        ],
      ),
    ).onTap(onPressed: (){
     Get.to(ConnectNewAccountSelectBank());
    }
    );


  }








}

