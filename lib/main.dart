/*
*  main.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:helpcrunch_plugin/helpcrunch.dart';
import 'package:logging/logging.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/mcpayment/create_card_or_pay_request.dart';
import 'package:tara_app/models/mcpayment/pay_card_request.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/authorize_request.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/device_info.dart' as d;
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/models/transfer/register_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/validate_mobile_request.dart';
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/mc_payment_repository.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/consumer/common_webview.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/tara_app.dart';
import 'dart:convert';

import 'models/core/device/user_registration_txn_request.dart';
import 'models/transfer/add_beneficiary_request.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded((){
      runApp(TaraApp());
    }, (obj,trace){});//Crashlytics.instance.recordError);
  });
  enableLogging();
}

void enableLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((onData) {
    print('${onData.time} : ${onData.level.name}: ${onData.message}');
  });
}
class TestWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              OutlineButton.icon(onPressed: ()async{
              await getCustomerProfile2();

              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Get MyAccounts")),
              OutlineButton.icon(onPressed: ()async{
                await getBeneficiaries();

              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Get Beneficiaries")),
              FlatButton(onPressed: ()async {
                print("initiating the session");

                // var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
                var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest(mobileNumber: "+919542829992");
                await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);

              }, child: Text("Submit")),
              RaisedButton(onPressed: ()async{
                var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
                await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
                await registerDevice();

              },child: Text("Register")),
              OutlineButton.icon(onPressed: ()async{//  On contact Hit  ==> get the benId from the response
                await getBeneficiaryDetails();

              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Get Beneficiary Details")),
              OutlineButton.icon(onPressed: ()async{
                //Base info required for the requests
                await payNow();
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Initiate Transaction")),
              ///GET BANK LIST API CALL =========================== =========================== =========================== ===========================
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await getBanksList();
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Get Banks List")),
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                // await addBankAccount();
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Add bank Account")),
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await validateMobile("9295909790");
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Validate Mobile")),
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await addBeneficiary(mobile:"9295909790",accountNo: "333333333333333",bic: "CENAID00001",name:"satheesh");
                // await addBeneficiary(mobile:"9865327410",accountNo: "9865327410",bic: "CENAID00001",name:"bene by account");
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Add Beneficiary")),
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await HelpCrunch.initialize(
                    organization: 'nxgenpro',
                    appId: 1,
                    appSecret: 'oUhoF0PF0GASUWAY6O+L7luNkTeJRUkLNXUJmrYJ5N6Zr62xx7TEv81SvVcQCkv8VcU5kAmJ8kwNOVIyEuRvvQ==',
                );
                await HelpCrunch.showChatScreen();
                // await addBeneficiary(mobile:"9865327410",accountNo: "9865327410",bic: "CENAID00001",name:"bene by account");
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Help")),
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await getCards();
                // await addBeneficiary(mobile:"9865327410",accountNo: "9865327410",bic: "CENAID00001",name:"bene by account");
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Get Cards")),
              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await addCard();
                // await addBeneficiary(mobile:"9865327410",accountNo: "9865327410",bic: "CENAID00001",name:"bene by account");
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Add Card")),

              OutlineButton.icon(onPressed: () async{//  On contact Hit  ==> get the benId from the response
                await payViaCreditCard("35f6363c72d7410bbcf62efd19cdde9d",100, "test payment","498765******8769");
                // await addBeneficiary(mobile:"9865327410",accountNo: "9865327410",bic: "CENAID00001",name:"bene by account");
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Pay with Card")),
              RaisedButton(onPressed: () async{
                await getBanners();
              }, child: Text("Get Banners")),
              RaisedButton(onPressed: () async{
                await getCategories();
              }, child: Text("Get Categories")),
              RaisedButton(onPressed: () async{
                await getItems();
              }, child: Text("Get Items"))




            ],
          ),
        ),
      ),
    );
  }
  getBanners() async{
    var response = await getIt.get<OrderRepository>().getBanners("41825412");
    print(response);
  }
  getItems() async{
    var response = await getIt.get<OrderRepository>().getItemsByCatalogue("215");
    print(response);
  }
  getCategories() async{
    var response = await getIt.get<OrderRepository>().getCategories();
    print(response);
  }
  getCards() async{
    var response = await getIt.get<McPaymentRepository>().getCards();
    print(response);
  }
  addCard() async{
    var request = CreateCardOrPayRequest();
    var response = await getIt.get<McPaymentRepository>().createCardOrPay(request);
    if(response.isRight()){
      var finalResponse = response.getOrElse(() => null);
      if(finalResponse?.data?.seamless_url?.isNotEmpty??false) {
        Get.to(CommonWebViewScreen(title: "Add Credit Card",
            type: WebViewType.ADD_CREDIT_CARD,
            url: finalResponse.data.seamless_url));
      }

    }
    print(response);
  }
  payViaCreditCardCardNew(num transactionAmount,String description) async{
    var request = CreateCardOrPayRequest(is_transaction: true,transaction: TransactionBean(amount: transactionAmount,description: description),);

    var response = await getIt.get<McPaymentRepository>().createCardOrPay(request);
    if(response.isRight()){
      var finalResponse = response.getOrElse(() => null);
      if(finalResponse?.data?.seamless_url?.isNotEmpty??false) {
        Get.to(CommonWebViewScreen(title: "Paying with Credit card",
            type: WebViewType.PAYMENT,
            url: finalResponse.data.seamless_url));
      }

    }
  }
  payViaCreditCard(String mcPaymentCardId,num transactionAmount,String description,String maskedCardNumber) async{
    var request = PayCardRequest(register_id: mcPaymentCardId,
        amount: transactionAmount,
        description: description,
        return_url: "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback",
        token: maskedCardNumber, // need to pass masked card number here
    );

    var response = await getIt.get<McPaymentRepository>().payWithCreditCard(request);
    if(response.isRight()){
      var finalResponse = response.getOrElse(() => null);
      if(finalResponse?.data?.seamless_url?.isNotEmpty??false) {
        Get.to(CommonWebViewScreen(title: "Paying with Registered Credit card",
            type: WebViewType.PAYMENT,
            url: finalResponse.data.seamless_url));
      }

    }
  }
   getBeneficiaries() async {
     var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();

     if(isSessionInitiated){
       var queries =  await BaseRequestHelper().getCustomerDataQueryParam();
       var response = getIt.get<TransactionRepository>().getBeneficiaries(queries);
       print(response);
     }
  }
  Future validateMobile(String mobileNumber,) async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();

    if(isSessionInitiated){
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var validationRequest = ValidateMobileRequest(
        acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
        requestedLocale: "en",
        accessToken: tokenResponse.token,
        custPSPId: deviceRegInfo.pspIdentifier,
        validationAppName: PSPConfig.APP_NAME,
        validationMobile: mobileNumber,
      );
      var response = getIt.get<TransactionRepository>().validateMobile(validationRequest);
    }

  }

  Future addBeneficiary({String mobile,String accountNo,String bic,String name,String accountType = "SAVINGS"}) async {

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
      var response = await getIt.get<TransactionRepository>().addBeneficiary(addBeneficiaryRequest);
      if(response.isRight()){
        var addBeneResp = response.getOrElse(() => null);

        if(addBeneResp.success){
          var mapBeneficiaryRequest = MapBeneficiaryRequest(
              acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
              requestedLocale: "en",
              accessToken: tokenResponse.token,
              custPSPId: deviceRegInfo.pspIdentifier,
              transactionId: addBeneResp.transactionId,
              accepted: true
          );
          var resp2 = await getIt.get<TransactionRepository>().mapBeneficiaryDetails(mapBeneficiaryRequest);
          if(resp2.isRight()){
            var finalResp = resp2.getOrElse(() => null);
            if(finalResp.success){
              //Pop the Screen and display toast to say the mapping is successful
            }
          }
        }else{
          // return failure
        }

      }
    }




  }

  Future addBankAccount(String bicValue, String last6Digits,String name, String cardNumber,String cvvData, String expM,String expY,String accountNum) async {
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
          var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP(mobileNumber:"9542829992");
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
                  var fetchOTPR = await getIt.get<TransactionRepository>().fetchOtp(fetchOtpRequest,TransactionType.REGISTER_CARD_ACC_DETAIL,retriveKeyResponse.sessionKey,txnId);
                  if(fetchOTPR.isRight()){
                    var fetchOTPResponse = fetchOTPR.getOrElse(() => null);
                    print(jsonEncode(fetchOTPResponse.toJson()));

                    // call in OTP validation Screen
                    //await validateOtpAndTrack(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                  }

                }
              }
            }else{

            }
          }

        }
      }
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
      }
    }
  }

  Future validateOtpAndTrack(String txnId, FetchOtpResponse fetchOTPResponse, RetrieveKeyResponse d, var deviceInfo, String bic) async {
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
        print(jsonEncode(trackAccountResponse.toJson()));
      }
    }
  }

  Future getBanksList() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
      var bankListR = await getIt.get<TransactionRepository>().getBanksList(commonRequest);
      if(bankListR.isRight()){
        var response = bankListR.getOrElse(() => null);

      }
    }
  }

  Future registerDevice() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated){
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var request = RegisterRequest(userName: "USER: 9542829992",
          accessToken: tokenResponse.token,
          acquiringSource: AcquiringSourceBean(mobileNumber: "9542829992"));
      print(jsonEncode(request.toJson()));
      print(jsonEncode(request.acquiringSource.toJson()));
       var data = await getIt.get<DeviceRegisterRepository>().register(request);
       if(data.isRight()){
         var registerResponse = data.orElse(() => null);
         print("======================== Register user Transaction ========================================");
         var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
         var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
         var txnRequest = UserRegistrationTxnRequest(txnId: sessionInfo.transactionId,
         mobileNumber: "9542829992",
         );
         await getIt.get<DeviceRegisterRepository>().registerUserTxn(txnRequest);
         var deviceId = await FlutterUdid.udid;
         await getIt.get<SessionLocalDataStore>().setIdentifier(uuid.v1());
         var splIdentifier = await getIt.get<SessionLocalDataStore>().getIdentifier();
         var userRegistrationRequest = UserRegistrationRequest(
           splIdentifier: splIdentifier,
           deviceInfo: DeviceInfoBean(
             cpuArch: "64bit",
             deviceId: deviceId,
             appId: PSPConfig.APP_NAME,
             hardwareTouchSupport: true,
             imei1: "511845795493030",
             imei2: "450714849660619",
             languageSet: "english",
             os: "android10",
             maxTouchPoints: "10",
             screenResolution: "2220x1080",
             timezoneOffset: "GMT+7",
             userAgent: "JUNIT/Nilesh",

           )

         );
         print(jsonEncode(userRegistrationRequest.toJson()));
         var userRegResponseEither = await getIt.get<DeviceRegisterRepository>().registerUser(userRegistrationRequest);
         if(userRegResponseEither.isRight()){
           var userRegResponse = userRegResponseEither.getOrElse(() => null);
           print("======================== Register user Transaction Response========================================");
           print(jsonEncode(userRegResponse.toJson()));
           var trackRequest=  TrackTransactionRequest(accessToken:tokenResponse.token,transactionId: sessionInfo.transactionId,
               acquiringSource: AcquiringSourceBean(mobileNumber: "9542829992"));
           await getIt.get<DeviceRegisterRepository>().trackRegistration(trackRequest);
         }
       }
    }else{

    }
  }

  //on Launch transfer amount entery screen
  Future<CustomerProfileDetailsResponse> getCustomerProfile2() async {
     var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var commonRequest = await BaseRequestHelper()
          .getCommonRegistrationRequest();

      var resp = await getIt.get<AuthRepository>().getCustomerProfile(
          commonRequest);
      return resp.getOrElse(() => null);
    }
  }

  Future getBeneficiaryDetails() async {
    var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    var toMobileNumber = "9542829992";
    var queries = <String,dynamic>{
      "mobile":toMobileNumber,
      "appId":PSPConfig.APP_NAME,
      "accessToken": tokenResponse?.token,
      "pspId": deviceRegInfo?.pspIdentifier,
    };
    await getIt.get<TransactionRepository>().searchBeneficiary(queries);
  }

  initRequest(){
    var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
    return getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
  }

  payNow() async {
    // var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest(mobileNumber: "+919542829992");
    var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
    print(jsonEncode(commonRegistrationRequest.toJson()));
    await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var toMobileNumber = "8368951368";//"8106170677";//"9295909790";  should be without country code
      var amount= "100";
      var remarks = "Test amount transfer";
      var merchantTxnId = uuid.v1();//need to keep this transaction ID alive for track the transaction request.
      //var benId = 38; // get these from Search beneficiary call by passing the mobile number to the api
      var bic = "CENAID00001"; // get these from Search beneficiary call by passing the mobile number to the api
      var cvvValue = "123";

      var customerProfile = await getCustomerProfile2();

      var initiatorAccountId = customerProfile.mappedBankAccounts[0].accountTokenId;

      var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
      var preTransactionRequest = PreTransactionRequest(
        type: RequestType.PAY,
        acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
        // acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(mobileNumber: "+919542829992"),
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
              // beneId: benId,//MIGHT NOT REQUIRED
              appId: PSPConfig.APP_NAME
          );
          var transactionRequest = TransactionRequest(type: RequestType.PAY,
            acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
            // acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(mobileNumber: "+919542829992"),
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
              //Retrieve Key Request
              var txnId = initiateTransactionResponse.transactionId;
              var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP();
              // var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP(mobileNumber:"+919542829992");
              var retrieveKeyRequest = RetrieveKeyRequest(
                  deviceInfo: deviceInfo,
                  paymentInstrument: PaymentInstrumentBean(
                      paymentInstrumentType: "ACCOUNT",
                      bic:bic
                  ),
                  resetCredentialCall: false,
                  startDateTime: DateTime.now().microsecondsSinceEpoch
              );
              var respo = await getIt.get<TransactionRepository>().retrieveKey(retrieveKeyRequest,TransactionType.FINANCIAL_TXN,txnId);
              if(respo.isRight()) {
                var retriveKeyResponse = respo.getOrElse(() => null);
                print(jsonEncode(retriveKeyResponse.toJson()));
                var cvv = await CryptoHelper().encryptBankData("$txnId|$cvvValue|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                var authorizeReq = AuthorizeRequest(
                    deviceInfo: deviceInfo,
                    // deviceInfo: await BaseRequestHelper().getDeviceInfoBeanWithPSP(mobileNumber:"+919542829992"),
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
                      print(jsonEncode(deviceRegInfo.toJson()));
                      var fetchOTPR = await getIt.get<TransactionRepository>().fetchOtp(fetchOtpRequest,TransactionType.FINANCIAL_TXN,retriveKeyResponse.sessionKey,txnId);
                      if(fetchOTPR.isRight()){
                        var fetchOTPResponse = fetchOTPR.getOrElse(() => null);
                        print(jsonEncode(fetchOTPResponse.toJson()));
                        //Break the Flow here and take him to the OTP Enter Screen  // take the otp from fetchOTPResponse in the next screen
                        var re = await validateOtpAndTrackTransaction(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                      }
                    });


                  }
                }
              }
            }else{
              //Show Toast or dailog here..
            }
          }
        }
      }
    }

  }


}
