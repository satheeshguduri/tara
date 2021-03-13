import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/controller/transaction_controller.dart';

class EnterCardDetailsController extends GetxController {
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

  void validateCardDetails(String hint, String value) {
    switch (hint) {
      case Strings.card_number_ex:
        {
          if (value.length > 0 && value.length >= 15) {
            isValidateCardNumber = true;
          } else {
            isValidateCardNumber = false;
          }
        }
        break;

      case Strings.mm:
        {
          if (value.length > 0 &&
              int.parse(value) > 0 &&
              int.parse(value) < 13) {
            isValidateMM = true;
          } else {
            isValidateMM = false;
          }
        }
        break;

      case Strings.yy:
        {
          if (value.length > 0 &&
              int.parse(value) > 16 &&
              int.parse(value) < 28) {
            isValidateYY = true;
          } else {
            isValidateYY = false;
          }
        }
        break;
      case Strings.cvv:
        {
          if (value.length > 0 &&
              int.parse(value) > 99 &&
              int.parse(value) < 999) {
            isValidateCVV = true;
          } else {
            isValidateCVV = false;
          }
        }
        break;
      case Strings.name_on_card:
        {
          if (value.length > 0) {
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
      if (isValidateCardNumber &&
          isValidateMM &&
          isValidateYY &&
          isValidateCVV &&
          isValidateName) {
        isCompleteValidate.value = true;
      } else {
        isCompleteValidate.value = false;
      }
    }
  }

  void showIfTrue() {
    btnColor.value = AppColors.bottom_border_color;
    textStyle.value = BaseStyles.addNewBankAccount;
  }

  void showIfFalse() {
    btnColor.value = AppColors.billerPaymentNextButtonColor;
    textStyle.value = TextStyles.bUTTONGrey3222;
  }

  void addNewCard(
      String bicValue,
      String last6Digits,
      String name,
      String cardNumber,
      String cvvData,
      String expM,
      String expY,
      String accountNum) async {
    await Get.find<TransactionController>().addBankAccount(bicValue,
        last6Digits, name, cardNumber, cvvData, expM, expY, accountNum);
  }
}
