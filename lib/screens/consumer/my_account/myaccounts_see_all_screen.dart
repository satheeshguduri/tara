import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/mcpayment/card_data.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'connect_new_account_select_ank.dart';
import 'package:async/async.dart';




class MyAccountsSeeAllScreen  extends StatefulWidget {
  @override
  MyAccountsSeeAllScreenState createState() => MyAccountsSeeAllScreenState();
}

class MyAccountsSeeAllScreenState extends BaseState<MyAccountsSeeAllScreen> {

  TransactionController transactionController = Get.find();
  final AsyncMemoizer dCMemorizer = AsyncMemoizer();
  final AsyncMemoizer cCMemorizer = AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: getTranslation(Strings.myAccounts), onPressed: () {
        //transactionController.opacityValue.value = 0.0;
       // transactionController.loadingColor.value = Colors.transparent;

        showBottomSheet(context);
      }, addNewWidgetShow: true,),
      body: Obx(() => SafeArea(child: getRootContainer()).withProgressIndicator(showIndicator: transactionController
          .showProgress
          .value)),



      // Obx(()=> SafeArea(
      //     child: getRootContainer().withProgressIndicator(showIndicator: transactionController.showProgress.value)),
      // ),





    );
  }

  Widget getRootContainer() {
    return ListView(
      children: [
        debitCardsHeadingWidget(),
        debitCardsListView(),
        creditCardsHeadingWidget(),
        creditCardsListView().paddingAll(16),
      ],
    );
  }

  Widget debitCardsHeadingWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16),
      child: Text(getTranslation(Strings.debitCards),
          style: TextStyles.myAccountsCardTextStyle),
    );
  }

  Widget debitCardsListView() {
    return FutureBuilder(
      future: dCMemorizer.runOnce(()=>transactionController.getCustomerProfile2()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          CustomerProfileDetailsResponse data = snapshot.data;
          return showList(data.mappedBankAccounts);
        }
        return BaseWidgets.getIndicator;
      },
    );
  }

  Widget creditCardsHeadingWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16),
      child: Text(getTranslation(Strings.creditCards),
          style: TextStyles.myAccountsCardTextStyle),
    );
  }

  Widget creditCardsListView() {
    TransactionController transferController = Get.find();
    return FutureBuilder(
      future:cCMemorizer.runOnce(()=> transferController.getCards()),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.done)
        {
          if(snapshot.hasData){
            List<CardData> data = snapshot.data;
            return creditCardsRowContainer(data);
          }else if (snapshot.hasError){
            return Container();
          }else{
            return Container();
          }
        }else{
          return BaseWidgets.getIndicator;
        }

      },
    );
  }

  @override
  BuildContext getContext() => context;

  Widget creditCardsRowContainer(List<CardData> creditCards) {

    //filter the cards only with response success
    creditCards = creditCards.where((element) => element.status == "success").toList();

    return Container(
        height: 119,
        child: ListView.builder(

            scrollDirection: Axis.horizontal,
            itemCount: creditCards.length,
            itemBuilder: (context, index) {

              return getCreditCardListTile(creditCards[index]); // Container
            }
        )

    );
  }

  Widget getCreditCardListTile(CardData creditCardData) {
    return Container(
      width: 208,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(12)
          ),
          boxShadow: [BoxShadow(
              color: const Color(0x23000000),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0
          )
          ],
          gradient: LinearGradient(
              begin: Alignment(1, 1),
              end: Alignment(0.008085664335664378, 0.008085664335664378),
              colors: [const Color(0xff0060af), const Color(0xffb2dcff)])
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          creditCardtransactionDetailRow(creditCardData),
          SizedBox(height: 16),
          creditCardNumberRow(creditCardData),
          SizedBox(height: 12),
          creditCardNameRow(creditCardData),
          // SizedBox(height: 16),
        ],
      ),


    ).onTap(onPressed: (){
      // transferController.payViaCreditCard(creditCardData.id.mcPaymentCardId, widget.billDetailsData.amount, "Gift only", creditCardData.maskedCardNumber);
    });
  }

  Widget  creditCardtransactionDetailRow(CardData creditCardData) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 180,
            child:  Text(
                creditCardData.bankIssuer,
                style: TextStyles.cardAmountTextStyle,
                overflow: TextOverflow.ellipsis
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16,),
          ),

        ],

      ),
    );
  }

  Widget creditCardNumberRow(CardData creditCardData) {
    return Container(
        margin: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(
            creditCardData.maskedCardNumber,
            style: TextStyles.cardAmountTextStyle
        )
    );
  }


  Widget creditCardNameRow(CardData creditCardData) {
    return Container(
        margin: EdgeInsets.only(left: 16,),
        alignment: Alignment.centerLeft,
        child:
        Text(
            creditCardData.cardHolderName,
            style: TextStyles.cardNumberTextStyle
        )
    );
  }
  Widget customListTile(MappedBankAccountsBean mappedBankAccountsBean) {
    return Container(
      height: 64,
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)
          ),
          boxShadow: [BoxShadow(
              color: const Color(0x2307c9cf),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0
          )
          ],
          gradient: LinearGradient(
              begin: Alignment(1, 1),
              end: Alignment(0, 0),
              colors: [
                AppColors.myAccountGradientFirstColor,
                AppColors.productListPriceColor
              ])
      ),
      child:
      //Center(
      // child:
      Visibility(
        visible: mappedBankAccountsBean.isDefault,
        child: Row(
            children: [
              Expanded(child: Row(children: [getLogo(), getCardNumber(mappedBankAccountsBean)
              ],)
              ),
              Row(children: [getDefault(), getArrow()],)
            ]),
      ),
      //),

    );
  }

  Widget getLogo() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(3)
        ),
        boxShadow: [BoxShadow(
            color: const Color(0x17000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0
        )
        ],
        color: AppColors.primaryElement,
      ),
      child: getSvgImage(
          imagePath: Assets.logo_tara, width: 55.0, height: 21.0),
    );
  }

  Widget getCardNumber(MappedBankAccountsBean mappedBankAccountsBean) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [cardNumberOnly(mappedBankAccountsBean.maskedAccountNumber), bankNameOnly()
        ],),

    );
  }

  Widget getDefault() {
    return Container(
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
        children: [getCheckIcon(), getDefaultText()],
      ),
    );
  }

  Widget getArrow() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: getSvgImage(imagePath: Assets.assets_icon_a_arrow_right,
          width: 20.0,
          height: 20.0),
    );
  }

  Widget cardNumberOnly(String maskedAccountNumber) {
    return Container(
        child: Text(
            getMaskedAccountNumber(maskedAccountNumber),
            style: TextStyles.subtitle1222
        )
    );
  }

  Widget bankNameOnly() {
    return Container(
      child: Text(
        getTranslation(Strings.taraCash),
        style: TextStyles.caption222WithHeight2,
      ),
    );
  }

  Widget getCheckIcon() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 4),
      child: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
          width: 12.0,
          height: 12.0),
    );
  }

  Widget getDefaultText() {
    return // Default
      Text(
          getTranslation(Strings.defaultString),
          style: TextStyles.myAccountsDefaultTextStyle
      );
  }


  Future showBottomSheet(BuildContext context) {
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
              Text(
                  getTranslation(Strings.addNewAccount),
                  style: TextStyles.myAccountsCardTextStyle
              ),
              Container(
                child: Column(
                  children: [
                    getCardTextWidget(getTranslation(Strings.addDebitCard)).paddingOnly(top:10),
                    getDivider(color: AppColors.light_grey_bg_color),
                    getCardTextWidget(getTranslation(Strings.addCreditCard)).paddingOnly(top:10),
                   // Opacity(opacity: transactionController.opacityValue.value,child: CircularProgressIndicator(strokeWidth: 5.0,),)
                   //  SpinKitDoubleBounce(
                   //    color: transactionController.loadingColor.value,
                   //    size: 50.0,)



                  ],
                ),
              )
            ]
        )
    );
  }

  Widget getCardTextWidget(String cardType) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Text(
                cardType,
                style: TextStyles.bottomSheetCardTextStyle
            ),
          )
        ],
      ),
    ).onTap(onPressed: () {
      if(cardType == getTranslation(Strings.addDebitCard)){
         Get.to(ConnectNewAccountSelectBank());
        // Get.back();
      }else{
       // transactionController.opacityValue.value = 0.5;
       transactionController.addCard();
       Get.back();
       // transactionController.loadingColor.value = Colors.transparent;


      }

    }
    );
  }

  Widget showList(List<MappedBankAccountsBean> mappedBankAccounts) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: mappedBankAccounts.length,
        itemBuilder: (context, index) {
          return customListTile(mappedBankAccounts[index]);
        });
  }

  String getMaskedAccountNumber(String fullString) {
    List<String> list = fullString.split('#').toList();
    return "****"+ list[1].substring(list[0].length - 4);
  }
}