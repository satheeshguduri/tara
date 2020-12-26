import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/common_your_purchase_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/constants/values.dart';

import 'common_bills_products_list.dart';


class PacketDataMobileNumberEntryScreen extends StatefulWidget {
  final List<BillProductDataBean> data;

   PacketDataMobileNumberEntryScreen({ Key key, this.data }) : super(key: key);

  @override
  PacketDataMobileNumberEntryScreenState createState() => PacketDataMobileNumberEntryScreenState();
}

class PacketDataMobileNumberEntryScreenState extends BaseState<PacketDataMobileNumberEntryScreen> {

  final TextEditingController controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(child: getContainer()),
    );
  }


  Widget getContainer() {
    return Container(
      child: Column(
          children: [
            Expanded(child: topRow()),
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
          "Telkomsel ",
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }


  Widget topRow() {
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
    ).onTap(onPressed: () {
      //Get.to(CommonBillsProductsListView(data:widget.data));
      Get.dialog(CommonPurchaseWidget(),);
    });
  }

  Widget hintTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 19, left: 16, right: 16),
      child: Text(
          getTranslation(Strings.PHONE_NUMBER),
          style: TextStyles.caption222
      ),
    );
  }

  Widget mobileNUmberField() {
    return Wrap(
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        phoneNumberField(), myNumberField()
      ],
    );
  }

  Widget phoneNumberField() {
    return InternationalPhoneNumberInput(
      hintText: getTranslation(Strings.enter_phone_number),
//      autoValidate:true,
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
        // controller.errorMessage.value = "";
        // controller.mobileNumber.value = number.phoneNumber;
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
      ),
      ignoreBlank: false,
      selectorTextStyle: TextStyle(color: Colors.black),
       initialValue: number,
      // textFieldController: controller.mobileNumberTextEditController,
      textFieldController: controller,
      inputBorder: InputBorder.none,
      inputDecoration: InputDecoration(
        border: InputBorder.none,
        //hintText: getTranslation(Strings.phone_number_2),
      ),
    );
  }


  Widget myNumberField() {
    return Column(
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
          //  margin: EdgeInsets.only(top: 4,left: 4,right: 16),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            gradient: Gradients.primaryGradient,
          ),
        ),
      ],
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

}