/*
*  auth_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/mobile_verification.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/complete_profile_details.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/services/error/failure.dart';

import '../injector.dart';

class AuthController extends GetxController {
  ///listen for the progress bar changes
  var showProgress = false.obs;
  var mobileNumber = "".obs;
  var otp = "".obs;
  var confirmPwd = "".obs;

  TextEditingController mobileNumberTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController otpTextEditController = TextEditingController();
  TextEditingController nameTextEditController = TextEditingController();
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController confirmPasswordTextEditController = TextEditingController();

  ///on clicking on send otp
  void getOtp() async{
    //validate empty state here for the text fields
    if(mobileNumber.value.isNotEmpty){
      showProgress.value = true;
      AuthRequest request = AuthRequest(mobileNumber: mobileNumber.value);
      print(request.toJson());
      Either<Failure, BaseResponse> response = await getIt.get<AuthRepository>().getOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold(
              (l) =>
                  print(l.message),
              (r) =>
                  Get.to(CompleteProfile()));
    }else{
      //handle empty state error here
    }

  }
  ///on tapping the verify
  void validateOtp() async{
    //validate empty state here for the text fields
    if(otpTextEditController.text.isNotEmpty){
      showProgress.value = true;
      AuthRequest request = AuthRequest(mobileNumber: mobileNumber.value,otp: otp.value);
      Either<Failure, BaseResponse> response = await getIt.get<AuthRepository>().validateOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold(
              (l) =>
              Get.defaultDialog(content: Text(l.message)),
              (r) =>
              Get.to(MobileVerification()));
    }
  }

  void login() async{
    //validate empty state here for the text fields
    if(mobileNumber.value.isNotEmpty&&confirmPwd.value.isNotEmpty){
      showProgress.value = true;
      AuthRequest request = AuthRequest(mobileNumber: mobileNumber.value,password: confirmPwd.value);
      Either<Failure, AuthResponse> response = await getIt.get<AuthRepository>().login(request);
      showProgress.value = false;
      response.fold(
              (l) =>
              Get.defaultDialog(content: Text(l.message)),
              (r) => Get.to(HomeCustomerScreen()));
             // Get.to(Consumer())); //navigate to consumer home screen
    }
  }
  void signUp() async{
    //validate empty state here for the text fields
    if(mobileNumberTextEditController.text.isNotEmpty){
      showProgress.value = true;
      CustomerProfile customerProfile = CustomerProfile(mobileNumber: mobileNumberTextEditController.text);
      SignUpRequest request = SignUpRequest(data: customerProfile,);
      Either<Failure, AuthResponse> response = await getIt.get<AuthRepository>().signUp(request);
      showProgress.value = false;
      response.fold(
              (l) =>
              Get.defaultDialog(content: Text(l.message)),
              (r) => print("Navigate to consumer home screen"));
      // Get.to(Consumer())); //navigate to consumer home screen
    }
  }
}