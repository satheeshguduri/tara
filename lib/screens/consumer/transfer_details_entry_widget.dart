import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';

import 'Transfer_Details_Entry_Widget_Controller.dart';


class TransferDetailsEntryWidget extends StatefulWidget {
  TransferDetailsEntryWidget({ Key key,}) : super(key: key);

  @override
  TransferDetailsEntryWidgetState createState() => TransferDetailsEntryWidgetState();
}

class TransferDetailsEntryWidgetState extends BaseState<TransferDetailsEntryWidget> {

  TransferDetailsEntryWidgetController controller = TransferDetailsEntryWidgetController();
  var formKey = GlobalKey<FormState>();
  String bic;
  num accountTokenId;
  @override
  void initState() {
    super.initState();
        controller.getCustomerProfile2() ;
  }

  @override
  Widget build(BuildContext context)  {
      return Obx(() =>SafeArea(
          top: false,
          child: Container(
              margin: EdgeInsets.only(top: 30),
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
                        padding: EdgeInsets.only(left: 20,right: 16,top:                           8,bottom: 8),
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
                                Expanded(child: TextWithBottomOverlay(titleStr: getTranslation(Strings.transfer))),
                                Container(
                                    child: getSvgImage(imagePath: Assets.close_icon).onTap(onPressed: ()=> pop())
                                ),
                              ],
                            ),
                            Container(
                              child: Form(
                                key: formKey,
                                child: Column(
                                    children: [
                                      getAmountWidget(),
                                      getTheDivider(),
                                      serviceFeeWidget(),
                                      getMessageWidget(),
                                      getTheDivider(),
                                      categoryTransferWidget(),
                                      getTheDivider(),
                                      paymentSourceWidget(),
                                      getTheDivider(),
                                      cvvWidget(),
                                      getTheDivider(),

                                    ]),
                              ),
                            ),
                            getContinueWidget()
                          ],
                        ),
                      ),
                    ),
                  )
              )
          ).withProgressIndicator(showIndicator: controller.showProgress.value),
      )
     );
  }




  Widget getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 24,top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.confirm),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: (){
      if(formKey.currentState.validate()){
        controller.confirmToPay(bic,accountTokenId);
      }
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }


 Widget getAmountWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [commonTextWidget(getTranslation(Strings.AMOUNT)),amountTextField()],

  );


 }
  Widget commonTextWidget(String text) {
    return Text(
        text,
        style: TextStyles.caption222TextStyle
    );

  }

  Widget amountTextField() {
    return  Container(
      height: 48,
      child: TextFormField(
         controller: controller.amountController,
         decoration:  removeUnderlineAndShowHint(getTranslation(Strings.entertheamount)),
         keyboardType: TextInputType.number,
         style: TextStyles.inputFieldOn222,
         validator: (value) {
           return getTranslation(controller.validateAmountWidget(value));
         },
       ),
    );
  }

 Widget serviceFeeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [// Service fee
          Text(
              getTranslation(Strings.servicefee),
              style:TextStyles.serviceFeeTextStyle
          )
          ,Text(
   "+ Rp 4.500",
   style: TextStyles.caption222TextStyle
          ),
        ],
      ),
    );

  }

 Widget getMessageWidget() {
    return  Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commonTextWidget(getTranslation(Strings.message)),messageTextField()],
      ),
    );


  }

 Widget messageTextField() {
    return  Container(
      height: 62,
      margin: EdgeInsets.only(bottom: 11),
      child: TextFormField(
        controller: controller.messageController,
        decoration:  removeUnderlineAndShowHint(getTranslation(Strings.typeyourmessage)),
        keyboardType: TextInputType.text,
        maxLines: 2,
        style: TextStyles.inputFieldOn222,
          validator: (value) {
          return getTranslation(controller.validateMessageWidget(value));
        },
      ),
    );
  }

  categoryTransferWidget()  {
    return  Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commonTextWidget(getTranslation(Strings.categorytransfer)),
          getCategoryDropDownList(),],
      ),
    );


  }



 Widget paymentSourceWidget() {
    return  Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commonTextWidget(getTranslation(Strings.PAYMENT_SOURCE)),
          getPaymentsDropDownList(),
        ],
      ),
    );


  }



 Widget cvvWidget() {
    return  Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commonTextWidget(getTranslation(Strings.cvv)),cvvTextField()],
      ),
    );


  }

 Widget cvvTextField() {
    return  Container(
      height: 48,
      child: TextFormField(
        decoration:  removeUnderlineAndShowHint(getTranslation(Strings.enterthecvv)),
        style: TextStyles.inputFieldOn222,
        obscureText: true,
        obscuringCharacter: "*",
        controller: controller.cvvController,
        keyboardType: TextInputType.number,
        validator: (value) {
          return getTranslation(controller.validateCvvWidget(value));
        },
      ),
    );
  }


  Divider getTheDivider() {
    return Divider(
      color: AppColors.input_field_line_off_2_2_2,
      height: 1,
    );
  }

InputDecoration  getUnderLineBorder() {
  return  InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(
            //  color: AppColors.input_field_line_off_2_2_2,

              color: Colors.red
            )
        )
    );
  }

 Widget getCategoryDropDownList() {
   return Container(
     height: 48,
     child: DropdownButtonFormField(
       decoration:  removeUnderlineAndShowHint(""),
       icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),
       style: TextStyles.inputFieldOn222,
       value: controller.currentSelectedCategory.value,
       isExpanded: true,

       onChanged: (String selectedCategory)
       {
         controller.currentSelectedCategory.value = selectedCategory;
       },

       items: <String>['Gift', 'Credit', 'Shopping']
           .map<DropdownMenuItem<String>>((String value) {
         return DropdownMenuItem<String>(
           value: value,
           child: Text(value),
         );
       }).toList(),

     ),
   );
 }

  Widget getPaymentsDropDownList() {
  return
    //Obx(()=>
     Container(
       height: 48,
       child: DropdownButtonFormField(
          decoration: removeUnderlineAndShowHint(""),
          icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),
           style: TextStyles.inputFieldOn222,
           isExpanded: true,
          items:// controller.customerProfile.value?.mappedBankAccounts??[]{
          (controller.mappedItems.value)?.map((MappedBankAccountsBean item) {
            return DropdownMenuItem<String>(
              child: getCustomItemWidget(item.bankName,item.maskedAccountNumber),
              //Text(item.bankName),
              onTap: (){
                bic = item.bic;
                accountTokenId = item.accountTokenId;
              },
            );
          })?.toList()??[],
         onChanged: (val){
         }

        ),
     );
 // );
  }

 Widget getCustomItemWidget(String bankname, String maskedAccountNumber) {
    return Row(
      children: [
        Container(margin: EdgeInsets.only(right: 8),
          child: Image.asset(Assets.ic_bca,)),
          Text(bankname+" - "+controller.getAccountNumberOnly(maskedAccountNumber),style: TextStyles.inputFieldOn222
          )],
    );

  }

  InputDecoration removeUnderlineAndShowHint(String hint) {
    return InputDecoration(border: InputBorder.none,hintText: hint);
  }




}
