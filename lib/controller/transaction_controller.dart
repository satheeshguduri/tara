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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/registration_status.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_request.dart';
import 'package:tara_app/models/transfer/authorize_request.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/device_info.dart';
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/transaction_response.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/mc_payment_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/agent/transaction_history.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/my_account/otp_verification_screen.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:tara_app/models/mcpayment/create_card_or_pay_request.dart' as cards;
import 'package:tara_app/screens/consumer/common_webview.dart';
import 'package:tara_app/models/mcpayment/pay_card_request.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/transactions/payment_response.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/models/auth/to_address_response.dart';




import '../injector.dart';
import '../tara_app.dart';

enum TransactionContext {PAYMENT_REQUEST,BILL_PAYMENT}


class TransactionController extends GetxController{
  var showProgress = false.obs;
  var userMobileNumber ="".obs;
  var otp = "".obs;

  // var user = AuthResponse().obs;
  var errorMessage = "".obs;
  var countDownTimeString = "02:00".obs;


  Timer timer;
  var seconds=120.obs;

  var opacityValue = 0.0.obs;

  TextEditingController txtCtrlTransferAmt = TextEditingController();
  double payAmount;
  String payTransId;
  ToAddressResponse toAddress;




  void sendMoney(CustomerProfile to,CustomerProfile from,double amount,[pop]) async{

    var fromData = FromDataBean(fromContactNumber: from.mobileNumber,fromUserFirebaseId: from.firebaseId);
    var toData = ToDataBean(toContactNumber: to.mobileNumber,toUserFirebaseId: to.firebaseId);
    var optionalDataBean = OptionalDataBean(data: DataBean(transactionContext: "Payment_Request",amount: amount));
    var transactionModel=  TransactionModel(optionalData: optionalDataBean,
      fromData: fromData,
      toData: toData,
      paid: false,
      transactionType: "paid",
      subType: "Grocery",
      status: "INITIATED",
      transactionDate: DateTime.now().toIso8601String(),);
    showProgress.value = true;
    Either<Failure, PaymentResponse> responseDa = await getIt.get<TransactionRepository>().initiateTaraTransaction(transactionModel);
    showProgress.value = false;
    responseDa.fold(
            (l) => print(l.message),
            (r) => {
          // pop,
          Get.to(ConversationPage(showMakeAnOrder:false,arrChats: ["chat_money_transfer_success"],custInfo: Utils().getCustomerProfile())) //YAKUB Dummy Profile
        }
    );


  }

  //payment initiation
  Future paymentInitiation({TransactionContext trContext,String cardId,double amount,String desc,String maskAcNum,ToAddressResponse toAddress,bool isFromCreditCard=false,}) async{
    print("firebaseid "+ Get.find<AuthController>().user.value.customerProfile.firebaseId);
    // print("to firebaseid "+ toAddress.customerProfile.firebaseId);
    payAmount=amount;
    var fromData = FromDataBean(fromContactNumber:Get.find<AuthController>().user.value.customerProfile.mobileNumber,fromAccount: null,fromUserFirebaseId: Get.find<AuthController>().user.value.customerProfile.firebaseId);
    var toData = ToDataBean(toContactNumber: toAddress.mobileNumber,toAccount:null,toUserFirebaseId: toAddress.customerProfile.firebaseId);
    var optionalDataBean = OptionalDataBean(data: DataBean(amount: amount,transactionContext: isFromCreditCard?TransactionContext.BILL_PAYMENT.toString():null));
    var transactionModel=  TransactionModel(optionalData: optionalDataBean,
      fromData: fromData,
      toData: toData,
      paid: false,
      transactionType: "paid",
      subType: "Grocery",
      status: "INITIATED",
      transactionDate: DateTime.now().toIso8601String(),
      toType: null);
      jsonEncode(transactionModel.toJson());
    showProgress.value = true;
    Either<Failure, PaymentResponse> responseDa = await getIt.get<TransactionRepository>().initiateTaraTransaction(transactionModel);
   // showProgress.value = false;
    print("@@@@@@@");

    responseDa.fold(
            (l) => print(l.message),
            (r) => {
              payTransId = r.transactionId,
              if(isFromCreditCard){
                payViaCreditCard(cardId, amount, desc, maskAcNum)
              }

         }
    );


  }
  // payment done
  Future<Either<Failure, BaseResponse>> paymentCompleted({TransactionContext trContext,ToAddressResponse toAddress}) async{
    var fromData = FromDataBean(fromContactNumber:Get.find<AuthController>().user.value.customerProfile.mobileNumber,fromAccount: null,fromUserFirebaseId: Get.find<AuthController>().user.value.customerProfile.firebaseId);
    var toData = ToDataBean(toContactNumber: toAddress?.mobileNumber,toAccount:null,toUserFirebaseId: toAddress?.customerProfile?.firebaseId);
    var optionalDataBean = OptionalDataBean(data: DataBean(transactionContext:trContext.toString(),createFirebaseEntry: "true",amount: payAmount));
    var transactionModel=  TransactionModel(optionalData: optionalDataBean,
      transactionId: payTransId ,
      fromData: fromData,
      toData: toData,
      paid: true,
      transactionType: "paid",
      subType: "Grocery",
      status: "Success",
      transactionDate: DateTime.now().toIso8601String(),
      toType: null);
   // showProgress.value = true;
    print(jsonEncode(transactionModel.toJson()));
    Either<Failure, BaseResponse> responseDa = await getIt.get<TransactionRepository>().updateTaraTransaction(transactionModel);
    showProgress.value = false;
    return responseDa;
  }

  void getOtpForTransfer({bool isFromResendOtp = false}) async {
    //validate empty state here for the text fields

    showProgress.value = true;
    userMobileNumber.value = Get.find<AuthController>().user.value.customerProfile.mobileNumber;
    AuthRequest request = AuthRequest(mobileNumber: userMobileNumber.value);
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
      userMobileNumber.value = Get.find<AuthController>().user.value.customerProfile.mobileNumber;
      AuthRequest request = AuthRequest(mobileNumber: userMobileNumber.value, otp: otp.value);
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
    if (timer != null) {
      timer.cancel();
      timer = null;
      seconds.value=120;
    }

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

    }
    );
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
  Future getTransactions() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var queries = await BaseRequestHelper()
          .getCustomerDataQueryParam();

      var resp = await getIt.get<TransactionRepository>().getTxnHistory(queries);
      var transactionResp = resp.getOrElse(() => null);
      var transactionsListUpdated = <TransactionListBean>[];
      transactionResp.transactionList.forEach((element) {
        element.month = Jiffy.unix(element.timestamp).MMMM;
        transactionsListUpdated.add(element);
      });
      transactionResp.transactionList = transactionsListUpdated;
      return transactionResp;
    }
  }

  Future getBeneficiaries() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var queries = await BaseRequestHelper()
          .getCustomerDataQueryParam();

      var resp = await getIt.get<TransactionRepository>().getTxnHistory(queries);
      var transactionResp = resp.getOrElse(() => null);
      var transactionsListUpdated = <TransactionListBean>[];
      transactionResp.transactionList.forEach((element) {
        element.month = Jiffy.unix(element.timestamp).MMMM;
        transactionsListUpdated.add(element);
      });
      transactionResp.transactionList = transactionsListUpdated;
      return transactionResp;
    }
  }

  Future<List<BankDetailsBean>> getBanksList() async {
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
          var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP();
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
                      userMobileNumber.value = Get.find<AuthController>().user.value.customerProfile.mobileNumber;
                      showProgress.value = false;
                      Get.to(OTPVerificationScreen(txnId: txnId,fetchOtpResponse: fetchOTPResponse,retrieveKeyResponse: retriveKeyResponse,deviceInfoBean: deviceInfo,bic: bic,from: "addaccount",));

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

  Future payNow({String mobileNumber,String amount1,String remarks1, String bic1, String cvv1,num initiatorAccountId1,num benId1}) async {
    showProgress.value = true;
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      //  var toMobileNumber = "8368951368";//"8106170677";//"9295909790";  should be without country code
      var toMobileNumber = mobileNumber.removeAllWhitespace;
      var amount= amount1;
      var remarks = remarks1;
      var merchantTxnId = uuid.v1();//need to keep this transaction ID alive for track the transaction request.
      var benId = benId1; // get these from Search beneficiary call by passing the mobile number to the api
      var bic = "CENAID00001";//bic1; // get these from Search beneficiary call by passing the mobile number to the api
      var cvvValue = cvv1;
// These below two lines has to be removed
      var customerProfile = await getCustomerProfile2();
      var initiatorAccountId = customerProfile.mappedBankAccounts[0].accountTokenId;
      // var initiatorAccountId = initiatorAccountId1;

      var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
      print("=====================ffffffffffffffffff======================");

      var preTransactionRequest = PreTransactionRequest(
        type: RequestType.PAY,
        acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
        requestedLocale: "en",
        accessToken: tokenResponse.token,
        custPSPId: deviceRegInfo.pspIdentifier,
        amount: amount,
      );
      print(jsonEncode(preTransactionRequest.toJson()));


      var resp = await getIt.get<TransactionRepository>().initiatePreTransactionRequest(preTransactionRequest);
      if(resp.isRight()){
        var preTransactionResponse = resp.getOrElse(() => null);
        print("=====================Pre Transaction Request======================");
        print(jsonEncode(preTransactionResponse.toJson()));
        if(preTransactionResponse.success){
          var payeeInfo = PayeesBean(
              amount: amount,
              mobileNo: toMobileNumber,
              beneId: benId,//MIGHT NOT REQUIRED
              appId: PSPConfig.APP_NAME
          );
          var transactionRequest = TransactionRequest(type: RequestType.PAY,
            acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
            requestedLocale: "en",
            accessToken: tokenResponse.token,
            custPSPId: deviceRegInfo.pspIdentifier,
            remarks: remarks,
            payees: [payeeInfo],
            merchantTxnId: merchantTxnId,
            feeTaxRefId: preTransactionResponse.feeTaxRefId,
            initiatorAccountId: initiatorAccountId, //TODO CHANGE
          );
          print("=====================Transaction Request======================");
          print(jsonEncode(transactionRequest.toJson()));
          var tResp = await getIt.get<TransactionRepository>().initiateTransactionRequest(transactionRequest);
          if(tResp.isRight()){
            var initiateTransactionResponse = tResp.getOrElse(() => null);
            print("=====================Transaction Resposne======================");
            print(jsonEncode(initiateTransactionResponse.toJson()));
            if(initiateTransactionResponse.success){
             var toAddressResp = await Get.find<AuthController>().getToAddressForPayment("91"+toMobileNumber);
              if(toAddressResp.isRight()){
                toAddress = toAddressResp.getOrElse(() => null);

                print("to firebase id"+jsonEncode(toAddress.toJson()));
                if(toAddress!=null){
                  await paymentInitiation(amount:double.parse(amount1),toAddress: toAddress,trContext: TransactionContext.PAYMENT_REQUEST);
                  //Retrieve Key Request
                  var txnId = initiateTransactionResponse.transactionId;
                  var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP();
                  var retrieveKeyRequest = RetrieveKeyRequest(
                      deviceInfo: deviceInfo,
                      paymentInstrument: PaymentInstrumentBean(
                          paymentInstrumentType: "ACCOUNT",
                          bic:bic
                      ),
                      resetCredentialCall: false,
                      startDateTime: DateTime.now().microsecondsSinceEpoch
                  );
                  print("=====================Transaction Resposne======================");
                  print(jsonEncode(retrieveKeyRequest.toJson()));
                  var respo = await getIt.get<TransactionRepository>().retrieveKey(retrieveKeyRequest,TransactionType.FINANCIAL_TXN,txnId);
                  if(respo.isRight()) {
                    var retriveKeyResponse = respo.getOrElse(() => null);
                    print(jsonEncode(retriveKeyResponse.toJson()));
                    var cvv = await CryptoHelper().encryptBankData("$txnId|$cvvValue|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                    var authorizeReq = AuthorizeRequest(deviceInfo: await BaseRequestHelper().getDeviceInfoBeanWithPSP(),
                        authorizePINCred: AuthorizePINCredBean(
                            credType: "MPIN",
                            credValue:cvv
                        ));
                    var respo2 = await getIt.get<TransactionRepository>().authorize(authorizeReq,TransactionType.FINANCIAL_TXN,retriveKeyResponse.sessionKey,
                        txnId);
                    if(respo2.isRight()){
                      var res = respo2.getOrElse(() => null);
                      if(res.commonResponse.success){
                        var fetchOtpRequest = FetchOtpRequest(
                          deviceInfo: deviceInfo,
                          paymentInstrument: PaymentInstrumentBean(
                              bic: bic,
                              paymentInstrumentType: "ACCOUNT"
                          ),
                          action: ActionType.PURCHASE,
                        );
                        print(jsonEncode(fetchOtpRequest.toJson()));
                        Timer(Duration(seconds: 2), ()async{
                          var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
                          if(deviceRegInfo!=null){
                            print(jsonEncode(deviceRegInfo.toJson()));
                            var fetchOTPR = await getIt.get<TransactionRepository>().fetchOtp(fetchOtpRequest,TransactionType.FINANCIAL_TXN,retriveKeyResponse.sessionKey,txnId);
                            if(fetchOTPR.isRight()){
                              var fetchOTPResponse = fetchOTPR.getOrElse(() => null);
                              print(jsonEncode(fetchOTPResponse.toJson()));
                              userMobileNumber.value = Get.find<AuthController>().user.value.customerProfile.mobileNumber;
                              showProgress.value = false;
                              Get.to(OTPVerificationScreen(txnId: txnId,fetchOtpResponse: fetchOTPResponse,retrieveKeyResponse: retriveKeyResponse,deviceInfoBean: deviceInfo,bic: bic,from:"transfer"));

                              //Break the Flow here and take him to the OTP Enter Screen  // take the otp from fetchOTPResponse in the next screen
                              // var re = await validateOtpAndTrackTransaction(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                            }else{
                              showDialogWithErrorMsg("Unable to fetch the otp");
                            }
                          }else{
                            showDialogWithErrorMsg("Failed to get Device Reg Info");
                          }

                        }
                        );


                      }else{
                        showDialogWithErrorMsg("Authroziation Failed");
                      }
                    }else{
                      showDialogWithErrorMsg("Authorization Response Failed");
                    }
                  }else{
                    showDialogWithErrorMsg("Retrieve key request failed");
                  }
                }else{
                  showDialogWithErrorMsg("Entered invalid mobile number");
                }
              }else{
                showDialogWithErrorMsg("Failed to get To Address");
              }
          }else{
              showDialogWithErrorMsg("Pretransaction initiation Failed");
            }
        }else{
          showDialogWithErrorMsg("Pretransaction initiation Failed");
        }
      }else{
          showDialogWithErrorMsg("Pretransaction not initiated");
        }
      }else{
        showDialogWithErrorMsg("Pretransaction Request Failed");
      }
    }else{
      showDialogWithErrorMsg("Session not initiated ");
    }

  }

  Future validateOtpAndTrackTransaction(String txnId, FetchOtpResponse fetchOTPResponse, RetrieveKeyResponse d, var deviceInfo, String bic) async {
    var encValid = await CryptoHelper().encryptBankData("$txnId|${fetchOTPResponse.otpChallengeCode}|${Random.secure()}",d.bankKi,d.publicKey);
    var validateOtpRequest = ValidateOtpRequest(
        deviceInfo: deviceInfo,
        bic:bic,
        action: ActionType.PURCHASE,
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
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var rr = TrackTransactionRequest(
          acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
          requestedLocale: "en",
          accessToken: tokenResponse.token,
          transactionId: txnId,
          custPSPId: deviceRegInfo.pspIdentifier,
          waitForCompletion: true
      );

      var trackAccountR = await getIt.get<TransactionRepository>().trackTransactionRequest(rr);
      if(trackAccountR.isRight()){
        var trackAccountResponse = trackAccountR.getOrElse(() => null);
        print(jsonEncode(trackAccountResponse.toJson()));
        if(trackAccountResponse.success){
         var response = await paymentCompleted(toAddress: toAddress);
        if(response.isRight()){
          var paymentCompleteRes = trackAccountR.getOrElse(() => null);
              if(paymentCompleteRes!=null){
                Get.to(ConversationPage(selectedContact: ContactInfo(),custInfo: toAddress.customerProfile,));
              }
         }
        }else{
          print("transaction failed");
        }
      //  Get.offAll(Utils().getLandingScreen());

      }
    }
  }

  Future addBeneficiary({String mobile,String accountNo,String bic,String name,String accountType = "SAVINGS",bool isNewUser= false}) async {

    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();

    if(isSessionInitiated){
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var addBeneficiaryRequest = AddBeneficiaryRequest(
          acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
          requestedLocale: "en",
          accessToken: tokenResponse.token,
          custPSPId: deviceRegInfo.pspIdentifier,
          beneAccountNo: accountNo,
          beneAppName: PSPConfig.APP_NAME,
          beneMobile: mobile,
          beneBic: bic,
          beneName: name,
          beneType: "ACCOUNT",
          accountType: accountType
      );
      print("ADD BENE REQUEST:::===============================");
      print(jsonEncode(addBeneficiaryRequest.toJson()));
      var response = await getIt.get<TransactionRepository>().addBeneficiary(addBeneficiaryRequest);
      print("fffffffffffffffffffffffffffffffffffff");
      if(response.isRight()){
        var addBeneResp = response.getOrElse(() => null);
        print("sssssssssssssssssssssssssssssssssss");

        if(addBeneResp.success){
          print("ttttttttttttttttttttttttttttttttttt");

          var mapBeneficiaryRequest = MapBeneficiaryRequest(
              acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
              requestedLocale: "en",
              accessToken: tokenResponse.token,
              custPSPId: deviceRegInfo.pspIdentifier,
              transactionId: addBeneResp.transactionId,
              accepted: true
          );
          var resp2 = await getIt.get<TransactionRepository>().mapBeneficiaryDetails(mapBeneficiaryRequest);
          print("fffffffffffffffffffffffffffffffffffff");

          if(resp2.isRight()){
            var finalResp = resp2.getOrElse(() => null);
            if(finalResp.success){
              //Pop the Screen and display toast to say the mapping is successful
              print("successfully added the beneficiary@@@@@");

              if(isNewUser){
                Get.find<AuthController>().createTempAccount(RegistrationStatus.BENEFICIARY,mobile);
              }
                //Create Dummy Account
              //  payNow("","222", "gift", "", "123", 44);
              // payNow(mobileNumber: "8368957368",amount1: "100",remarks1: "Gift",benId1: 44,cvv1: "123",initiatorAccountId1: 44,); // commented to break the flow and take him back to transfer screen
            }else{
              showDialogWithErrorMsg("Failed to map the account");
            }
          }
        }else{
          showDialogWithErrorMsg("Failed to add the account");
        }

      }
    }




  }

  Future getCards() async{
    var response = await getIt.get<McPaymentRepository>().getCards();
    print(response);
    if(response.isRight()) {
      return response.getOrElse(() => null);
    }
  }

  Future addCard() async{
    var request = cards.CreateCardOrPayRequest();
    var response = await getIt.get<McPaymentRepository>().createCardOrPay(request);
    if(response.isRight()){
      var finalResponse = response.getOrElse(() => null);
      if(finalResponse?.data?.seamless_url?.isNotEmpty??false) {
        opacityValue.value=0.0;
        Get.off(CommonWebViewScreen(title: "Add Credit Card",
            type: WebViewType.ADD_CREDIT_CARD,
            url: finalResponse.data.seamless_url));
      }
    }
    print(response);
  }



  Future payViaCreditCard(String mcPaymentCardId,double transactionAmount,String description,String maskedCardNumber) async{
     var request = PayCardRequest(register_id: mcPaymentCardId,
      amount: transactionAmount,
      description: description,
      return_url: "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback",
      token: maskedCardNumber, // need to pass masked card number here
    );
     showProgress.value = true;
    var response = await getIt.get<McPaymentRepository>().payWithCreditCard(request);
     showProgress.value = false;
    if(response.isRight()){
      var finalResponse = response.getOrElse(() => null);
      if(finalResponse?.data?.seamless_url?.isNotEmpty??false) {
        //_launchURL(finalResponse.data.seamless_url);
        Get.to(CommonWebViewScreen(title: "Paying with Credit card",
            type: WebViewType.PAYMENT,
            url: finalResponse.data.seamless_url));
      }

    }
  }





  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
      seconds.value=120;

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

  dynamic showDialogWithErrorMsg(String msg) {
    showProgress.value = false;
    getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(desc:msg));

  }

}

