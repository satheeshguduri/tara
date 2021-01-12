import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';

class EnterCardDetailsController extends GetxController{

  bool isValidateCardNumber = false;
  bool isValidateMM = false;
  bool isValidateYY = false;
  bool isValidateCVV = false;
  bool isValidateName = false;

  var isCompleteValidate = false.obs;

  TextEditingController txtCtrlBankAcc = TextEditingController();
  TextEditingController txtCtrlExpMonth = TextEditingController();
  TextEditingController txtCtrlExpYear = TextEditingController();
  TextEditingController txtCtrlCvv = TextEditingController();
  TextEditingController txtCtrlNameOnCard = TextEditingController();

  var btnColor = AppColors.billerPaymentNextButtonColor.obs;
  var textStyle = TextStyles.bUTTONGrey3222.obs;


  void validateCardDetails(String hint,String value ){

    switch(hint){
      case "Ex : 1234 5678 9012 3456":{
          if(value.length>0 && value.length>16){
            isValidateCardNumber = true;
            }else{
            isValidateCardNumber = false;

            }
      }
      break;

      case "mm":{
        if (value.length>0 && int.parse(value) > 0 && int.parse(value) < 13) {
          isValidateMM = true;
        } else {
          isValidateMM = false;
            }
        }
      break;

      case "yy": {
        if (value.length>0 && int.parse(value) > 16 && int.parse(value) < 26) {
          isValidateYY = true;
        } else {
          isValidateYY = false;

        }
      }
      break;
      case "CVV": {
        if (value.length>0&&int.parse(value) > 99 && int.parse(value) < 999) {
          isValidateCVV = true;
        } else {
          isValidateCVV = false;

        }
      }
      break;
      case "Name On Card": {
        if (value.length > 0 ) {
          isValidateName = true;
        } else {
          isValidateName = false;
        }
      }
      break;

    }

      checkForValidation();

  }

  void checkForValidation() {
     {
      if(isValidateCardNumber&&isValidateMM&&isValidateYY&&isValidateCVV&&isValidateName){
        isCompleteValidate.value = true;
      }else{
        isCompleteValidate.value = false;
      }
    }
  }

  void showIfTrue() {
    btnColor.value = AppColors.bottom_border_color;
    textStyle.value = BaseStyles.addNewBankAccount;
  }

  void showIfFalse() {
    btnColor.value =  AppColors.billerPaymentNextButtonColor;
    textStyle.value = TextStyles.bUTTONGrey3222;
  }


}

