import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/common_your_purchase_widget.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/constants/values.dart';

import 'common_bills_products_list.dart';


class PacketDataMobileNumberEntryScreen extends StatefulWidget {
  final BillProductDataBean data;

   PacketDataMobileNumberEntryScreen({ Key key, this.data }) : super(key: key);

  @override
  PacketDataMobileNumberEntryScreenState createState() => PacketDataMobileNumberEntryScreenState();
}

class PacketDataMobileNumberEntryScreenState extends BaseState<PacketDataMobileNumberEntryScreen> {

  //final TextEditingController controller = TextEditingController();
 // PhoneNumber number = PhoneNumber(isoCode: 'ID');
  BillController billController = Get.find<BillController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Obx(() =>SafeArea(child: getContainer()).withProgressIndicator(showIndicator: Get.find<BillController>().showProgress.value)),
    );
  }


  Widget getContainer() {
    return Container(
      // color: Colors.pink,
      child: Column(
          children: [
            Expanded(child:getTopRow(widget.data.category)),
            bottomRow()
          ]
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false,
      // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            pop();
          }),
      title: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.data.category,
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }


  Widget getPaketDataWidget() {
    return Column(
      children: [
        hintTitle(),
        mobileNUmberField(),
        getTheDivider()
      ],
    );
  }

  Widget bottomRow() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16, left: 16,right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.billerPaymentNextButtonColor),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.next),
        textAlign: TextAlign.center,
        style: TextStyles.bUTTONGrey3222,
      ),
    ).onTap(onPressed: () async{
      Get.find<BillController>().check(widget.data,(){
        sendBottomSheet(Get.find<BillController>().productDetail);
      });
    });
  }

  Widget hintTitle({String title = Strings.PHONE_NUMBER}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 19, left: 16, right: 16),
      child: Text(
          getTranslation(title),
          style: TextStyles.caption222
      ),
    );
  }

  Widget mobileNUmberField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
       // phoneNumberField(),
        Expanded(
          child: TextFieldWidget(hint:"Phone Number",inputType: TextInputType.number,textController: billController.phoneNumberController,isIcon: false,focusNode: FocusNode(),onChanged:(value){
            setState(() {
            });
          }),
        ),
        myNumberField()
      ],
    ).withPad(padding: EdgeInsets.only(left:16,right:16));
  }

  Widget phoneNumberField() {
    return Container(
      height:48,
      width: MediaQuery.of(context).size.width-100,
      child: TextField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        controller: billController.phoneNumberController,
        decoration: InputDecoration(
          hintText: getTranslation(Strings.enter_phone_number),
          hintStyle: TextStyles.inputFieldOff222,
          labelText: getTranslation(Strings.PHONE_NUMBER),
          labelStyle: TextStyles.caption222
        ),
      ),
    );
//     return InternationalPhoneNumberInput(
//       hintText: getTranslation(Strings.enter_phone_number),
// //      autoValidate:true,
//       onInputChanged: (PhoneNumber number) {
//         print(number.phoneNumber);
//         // controller.errorMessage.value = "";
//         // controller.mobileNumber.value = number.phoneNumber;
//       },
//       onInputValidated: (bool value) {
//         print(value);
//       },
//       selectorConfig: SelectorConfig(
//         selectorType: PhoneInputSelectorType.DROPDOWN,
//       ),
//       ignoreBlank: false,
//       selectorTextStyle: TextStyle(color: Colors.black),
//        initialValue: number,
//       // textFieldController: controller.mobileNumberTextEditController,
//       textFieldController: controller,
//       inputBorder: InputBorder.none,
//       inputDecoration: InputDecoration(
//         border: InputBorder.none,
//         //hintText: getTranslation(Strings.phone_number_2),
//       ),
//     );
  }


  Widget myNumberField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(getTranslation(Strings.mynumber),
                textAlign: TextAlign.center,
                style: TextStyles.bUTTONSmallBlack222,
              ),
            ),
          ),
          Container(
            height: 2,
            width:60,
            //  margin: EdgeInsets.only(top: 4,left: 4,right: 16),
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              gradient: Gradients.primaryGradient,
              color: Colors.red
            ),
          ),
        ],
      ),
    );
  }

  @override
  BuildContext getContext() => context;

  Container getTheDivider() {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Divider(
        color: AppColors.billerPaymentDiviederColor,
        height: 1,
      ),
    );
  }
  Future sendBottomSheet(BillDetailsData billDetailsData) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return CommonPurchaseWidget(billDetailsData:billDetailsData);
        });
  }

Widget getTopRow(String category) {

      switch(category){
      case "Paket Data": {
        return getPaketDataWidget();
      }
      break;
      case "Voucher Game":{
        return getVoucherGameWidget();
      }
      break;
        case "Streaming 1":{
          return getStreaming1Widget();
        }
      break;
        case "Voucher Digital":{
         return getVoucherDigitalWidget();

        }
        break; case "Pulsa":{
        return getPulsaWidget();

      }
      break; case "Gas 1":{
        return getGas1Widget();

      }
      break; case "BPJS":{
        return getBPJSWidget();

      }
      break; case "Pembayaran Angsuran":{
        return getPembayaranAngsuranWidget();

      }
      break; case "Pascabayar":{
        return getPascabayarWidget();

      }
      break; case "Internet dan TV Kabel":{
        return getInternetdanTVKabelWidget();

      }
      break;

    return Container();
}

}


getCustomerIdWidget(){

}
  Widget getStreaming1Widget() {
    return Column(
      children: [
        hintTitle(),
        mobileNUmberField(),
        getTheDivider()
      ],
    );
  }

  Widget getVoucherDigitalWidget() {
    return Column(
      children: [
        hintTitle(),
        mobileNUmberField(),
        getTheDivider()
      ],
    );

  }

  Widget getPulsaWidget() {
    return Column(
      children: [
        hintTitle(),
        mobileNUmberField(),
        getTheDivider()
      ],
    );

  }

  Widget getGas1Widget() {
    return  Column(
      children: [
        hintTitle(),
        mobileNUmberField(),
        getTheDivider()
      ],
    );

  }

  Widget getBPJSWidget() {
    return Column(
      children: [
        hintTitle(title:Strings.customer_id),
        TextFieldWidget(hint:getTranslation(Strings.customer_id),inputType: TextInputType.number,textController: billController.phoneNumberController,isIcon: false,focusNode: FocusNode(),onChanged:(value){
          setState(() {
          });
        }).withPad(padding: EdgeInsets.only(left:16,right:16)),
        getTheDivider()
      ],
    );

  }

  Widget getPembayaranAngsuranWidget() {
    return Column(
      children: [
        hintTitle(title:Strings.account_number),
        TextFieldWidget(hint:getTranslation(Strings.account_number),inputType: TextInputType.number,textController: billController.phoneNumberController,isIcon: false,focusNode: FocusNode(),onChanged:(value){
          setState(() {
          });
        }).withPad(padding: EdgeInsets.only(left:16,right:16)),
        getTheDivider()
      ],
    );

  }

  Widget getPascabayarWidget() {
    return Column(
      children: [
        hintTitle(title:Strings.account_number),
        TextFieldWidget(hint:getTranslation(Strings.account_number),inputType: TextInputType.number,textController: billController.phoneNumberController,isIcon: false,focusNode: FocusNode(),onChanged:(value){
          setState(() {
          });
        }).withPad(padding: EdgeInsets.only(left:16,right:16)),
        getTheDivider()
      ],
    );

  }

  Widget getInternetdanTVKabelWidget() {
    return Column(
      children: [
        hintTitle(title:Strings.account_number),
        TextFieldWidget(hint:getTranslation(Strings.account_number),inputType: TextInputType.number,textController: billController.phoneNumberController,isIcon: false,focusNode: FocusNode(),onChanged:(value){
          setState(() {
          });
        }).withPad(padding: EdgeInsets.only(left:16,right:16)),
        getTheDivider()
      ],
    );

  }

  Widget getVoucherGameWidget() {
    return Column(
      children: [
        hintTitle(title:Strings.account_number),
        TextFieldWidget(hint:getTranslation(Strings.account_number),inputType: TextInputType.number,textController: billController.phoneNumberController,isIcon: false,focusNode: FocusNode(),onChanged:(value){
          setState(() {
          });
        }).withPad(padding: EdgeInsets.only(left:16,right:16)),
        getTheDivider()
      ],
    );

  }

 Widget paymentUntilRow() {
    return Container(
      padding: EdgeInsets.only(),
    );
  }

 Widget NIKBillingRow() {

  }




}