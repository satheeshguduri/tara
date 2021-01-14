/*
*  transaction_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/device_info.dart';
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/agent/transaction_history.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/my_account/otp_verification_screen.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import 'auth_controller.dart';

class TransactionController extends GetxController{
  var showProgress = false.obs;
  var userMobileNumber;
 // =  Get.find<AuthController>().user.value.customerProfile.mobileNumber;
  var otp = "".obs;

 // var user = AuthResponse().obs;
  var errorMessage = "".obs;
  var countDownTimeString = "02:00".obs;


  Timer timer;
  var seconds=120.obs;

  TextEditingController txtCtrlTransferAmt = TextEditingController();




  void sendMoney(CustomerProfile to,CustomerProfile from,double amount,[pop]) async{

    var fromData = FromDataBean(fromContactNumber: from.mobileNumber,fromUserFirebaseId: from.firebaseId);
    var toData = ToDataBean(toContactNumber: to.mobileNumber,toUserFirebaseId: to.firebaseId);
    var optionalDataBean = OptionalDataBean(data: DataBean(transactionContext: "Payment_Request",amount: amount));
    var transactionModel=  TransactionModel(optionalData: optionalDataBean,
      fromData: fromData,
      toData: toData,
      paid: false,transactionType: "paid",
      subType: "Grocery",
      status: "INITIATED",
      transactionDate: DateTime.now().toIso8601String(),);
    showProgress.value = true;
    Either<Failure, BaseResponse> responseDa = await getIt.get<TransactionRepository>().sendMoney(transactionModel);
    showProgress.value = false;
    responseDa.fold(
          (l) => print(l.message),
          (r) => {
           // pop,
          Get.to(ConversationPage(showMakeAnOrder:false,arrChats: ["chat_money_transfer_success"],custInfo: Utils().getCustomerProfile())) //YAKUB Dummy Profile
          }
    );


  }

  void getOtpForTransfer({bool isFromResendOtp = false}) async {
    //validate empty state here for the text fields

    showProgress.value = true;
    userMobileNumber = Get.find<AuthController>().user.value.customerProfile.mobileNumber;
    AuthRequest request = AuthRequest(mobileNumber: userMobileNumber);
    print(request.toJson());
    Either<Failure, BaseResponse> response = await getIt
        .get<AuthRepository>()
        .getOtp(AuthRequestWithData(data: request));
    showProgress.value = false;
    response.fold(
          (l) => print(l.message),
          (r) => !isFromResendOtp
          ? Get.to(OTPVerificationScreen())
          : print(r.message),
    );

  }

  void validateOtpForTransfer() async {
    //validate empty state here for the text fields
    if (isValidationSuccessInOtp()) {
      showProgress.value = true;
      userMobileNumber = Get.find<AuthController>().user.value.customerProfile.mobileNumber;
      AuthRequest request = AuthRequest(mobileNumber: userMobileNumber, otp: otp.value);
      Either<Failure, BaseResponse> response = await getIt
          .get<AuthRepository>()
          .validateOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold(
              (l)
                => Get.defaultDialog(content: Text(l.message)),
              (r) {
                CustomerProfile fromUser = Get.find<AuthController>().user.value.customerProfile;
                sendMoney(Utils().getCustomerProfile(), fromUser, double.tryParse(txtCtrlTransferAmt.text)??0.0);

          }
      );
    }
  }

  bool isValidationSuccessInOtp() {
    if (GetUtils.isNullOrBlank(otp.value)) {
      errorMessage.value = Strings.enter_otp_code;
      return false;
    }else if (otp.value.length<6) {
      errorMessage.value = Strings.invalid_otp;
      return false;
    } else{
      errorMessage.value = "";
    }
    return true;
  }
  void  startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    timer = Timer.periodic(period, (timer) {
      // Update interface
      if (seconds.value == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      }
      else
      {
        seconds.value = seconds.value - 1;
        constructTime(seconds.value);
      }
    });
  }

  Future getCustomerProfile2() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var commonRequest = await BaseRequestHelper()
          .getCommonRegistrationRequest();

      var resp = await getIt.get<AuthRepository>().getCustomerProfile(commonRequest);
      return resp.getOrElse(() => null);
    }
  }

  Future getBanksList() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
      var bankListR = await getIt.get<TransactionRepository>().getBanksList(commonRequest);
      if(bankListR.isRight()){
        var response = bankListR.getOrElse(() => null);
        return response;
      }
    }
  }

  Future addBankAccount(String bicValue, String last6Digits,String name, String cardNumber,String cvvData, String expM,String expY,String accountNum) async {
    showProgress.value = true;
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
    if(isSessionInitiated){
      var bic = bicValue;//"CENAID00001";
      var accountDetailsRequest = AccountDetailsRequest(custPSPId: commonRequest.custPSPId,
          accessToken: commonRequest.accessToken,
          bic: bic,
          // transactionId: commonRequest.transactionId,
          requestedLocale: commonRequest.requestedLocale,
          cardLast6Digits: last6Digits,//"012345",
          acquiringSource: commonRequest.acquiringSource);
      print(jsonEncode(accountDetailsRequest.toJson()));
      var accInitResp = await getIt.get<TransactionRepository>().initiateAccountDetailsRequest(accountDetailsRequest);
      var startTime = DateTime.now().microsecondsSinceEpoch;
      if(accInitResp.isRight()){
        var accInitiateResponse = accInitResp.getOrElse(() => null);
        var txnId = accInitiateResponse.transactionId;
        if(accInitiateResponse.success){
          var userInfo = Get.find<AuthController>().user.value.customerProfile;
          var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP(mobileNumber:userInfo?.mobileNumber??"");
          var retrieveKeyRequest = RetrieveKeyRequest(
              deviceInfo: deviceInfo,
              paymentInstrument: PaymentInstrumentBean(
                  paymentInstrumentType: "ACCOUNT",
                  bic:bic
              ),
              resetCredentialCall: false,
              startDateTime: startTime
          );
          print(jsonEncode(retrieveKeyRequest.toJson()));
          var respo = await getIt.get<TransactionRepository>().retrieveKey(retrieveKeyRequest,TransactionType.REGISTER_CARD_ACC_DETAIL,accInitiateResponse.transactionId);
          if(respo.isRight()){
            var retriveKeyResponse = respo.getOrElse(() => null);
            print(jsonEncode(retriveKeyResponse.toJson()));
            var fullName = await CryptoHelper().encryptBankData("$txnId|$name|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
            //Card Number  == 16 digit Number
            var number = await CryptoHelper().encryptBankData("$txnId|$cardNumber|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
            //CVV == 123
            var cvv = await CryptoHelper().encryptBankData("$txnId|$cvvData|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
            //exp Month == 02
            var expMM = await CryptoHelper().encryptBankData("$txnId|$expM|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
            //exp Year == 25
            var expYY = await CryptoHelper().encryptBankData("$txnId|$expY|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
            //1010101010101010 ==> Account Number
            var accountNumber = await CryptoHelper().encryptBankData("$txnId|$accountNum|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
            var registerRequest = RegisterCardRequest(
                card: CardBean(
                    cvv: cvv,
                    number: number,
                    expiryMonth: expMM,
                    expiryYear: expYY,
                    fullName: fullName
                ),
                bic: bic,
                startDateTime: startTime,
                deviceInfo: deviceInfo,
                accountInfo: AccountInfoBean(
                  bic: bic,
                  accountNo: accountNumber,
                )
            );
            print(jsonEncode(registerRequest.toJson()));
            var resp = await getIt.get<TransactionRepository>().registerCardDetail(registerRequest,retriveKeyResponse.sessionKey,txnId,retriveKeyResponse.publicKey);
            if(resp.isRight()){
              var registerCardResponse = resp.getOrElse(() => null);
              print(jsonEncode(registerCardResponse.toJson()));
              var confirmAccountRegistrationRequest= ConfirmAccountRegistrationRequest(
                  bic: bic,
                  accepted: true,
                  deviceInfo: deviceInfo
              );
              print(jsonEncode(confirmAccountRegistrationRequest.toJson()));
              var confirmResp = await getIt.get<TransactionRepository>().confirmAccountRegistration(confirmAccountRegistrationRequest,retriveKeyResponse.sessionKey,txnId);
              if(confirmResp.isRight()){
                var res = confirmResp.getOrElse(() => null);
                if(res.commonResponse.success){
                  var fetchOtpRequest = FetchOtpRequest(
                    deviceInfo: deviceInfo,
                    paymentInstrument: PaymentInstrumentBean(
                        bic: bic,
                        paymentInstrumentType: "ACCOUNT"
                    ),
                    action: ActionType.CARD_REGISTRATION,
                  );
                  print(jsonEncode(fetchOtpRequest.toJson()));
                  Timer(Duration(seconds: 2), ()async{
                    var fetchOTPR = await getIt.get<TransactionRepository>()
                        .fetchOtp(fetchOtpRequest,
                        TransactionType.REGISTER_CARD_ACC_DETAIL,
                        retriveKeyResponse.sessionKey, txnId);
                    if (fetchOTPR.isRight()) {
                      var fetchOTPResponse = fetchOTPR.getOrElse(() => null);
                      print(jsonEncode(fetchOTPResponse.toJson()));
                      showProgress.value = false;
                       Get.to(OTPVerificationScreen(txnId: txnId,fetchOtpResponse: fetchOTPResponse,retrieveKeyResponse: retriveKeyResponse,deviceInfoBean: deviceInfo,bic: bic,));

                      //  Get.to(OTPVerificationScreen(txnId,fetchOTPResponse,retriveKeyResponse,deviceInfo,bic));
                      // call in OTP validation Screen
                      //await validateOtpAndTrack(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                    }
                  });
                }
              }
            }
          }

        }
      }
    }
  }

  Future validateOtpAndTrack(String txnId, FetchOtpResponse fetchOTPResponse, RetrieveKeyResponse d, DeviceInfoBean deviceInfo, String bic) async {
    showProgress.value = true;
    var encValid = await CryptoHelper().encryptBankData("$txnId|${fetchOTPResponse.otpChallengeCode}|${Random.secure()}",d.bankKi,d.publicKey);
    var validateOtpRequest = ValidateOtpRequest(
        deviceInfo: deviceInfo,
        bic:bic,
        action: ActionType.CARD_REGISTRATION,
        referenceId: fetchOTPResponse.referenceId,
        otp: encValid
    );
    print(jsonEncode(validateOtpRequest.toJson()));
    var validateOTPR = await getIt.get<TransactionRepository>().validateOtp(validateOtpRequest,TransactionType.REGISTER_CARD_ACC_DETAIL,d.sessionKey,txnId);
    if(validateOTPR.isRight()){
      var validateOTPResponse = validateOTPR.getOrElse(() => null);
      print(jsonEncode(validateOTPResponse.toJson()));
      var req = await BaseRequestHelper().getCommonRegistrationRequest();
      req.transactionId = txnId;
      print(jsonEncode(req.toJson()));
      var trackAccountR = await getIt.get<TransactionRepository>().trackAccountDetailsRequest(req,TransactionType.REGISTER_CARD_ACC_DETAIL,d.sessionKey,txnId);
      if(trackAccountR.isRight()){
        var trackAccountResponse = trackAccountR.getOrElse(() => null);
        showProgress.value = false;
        print(jsonEncode(trackAccountResponse.toJson()));
        Get.offAll(Utils().getLandingScreen());
      }
    }
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

}