import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavorizr/parser/models/config/app.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/common_your_purchase_widget.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/models/mcpayment/card_data.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/constants/values.dart';


class BillsPaymentsSourcesScreen extends StatefulWidget {

  final BillDetailsData billDetailsData;
  BillsPaymentsSourcesScreen({ Key key,this.billDetailsData }) : super(key: key);


  @override
  BillsPaymentsSourcesScreenState createState() => BillsPaymentsSourcesScreenState();
}

class BillsPaymentsSourcesScreenState extends BaseState<BillsPaymentsSourcesScreen> {


  BillController billController = Get.find<BillController>();

  TransactionController transferController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: getAppBar(),
      appBar: CustomAppBarWidget(
          title: getTranslation(Strings.PAYMENT), addNewWidgetShow: false),
      body: Obx(() =>
          SafeArea(child: SingleChildScrollView(
              reverse: true,
              child: getContainer())
          ).withProgressIndicator(showIndicator: transferController
              .showProgress
              .value)),
    );
  }


  Widget getContainer() {
    return Container(
      height: Get.height - 88,
      child: Column(
          children: [
            Expanded(
                child: Column(
                  children: [transactionDetailRow(),
                             SizedBox(height: 16),
                             creditCardsRow(),
                             SizedBox(height: 16),
                             debitCardsRow(),],

                )
            ),
            nextButtonWidget()
          ]
      ),
    );
  }


  Widget transactionDetailRow() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonRowTitle(getTranslation(Strings.transactionDetails)),
          transactionDetailRowContainer()
        ],
      ),

    );
  }

  Widget debitCardsRow() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonRowTitle(getTranslation(Strings.paywith)),
    FutureBuilder(
    future: transferController.getCustomerProfile2(),
    builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.done)
        {
        if(snapshot.hasData){
          CustomerProfileDetailsResponse data = snapshot.data;
          return debitCardsRowContainer(data.mappedBankAccounts);
        }else if (snapshot.hasError){
        return Container();
        }else{
        return Container();
        }
        }else{
        return BaseWidgets.getIndicator;
        }

      },
    )
    ],
   ),
 );
  }


  Widget nextButtonWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: billController.btnColor.value),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.next),
        textAlign: TextAlign.center,
        style: billController.textStyle.value,
      ),
    ).onTap(onPressed: () async {

      transferController.payNow(mobileNumber: "8368951368",amount1: "100",remarks1: "from bills",bic1: "CENAID00001",cvv1: "123",initiatorAccountId1:44);
     //   transferController.payNow();

    }


    );
  }


  @override
  BuildContext getContext() => context;


  void showIfTrue() {
    billController.clickable.value = true;
    billController.btnColor.value = AppColors.bottom_border_color;
    billController.textStyle.value = BaseStyles.addNewBankAccount;
  }

  void showIfFalse() {
    billController.clickable.value = false;
    billController.btnColor.value = AppColors.billerPaymentNextButtonColor;
    billController.textStyle.value = TextStyles.bUTTONGrey3222;
  }

  Widget commonRowTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, right: 16),

      child: Text(title, style: TextStyles.caption222TextStyle,),
    );
  }

  Widget transactionDetailRowContainer() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: Radii.k8pxRadius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Image.asset(Assets.ic_bca, width: 48, height: 24,),
              //TODO ICON TO LOAD FROM NETWORK
                Container(width:Get.width*0.7,child: Text(widget.billDetailsData.productName,style: BaseStyles.contactsTextStyle,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,

                ))


            ],
          ).withPad(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8)),
          getLabeledView().withPad(padding: EdgeInsets.all(8)),
          // getLabeledView(widget.billDetailsData.category).withPad(padding: EdgeInsets.all(8)),

        ],
      ),
    );
  }

  debitCardsRowContainer(List<MappedBankAccountsBean> mappedBankAccounts) {
    return Container(
        height: 119,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mappedBankAccounts.length,
            itemBuilder: (context, index) {
              return getDebitCardListTile(mappedBankAccounts[index]); // Container


            })
    );
  }

  Widget getDebitCardListTile(MappedBankAccountsBean mappedBankAccounts) {
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
          debitCardtransactionDetailRow(),
          SizedBox(height: 16),
          debitCardAmountRow(),
          SizedBox(height: 12),
          debitCardNumberRow(mappedBankAccounts),
          SizedBox(height: 16),
        ],
      ),


    );
  }

  Widget debitCardtransactionDetailRow() {
    return Container(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
           // height: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(6)
                ),
                color: AppColors.elevation_off_2_2_2
            ),
            child: Image.asset(Assets.ic_bca),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 19),
          ),
          // Expanded(child: SizedBox()),
          Container(width: 50,
            child: getSvgImage(imagePath: Assets.assets_icon_c_check_solid,
                height: 24.0,
                width: 24.0),
           // margin: EdgeInsets.only(top: 8),

          )
        ],

      ),
    );
  }

  Widget debitCardAmountRow() {
    return Container(
        margin: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(
            "Rp 12.500.000",
            style: TextStyles.cardAmountTextStyle
        )
    );
  }

  Widget debitCardNumberRow(MappedBankAccountsBean mappedBankAccounts) {
    return Container(
        margin: EdgeInsets.only(left: 16,),
        alignment: Alignment.centerLeft,
        child:
        Text(
             getMaskedAccountNumber(mappedBankAccounts.maskedAccountNumber),
            style: TextStyles.cardNumberTextStyle
        )
    );
  }

  Widget getLabeledView() {
    return Column(
        children: [
          getProductCodeTextTextView(),
          getProductNameTextTextView(),
          getNominalTextView()]);
  }

  Widget getProductCodeTextTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Code", style: BaseStyles.purchaseLabelTextStyle),
        Text("${widget.billDetailsData.productCode}",style: TextStyles.bUTTONWhite2)
      ],
    ).withPad(padding: EdgeInsets.all(5));
  }

  Widget getProductNameTextTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Name", style: BaseStyles.purchaseLabelTextStyle),
         Container(width:Get.width*0.6,child: Text("${widget.billDetailsData.productName}",style: TextStyles.bUTTONWhite2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,

         ))
      ],
    ).withPad(padding: EdgeInsets.all(5));;
  }

  Widget getNominalTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Nominal", style: BaseStyles.purchaseLabelTextStyle),
        Text("Rp ${widget.billDetailsData.amount}",style: BaseStyles.nominalTextView)

      ],
    ).withPad(padding: EdgeInsets.all(5));
  }

  String getMaskedAccountNumber(String fullString) {
    List<String> list = fullString.split('#').toList();
    return "**** **** **"+ list[0].substring(list[0].length - 2);
  }

  creditCardsRow() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonRowTitle(getTranslation(Strings.creditCards)),
          FutureBuilder(
            future: transferController.getCards(),
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
          )
        ],
      ),
    );
  }

  creditCardsRowContainer(List<CardData> creditCards) {

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
          SizedBox(height: 16),
        ],
      ),


    ).onTap(onPressed: (){
      transferController.payViaCreditCard(creditCardData.id.mcPaymentCardId, widget.billDetailsData.amount, "Gift only", creditCardData.maskedCardNumber);
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
}