/*
*  add_beneficiary_screen.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';



class AddBeneficiaryScreen extends StatefulWidget {

  final CustomerProfile customerProfile;
  final bool isNewUser;
  AddBeneficiaryScreen({this.customerProfile,this.isNewUser});
  @override
  _AddBeneficiaryScreenState createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends BaseState<AddBeneficiaryScreen> {

  TextEditingController txtCtrlBankName = TextEditingController();
  TextEditingController txtCtrlBankAcc = TextEditingController();
  TextEditingController txtCtrlTransType = TextEditingController();
  TextEditingController txtCtrlAccHolderName = TextEditingController();
  TransactionController controller = Get.find();
  BankDetailsBean selectedBank;

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey3,
      appBar: CustomAppBarWidget(title:getTranslation(Strings.ADD_NEW_BANK_ACCOUNT),addNewWidgetShow: false,),
      body: SafeArea(
          child: getPageContainer()));//.withProgressIndicator(showIndicator: controller.showProgress.value))));
  }
  @override
  BuildContext getContext() => context;

  getPageContainer(){
    return Form(
      key: _formKey,
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // getContactDetailsWidget(),
                SizedBox(height: 8,),
                getAccountDetailsWidget(),
                _getContinueWidget()
              ],
            ),
          ),
      ),
    );
  }
  var boxDecoration = BoxDecoration(
      boxShadow: [BoxShadow(
          color: AppColors.grey2,
          offset: Offset(0,1),
          blurRadius: 0,
          spreadRadius: 0
      )] ,
      color: AppColors.elevation_off_2_2_2
  );
  Widget getContactDetailsWidget(){
    return IntrinsicHeight(
      child: Container(
        decoration: boxDecoration,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
              "Contact Details",//TODO
              style: TextStyles.subtitle1222
          ),
          SizedBox(height: 18),
          Text(
              "Name",
              style: TextStyles.caption222
          ),
          SizedBox(height: 10),
          TextFormField(
            validator:MultiValidator([RequiredValidator(errorText: 'Please Enter Account Holder Name')]),
            decoration: InputDecoration(
                hintText: "Enter Name"
            ),
          ),
          SizedBox(height: 16),
          Text(
              "Phone Number",
              style: TextStyles.caption222
          ),
          SizedBox(height: 10),
          TextFormField(
            validator:MultiValidator([RequiredValidator(errorText: 'Please Enter Account Holder Name')]),
            decoration: InputDecoration(
                hintStyle: TextStyles.inputFieldOff222,
                hintText: "Enter Phone Number"
            ),
          ),
          SizedBox(height: 16),
        ],
      ).paddingAll(16),
      ),
    );
  }

  Widget getAccountDetailsWidget(){
    return Container(
        decoration: boxDecoration,
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                  "Transfer Details",//TODO
                  style: TextStyles.subtitle1222
              ),
              SizedBox(height: 18),
              Text(
                  "Bank and E-Money",
                  style: TextStyles.caption222
              ),
              SizedBox(height: 10),
              getListOfBanks(),
              SizedBox(height: 16),
              Text(
                  "Bank Account Number",
                  style: TextStyles.caption222
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: txtCtrlBankAcc,

                validator:MultiValidator([RequiredValidator(errorText: 'Please Enter Account Number'),LengthRangeValidator(min:10,max:16,errorText: 'Please enter a valid account number')]),
                decoration: InputDecoration(
                    border: Borders.textInputBorder,
                    disabledBorder: Borders.textInputBorder,
                    errorBorder:Borders.errorTextInputBorder,
                    focusedBorder: Borders.textInputBorder,
                    enabledBorder: Borders.textInputBorder,
                    hintText: "Enter Account Number"
                ),
              ),
              SizedBox(height: 16),
              Text(
                  "Account Holder Name",
                  style: TextStyles.caption222
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: txtCtrlAccHolderName,
                validator:MultiValidator([RequiredValidator(errorText: 'Please Enter Account Holder Name')]),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: Borders.textInputBorder,
                    disabledBorder: Borders.textInputBorder,
                    errorBorder:Borders.errorTextInputBorder,
                    focusedBorder: Borders.textInputBorder,
                    enabledBorder: Borders.textInputBorder,
                    hintText: "Enter Account Holder Name"
                ),
              ),
              SizedBox(height: 16),
            ],
          ).paddingAll(16),
        ),
      );

  }


  getListOfBanks() {
    return FutureBuilder<List<BankDetailsBean>>(
        future: Get.find<TransactionController>().getBanksList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var arrBankInfo = snapshot.data;
              return  DropdownButtonFormField<BankDetailsBean>(
                  // validator: MultiValidator([RequiredValidator(errorText: 'Please Select the Bank Account')]),
                  decoration: InputDecoration(fillColor: Color(0xffffffff)),
                  items: arrBankInfo.map((e){
                    return DropdownMenuItem<BankDetailsBean>(value:e,child: Text(e.name),);}).toList(),
                  // value: formController.addDistrict.value,
                  onChanged: (BankDetailsBean bank){
                    FocusScope.of(context).requestFocus(FocusNode());
                    selectedBank = bank;
                  }).paddingOnly(bottom:24);
            }
          }
          return const Center(child: BaseWidgets.getIndicator);
        }
    );



  }
  _getContinueWidget() {
    return
      Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 24, left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.bottom_border_color),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.CONTINUE),
          textAlign: TextAlign.center,
          style: BaseStyles.addNewBankAccount,
        ),
      ).onTap(onPressed: () async{
        if (_formKey.currentState.validate()) {
         await controller.addBeneficiary(
              mobile: widget.customerProfile.mobileNumber,
              accountNo: txtCtrlBankAcc.text,
              bic: selectedBank.bic,
              name: txtCtrlAccHolderName.text,isNewUser:widget.isNewUser);
              Get.back();

        }
      });
    // );
  }
}


