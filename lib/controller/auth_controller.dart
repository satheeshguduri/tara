/*
*  auth_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/helpers.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/account_confirmation.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/mobile_verification.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/complete_profile_details.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';

class AuthController extends GetxController {
  ///listen for the progress bar changes
  var showProgress = false.obs;
  var mobileNumber = "".obs;
  var otp = "".obs;
  var confirmPwd = "".obs;
  var fullName = "".obs;
  var email = "".obs;
  var password = "".obs;
  var isEnterAllTheFields = false.obs;
  var errorMessage = "".obs;

  TextEditingController mobileNumberTextEditController =
      TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController otpTextEditController = TextEditingController();
  TextEditingController nameTextEditController = TextEditingController();
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController confirmPasswordTextEditController =
      TextEditingController();

  ///on clicking on send otp
  void getOtp({bool isFromResendOtp = false}) async {
    //validate empty state here for the text fields
    if (mobileNumber.value.isNotEmpty) {
      showProgress.value = true;
      AuthRequest request = AuthRequest(mobileNumber: mobileNumber.value);
      print(request.toJson());
      Either<Failure, BaseResponse> response = await getIt
          .get<AuthRepository>()
          .getOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold(
        (l) => print(l.message),
        (r) => !isFromResendOtp
            ? Get.to(MobileVerificationScreen())
            : print(r.message),
      );
    } else {
      //handle empty state error here
    }
  }

  ///on tapping the verify
  void validateOtp() async {
    //validate empty state here for the text fields
    if (otp.value.isNotEmpty) {
      showProgress.value = true;
      AuthRequest request =
          AuthRequest(mobileNumber: mobileNumber.value, otp: otp.value);
      Either<Failure, BaseResponse> response = await getIt
          .get<AuthRepository>()
          .validateOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold((l) => Get.defaultDialog(content: Text(l.message)),
          (r) => Get.to(CompleteProfileScreen()));
    }
  }

  void login() async {
    //validate empty state here for the text fields
    if (mobileNumber.value.isNotEmpty && confirmPwd.value.isNotEmpty) {
      showProgress.value = true;
      AuthRequest request = AuthRequest(
          mobileNumber: mobileNumber.value, password: confirmPwd.value);
      Either<Failure, AuthResponse> response =
          await getIt.get<AuthRepository>().login(request);
      showProgress.value = false;
      response.fold((l) => Get.defaultDialog(content: Text(l.message)),
          (r) => Get.to(HomeCustomerScreen()));
      // Get.to(Consumer())); //navigate to consumer home screen
    }
  }

  void signUp() async {
    //validate empty state here for the text fields
    if (isValidationSuccessInCompleteProfile()) {
      showProgress.value = true;
      CustomerProfile customerProfile = CustomerProfile(
          firstName: fullName.value,
          email: email.value,
          customerType: Utils().getCustomerType());
      SignUpRequest request = SignUpRequest(
          customerProfile: customerProfile,
          mobileNumber: mobileNumber.value,
          password: password.value);
      print(request.toJson());
      Either<Failure, AuthResponse> response =
          await getIt.get<AuthRepository>().signUp(request);
      showProgress.value = false;
      response.fold((l) => Get.defaultDialog(content: Text(l.message)),
          (r) => Get.to(AccountConfirmationScreen()));
      // Get.to(Consumer())); //navigate to consumer home screen
    }
  }

  bool isValidationSuccessInCompleteProfile() {
    if (GetUtils.isNullOrBlank(fullName.value)) {
      errorMessage.value = Strings.enter_full_name;
      return false;
    } else if (GetUtils.isNullOrBlank(email.value)) {
      errorMessage.value = Strings.enter_email_address;
      return false;
    } else if (Validator().email(email.value) != null) {
      errorMessage.value = Strings.invalid_email;
      return false;
    } else if (GetUtils.isNullOrBlank(password.value)) {
      errorMessage.value = Strings.enter_password;
      return false;
    } else if (GetUtils.isNullOrBlank(confirmPwd.value)) {
      errorMessage.value = Strings.enter_confirm_password;
      return false;
    } else if (password.value != confirmPwd.value) {
      errorMessage.value = Strings.password_not_match;
      return false;
    }else{
      errorMessage.value = "";
    }
    return true;
  }


  void isEnterAllTheFieldsInCompleteProfile() {
    if (!GetUtils.isNullOrBlank(fullName.value) &&
        !GetUtils.isNullOrBlank(email.value) &&
        !GetUtils.isNullOrBlank(password.value) &&
        !GetUtils.isNullOrBlank(confirmPwd.value)) {
      isEnterAllTheFields.value = true;
    }else{
      isEnterAllTheFields.value = false;
    }
  }
}
