/*
*  auth_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/helpers/helpers.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/account_confirmation.dart';
import 'package:tara_app/controller/device_register_controller.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/flavors.dart';
import 'package:tara_app/models/auth/auth_put_request.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/registration_status.dart';
import 'package:tara_app/models/auth/to_address_response.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/Merchant/create_store_screen.dart';
import 'package:tara_app/screens/complete_profile_details.dart';
import 'package:tara_app/screens/mobile_verification_screen.dart';
import 'package:tara_app/screens/password_reset_success.dart';
import 'package:tara_app/screens/reset_password_screen.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import '../models/auth/auth_request.dart';
import '../models/auth/auth_request.dart';
import '../models/auth/auth_request.dart';
import '../models/auth/auth_request.dart';
import '../models/auth/security_token.dart';

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
  var countDownTimeString = "02:00".obs;
  var user = AuthResponse().obs;

  Timer timer;
  var seconds = 120.obs;

  TextEditingController mobileNumberTextEditController =
      TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController otpTextEditController = TextEditingController();
  TextEditingController nameTextEditController = TextEditingController();
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController confirmPasswordTextEditController =
      TextEditingController();

  ///on clicking on send otp
  void getOtp({
    bool isFromResendOtp = false,
    bool isFromForgotPassword = false,
  }) async {
    //validate empty state here for the text fields
    if (isValidationSuccessInSignUp()) {
      showProgress.value = true;
      AuthRequest request = AuthRequest(mobileNumber: mobileNumber.value);
      print(request.toJson());
      Either<Failure, BaseResponse> response = await getIt
          .get<AuthRepository>()
          .getOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold(
        (l) => print(l.message),
        (r) => isFromForgotPassword
            ? Get.to(MobileVerificationScreen(
                isFromFogotPassword: true,
              ))
            : !isFromResendOtp
                ? Get.to(MobileVerificationScreen())
                : print(r.message),
      );
    } else {
      //handle empty state error here
    }
  }

  ///on tapping the verify
  void validateOtp({bool isFromForgotPassword = false}) async {
    //validate empty state here for the text fields
    if (isValidationSuccessInOtp()) {
      showProgress.value = true;
      AuthRequest request =
          AuthRequest(mobileNumber: mobileNumber.value, otp: otp.value);
      Either<Failure, BaseResponse> response = await getIt
          .get<AuthRepository>()
          .validateOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold(
          (l) => Get.defaultDialog(content: Text(l.message)),
          (r) => Get.to(isFromForgotPassword
              ? ResetPasswordScreen()
              : CompleteProfileScreen()));
    }
  }

  Future<AuthResponse> createTempAccount(
      RegistrationStatus status, String mobileNumber) async {
    CustomerProfile customerProfile = CustomerProfile(
        customerType: Utils().getCustomerType(), registrationStatus: status);
    SignUpRequest request = SignUpRequest(
      customerProfile: customerProfile,
      mobileNumber: mobileNumber,
    );
    print(request.toJson());
    Either<Failure, AuthResponse> response =
        await getIt.get<AuthRepository>().signUp(request);
    if (response.isRight()) {
      var signUpResponse = response.getOrElse(() => null);
      print(jsonEncode(signUpResponse.toJson()));
      return signUpResponse;
    } else {
      print("error while creating the user");
    }
    return Future.value(null);
  }

  void login() async {
    //validate empty state here for the text fields
    if (isValidationSuccessInSignIn()) {
      showProgress.value = true;
      var customerProfile =
          CustomerProfile(customerType: Utils().getCustomerType());
      print(customerProfile.toJson().toString());
      AuthRequest request = AuthRequest(
          mobileNumber: mobileNumber.value,
          password: confirmPwd.value,
          customerProfile: customerProfile);
      print(jsonEncode(request.toJson()));
      Either<Failure, AuthResponse> response =
          await getIt.get<AuthRepository>().login(request);
      showProgress.value = false;
      print("Login response ${response}");
      response.fold(
          (l) => GetHelper().getDialog(
                  content: ErrorStateInfoWidget(
                desc: l.message,
              )),
          (r) async => {
                if (await getIt
                        .get<SessionLocalDataStore>()
                        .getDeviceRegInfo() !=
                    null)
                  {
                    showProgress.value = false,
                    Get.offAll(Utils().getLandingScreen()),
                  }
                else
                  {
                    await DeviceRegisterController().registerDevice(),
                    Get.offAll(Utils().getLandingScreen()),
                  }
              });
      // Get.to(Consumer())); //navigate to consumer home screen
    }
  }

  void resetPassword() async {
    //validate empty state here for the text fields
    if (isValidatedPassword()) {
      showProgress.value = true;
      AuthPutRequest request = AuthPutRequest(
          mobileNumber.value,
          passwordTextEditController.text.trim(),
          true,
          Utils().getCustomerType());
      Either<Failure, SecurityToken> response =
          await getIt.get<AuthRepository>().resetPassword(request);
      showProgress.value = false;
      response.fold(
        (l) => GetHelper().getDialog(
          content: ErrorStateInfoWidget(
            desc: l.message,
          ),
        ),
        (r) async => {
          Get.dialog(
              Dialog(
                child: PasswordResetSuccess(),
                insetPadding: EdgeInsets.symmetric(horizontal: Get.width * .06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              barrierDismissible: true),
        },
      );
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
      response.fold(
          (l) => getIt.get<GetHelper>().getDialog(
                  content: ErrorStateInfoWidget(
                desc: l.message,
              )),
          //Get.defaultDialog(content: Text(l.message)),
          (r) async => {
                Get.put<AuthResponse>(r),
                if (F.appFlavor == Flavor.MERCHANT)
                  {Get.to(CreateStoreScreen())}
                else
                  {Get.to(AccountConfirmationScreen())},
              });
      // Get.to(Consumer())); //navigate to consumer home screen
    }
  }

  //updating profile info
  void updateProfile(
      String name, String address, String email, AuthResponse user) async {
    showProgress.value = true;
    CustomerProfile customerProfile = CustomerProfile(
        id: user.customerProfile.id,
        lastName: user.customerProfile.lastName,
        mobileNumber: user.customerProfile.mobileNumber,
        country: user.customerProfile.country,
        dateOfBirth: user.customerProfile.dateOfBirth,
        isKyc: user.customerProfile.isKyc,
        customerType: user.customerProfile.customerType,
        firebaseId: user.customerProfile.firebaseId,
        firstName: name,
        // address: "address",
        email: email);
    Either<Failure, BaseResponse> response =
        await getIt.get<AuthRepository>().updateProfile(customerProfile);
    showProgress.value = false;
    response.fold(
        (l) => Get.defaultDialog(content: Text(l.message)),
        (r) => {
              Get.defaultDialog(content: Text(r.message)),
            });
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
    } else {
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
    } else {
      isEnterAllTheFields.value = false;
    }
  }

  bool isValidationSuccessInSignIn() {
    if (GetUtils.isNullOrBlank(mobileNumber.value)) {
      errorMessage.value = Strings.enter_phone_number;
      return false;
    } /*else if (Validator().validateMobile(mobileNumber.value) != null) {
      errorMessage.value = Strings.invalid_number;
      return false;
    } */
    else if (GetUtils.isNullOrBlank(confirmPwd.value)) {
      errorMessage.value = Strings.enter_password;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }

  bool isValidatedPassword() {
    if (GetUtils.isNullOrBlank(passwordTextEditController.text.trim()) ||
        GetUtils.isNullOrBlank(confirmPasswordTextEditController.text.trim())) {
      errorMessage.value = Strings.enter_password;
      return false;
    } else if (passwordTextEditController.text.trim() !=
        confirmPasswordTextEditController.text.trim()) {
      errorMessage.value = Strings.password_not_match;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }

  bool isValidationSuccessInSignUp() {
    if (GetUtils.isNullOrBlank(mobileNumber.value)) {
      errorMessage.value = Strings.enter_phone_number;
      return false;
    } /*else if (Validator().validateMobile(mobileNumber.value) != null) {
      errorMessage.value = Strings.invalid_number;
      return false;
    } */
    else {
      errorMessage.value = "";
    }
    return true;
  }

  bool isValidationSuccessInOtp() {
    if (GetUtils.isNullOrBlank(otp.value)) {
      errorMessage.value = Strings.enter_otp_code;
      return false;
    } else if (otp.value.length < 6) {
      errorMessage.value = Strings.invalid_otp;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }

  Future<Either<Failure, ToAddressResponse>> getToAddressForPayment(
      String mobileNUmber) async {
    return await getIt.get<AuthRepository>().getToAddress(mobileNUmber);
  }

  Future<Either<Failure, CustomerProfile>> getNonTaraCustomerInfo(
      String mobileNUmber) async {
    return await getIt
        .get<AuthRepository>()
        .getNonTaraCustomerInfo(mobileNUmber);
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    timer = Timer.periodic(period, (timer) {
      // Update interface
      if (seconds.value == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      } else {
        seconds.value = seconds.value - 1;
        constructTime(seconds.value);
      }
    });
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  String constructTime(int seconds) {
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    countDownTimeString.value = formatTime(minute) + ":" + formatTime(second);
    return countDownTimeString.value;
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  registerDevice() {}
}
