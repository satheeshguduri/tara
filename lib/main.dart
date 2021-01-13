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
import 'package:logging/logging.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
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
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/tara_app.dart';
import 'dart:convert';

import 'models/core/device/user_registration_txn_request.dart';


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
              FlatButton(onPressed: ()async {
                print("initiating the session");

                // var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
                var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
                await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);

              }, child: Text("Submit")),
              RaisedButton(onPressed: ()async{
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
                await addBankAccount();
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Add bank Account")),


            ],
          ),
        ),
      ),
    );
  }

  Future addBankAccount() async {
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
    if(isSessionInitiated){
      var bankResp = await getIt.get<TransactionRepository>().getBanksList(commonRequest);
      if(bankResp.isRight()){
        var banksList = bankResp.getOrElse(() => null);
        var bic = banksList[1].bic;
        var accountDetailsRequest = AccountDetailsRequest(custPSPId: commonRequest.custPSPId,
        accessToken: commonRequest.accessToken,
        bic: bic,
        // transactionId: commonRequest.transactionId,
        requestedLocale: commonRequest.requestedLocale,
        cardLast6Digits: "012345",//"140008",
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
                var fullName = await CryptoHelper().encryptBankData("$txnId|YAKUB PASHA|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                var number = await CryptoHelper().encryptBankData("$txnId|4111111111111111|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                var cvv = await CryptoHelper().encryptBankData("$txnId|123|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                var expMM = await CryptoHelper().encryptBankData("$txnId|02|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                var expYY = await CryptoHelper().encryptBankData("$txnId|25|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
                var accountNumber = await CryptoHelper().encryptBankData("$txnId|1010101010101010|${Random.secure()}",retriveKeyResponse.bankKi,retriveKeyResponse.publicKey);
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
                        await validateOtpAndTrack(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
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
    var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();
    if(isValidSession){
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var request = RegisterRequest(userName: "USER: 9542829992",
          accessToken: tokenResponse.token,
          acquiringSource: AcquiringSourceBean(mobileNumber: "9542829992"));
      print(jsonEncode(request.toJson()));
      print(jsonEncode(request.acquiringSource.toJson()));
       var data = await getIt.get<DeviceRegisterRepository>().register(request);
       if(data.isRight()){
         var registerResponse = data.orElse(() => null);
         print(registerResponse);
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
         print(userRegistrationRequest.toJson().toString());
         var userRegResponseEither = await getIt.get<DeviceRegisterRepository>().registerUser(userRegistrationRequest);
         if(userRegResponseEither.isRight()){
           var userRegResponse = userRegResponseEither.getOrElse(() => null);
           var trackRequest=  TrackTransactionRequest(accessToken:tokenResponse.token,transactionId: sessionInfo.transactionId,
               acquiringSource: AcquiringSourceBean(mobileNumber: "9542829992"));
           await getIt.get<DeviceRegisterRepository>().trackRegistration(trackRequest);
         }
       }
    }else{
    
    }
  }

  Future getCustomerProfile2() async {
     var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if(isSessionInitiated) {
      var commonRequest = await BaseRequestHelper()
          .getCommonRegistrationRequest();

      var resp = await getIt.get<AuthRepository>().getCustomerProfile(
          commonRequest);
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

  getCustomerProfile(){

  }
  payNow() async {
    var toMobileNumber = "+919161654647";
    var amount= "100";
    var remarks = "Test amount transfer";
    var merchantTxnId = uuid.v1();//need to keep this transaction ID alive for track the transactionr equest.
    //var benId = 38; // get these from Search beneficiary call by passing the mobile number to the api
    var bic = "CENAID00001"; // get these from Search beneficiary call by passing the mobile number to the api
    var initiatorAccountId = -6848046393958140242; //


    var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
    var preTransactionRequest = PreTransactionRequest(type: RequestType.PAY,
      acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(mobileNumber: "9542829992"),
      requestedLocale: "en",
      // merchantId: PSPConfig.MERCHANT_ID,
      accessToken: tokenResponse.token,
      // transactionId: sessionInfo.transactionId,
      custPSPId: deviceRegInfo.pspIdentifier,
      amount: amount,
    );

    var customerProfileResp = await getIt.get<AuthRepository>().getCustomerProfile(commonRequest);
    if(customerProfileResp.isRight()){
      var customerProfile =customerProfileResp.getOrElse(() => null);
      print(jsonEncode(customerProfile.toJson()));
    }
    var resp = await getIt.get<TransactionRepository>().initiatePreTransactionRequest(preTransactionRequest);
    if(resp.isRight()){
      var preTransactionResponse = resp.getOrElse(() => null);
      print(jsonEncode(preTransactionResponse.toJson()));
      if(preTransactionResponse.success){
        var payeeInfo = PayeesBean(
            amount: amount,
            mobileNo: toMobileNumber,
            // beneId: benId,//MIGHT NOT REQUIRED
            appId: PSPConfig.APP_NAME
        );
        var transactionRequest = TransactionRequest(type: RequestType.PAY,
          acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(mobileNumber: "9542829992"),
          requestedLocale: "en",
          accessToken: tokenResponse.token,
          // transactionId: sessionInfo.transactionId,
          custPSPId: deviceRegInfo.pspIdentifier,
          remarks: remarks,
          payees: [payeeInfo],
          merchantTxnId: merchantTxnId,
          feeTaxRefId: preTransactionResponse.feeTaxRefId,
          initiatorAccountId: initiatorAccountId, //TODO CHANGE
        );

        var tResp = await getIt.get<TransactionRepository>().initiateTransactionRequest(transactionRequest);
        if(tResp.isRight()){
          var initiateTransactionResponse = tResp.getOrElse(() => null);
          print(jsonEncode(initiateTransactionResponse.toJson()));
          if(initiateTransactionResponse.success){
            //Retrieve Key Request
            var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP(mobileNumber:"9542829992");
            var retrieveKeyRequest = RetrieveKeyRequest(
                deviceInfo: deviceInfo,
                paymentInstrument: PaymentInstrumentBean(
                    paymentInstrumentType: "ACCOUNT",
                    bic:bic
                ),
                resetCredentialCall: false,
                startDateTime: DateTime.now().microsecondsSinceEpoch
            );

            await getIt.get<TransactionRepository>().retrieveKey(retrieveKeyRequest,TransactionType.FINANCIAL_TXN,initiateTransactionResponse.transactionId);
          }else{
            //Show Toast or dailog here..
          }


        }
      }

    }
  }


}
