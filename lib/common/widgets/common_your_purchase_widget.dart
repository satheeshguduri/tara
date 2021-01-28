import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/consumer/transfer/bills_payment_soucres_screen.dart';


class CommonPurchaseWidget extends StatefulWidget {
  final BillDetailsData billDetailsData;
  CommonPurchaseWidget({ Key key,this.billDetailsData}) : super(key: key);

  @override
  CommonPurchaseWidgetState createState() => CommonPurchaseWidgetState();
}

class CommonPurchaseWidgetState extends BaseState<CommonPurchaseWidget> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.90,
                    child: Container(
                      padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x1f000000),
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: 0),
                            BoxShadow(
                                color: const Color(0x14000000),
                                offset: Offset(0, 0),
                                blurRadius: 2,
                                spreadRadius: 0)
                          ],
                          color: AppColors.primaryBackground),
                      child:  Wrap(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(child: TextWithBottomOverlay(titleStr: getTranslation(Strings.yourpurchase))),
                              Container(
                                  child: getSvgImage(imagePath: Assets.close_icon).onTap(onPressed: ()=> pop())
                              ),
                            ],
                          ),
                          getDivider(color: Colors.grey[200]),
                          getProductDetailWidget(),
                          Container(
                            child: Column(
                                children: [
                                  billDetailsText(),
                                  priceThreeRows(Strings.price,"${widget.billDetailsData.amount}"),
                                  priceThreeRows(Strings.adminfee,"${widget.billDetailsData.totalAdmin}"),
                                  priceThreeRows(Strings.servicefee,"${widget.billDetailsData.processingFee}"),
                                  dividerRow(),
                                  totalRow()

                                ]),
                          ),
                          getContinueWidget()
                        ],
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }
  Widget getNominalTextView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Nominal",style: BaseStyles.purchaseLabelTextStyle),
        Text("Rp ${widget.billDetailsData.amount}",style: BaseStyles.nominalTextView)
      ],
    ).withPad(padding: EdgeInsets.all(5));
  }
  Widget getCustomerIdTextView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Customer Id",style: BaseStyles.purchaseLabelTextStyle),
        Text("${widget.billDetailsData.accountNumber}",style: TextStyles.bUTTONWhite2)
      ],
    ).withPad(padding: EdgeInsets.all(5));
  }
  Widget getProductCodeTextTextView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Code",style: BaseStyles.purchaseLabelTextStyle),
        Text("${widget.billDetailsData.productCode}",style: TextStyles.bUTTONWhite2)
      ],
    ).withPad(padding: EdgeInsets.all(5));
  }
  Widget getProductNameTextTextView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Name",style: BaseStyles.purchaseLabelTextStyle),
        Text("${widget.billDetailsData.productName}",style: TextStyles.bUTTONWhite2)
      ],
    ).withPad(padding: EdgeInsets.all(5));;
  }
  Widget getLabeledView(category){
    switch(category) {
        case "Pulsa":
        case "Paket Data":
        case "Internet dan TV Kabel":
          return Column(
            children: [
              getProductCodeTextTextView(),
              getProductNameTextTextView(),
              getNominalTextView()
            ],
          );
          break;
        default:
        return Column(
          children: [
            getProductNameTextTextView(),
            getProductCodeTextTextView(),
            getNominalTextView()

          ],
        );
        break;

    }

  }


  Container getProductDetailWidget() {
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
              Image.asset(Assets.BJPS_ICON,width: 24,height:24,),//TODO ICON TO LOAD FROM NETWORK
              Text(widget.billDetailsData.productName,style: BaseStyles.contactsTextStyle)
            ],
          ).withPad(padding: EdgeInsets.only(top:10,bottom:10,left:8,right:8)),
          getLabeledView(widget.billDetailsData.category).withPad(padding: EdgeInsets.all(8)),
        ],
      ),
    );
  }



  Widget getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16,top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.paynow),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: (){
        Get.to(BillsPaymentsSourcesScreen(billDetailsData: widget.billDetailsData));
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }



  Widget dividerRow() {
   return Container(
      color: Colors.grey[200],
      height: 1,
    );
  }

 Widget  billDetailsText() {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(top: 16,bottom:16),
    child: Text(
          getTranslation(Strings.bill_details),
          style: TextStyles.subtitle1222
      ),
  );
  }

 Widget priceThreeRows(String detail,String value) {

   return Container(
     margin: EdgeInsets.only(top: 8,bottom: 8),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [

         Text(
             getTranslation(detail),
             style:TextStyles.yourPurchaseBillsDetailsTextStyle
         ),
         Text(
              getTranslation(Strings.RP)+" "+value,
             style:TextStyles.yourPurchaseBillsDetailsTextStyle
         ),

       ],
     ),
   );

  }



 Widget totalRow() {
    return // Total
      Container(
        margin: EdgeInsets.only(top: 8,bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
                getTranslation(Strings.total),
                style:TextStyles.yourPurchaseBillsTotalTextStyle
            ),
            Text(
                getTranslation(Strings.RP)+" "+"${widget.billDetailsData.amount}",
                style:TextStyles.yourPurchaseBillsTotalTextStyle
            ),

          ],
        ),
      );

 }

}
