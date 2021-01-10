/*
*  main.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/
import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:logging/logging.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/common/helpers/pki_crypto_utils.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/common_request.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/register_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/validate_mobile_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/dio_client.dart';
import 'package:tara_app/services/rest/psp_rest_client.dart';
import 'package:tara_app/services/rest/umps_core_rest_client.dart';
import 'package:tara_app/tara_app.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:encryptions/encryptions.dart';

import 'package:flutter/services.dart';
import 'dart:io';

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
              /*Text("Demo of components"),
          TextField(
            decoration: const InputDecoration(
              hintText: 'What do people call you?',
              hintStyle: TextStyle(height:5, fontWeight: FontWeight.bold,color: Colors.red),
              labelText: 'Name *',
              labelStyle: TextStyle(height:5, fontWeight: FontWeight.bold,color:Colors.grey),
            )),

            TextField(textAlignVertical:TextAlignVertical.bottom,decoration: InputDecoration(
              hintText: "Test",
              labelText: "Phone Number",
              floatingLabelBehavior: FloatingLabelBehavior.always,

              // floatingLabelBehavior: FloatingLabelBehavior.always,
            )),*/
              // Spacer(),

              OutlineButton.icon(onPressed: ()async{
                var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
                var resp = await getIt.get<AuthRepository>().getCustomerProfile(commonRequest);
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Validate mobile Number")),
              FlatButton(onPressed: ()async {
                print("initiating the session");

                // var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
                var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
                await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);


               /*
                final encryptionRes = await getEncryption(json.encode(dataObj.toJson()), PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
                print('final encrypted string: $encryptionRes');
                var data = await getDecryption(encryptionRes, PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
                print("decrypted String:"+ data);
                var client = await APIHelper().getSecurePSPRestClient();
                var res = await client.getAppToken(PSPConfig.MERCHANT_KI, encryptionRes);
                print("Response ==>> "+res);
                final decryptionRes = await getDecryption(res, PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
                print("Description String==>>"+decryptionRes);*/
                // String decryptedString = '';
               // String encrypted = 'bU-I8rV9GAeFCh0bM_U2q1oy_hYGiQeavIcmFdE3Ecnl6AaqAXBy7saT9mKeImP5kvVVICZsrQ4-';
                // String encrypted = 'VyexK5nZf3IBRi9AH46LjvWiJ4cisp1iMGeVriUj0VEkUDYiwOJv75h-iYJk5D9kXpH2eQLmd5XOG_bGgoieHRG4iqr';
               // var d = await getDecryption(encrypted,PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
               //  print(d);
                // Uint8List iv = hex.decode("c1f6fd873e14050697c168b3e9da5db2");
                // Uint8List plain = utf8.encode("test data");
                //
                // AES aes = AES.ofCBC(base64Decode(PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY), iv, PaddingScheme.PKCS5Padding);
                // Uint8List enc = await aes.encrypt(plain);
                // print(utf8.decode(enc));
                // Uint8List decrypted = await aes.decrypt(base64Encode(utf8.decode(enc))));
                // print(decrypted.toString());
                // var key = utf8.encode(PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY).toString();
                // print(key);
                //
                // IV iv = IV.fromSecureRandom(16);
                // var decryptText  = await FlutterAesEcbPkcs5.decryptString(encrypted, PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);

                // print(decryptText);
                // var content = decodeQrCode(encrypted);
                // var content  = await Cipher2.decryptAesCbc128Padding7(encrypted, "Σ6a}fG\$EO70",iv);
                // print(content);


              }, child: Text("Submit")),
              RaisedButton(onPressed: ()async{
                var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();
                if(isValidSession){
                  var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
                  var request = RegisterRequest(userName: "USER: 9542829992",
                      accessToken: tokenResponse.token,
                      acquiringSource: AcquiringSourceBean(mobileNumber: "9542829992"));
                  print(request.toJson().toString());
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
                     var userRegistrationRequest = UserRegistrationRequest(
                       splIdentifier: uuid.v1(),
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

              },child: Text("Register")),
              OutlineButton.icon(onPressed: ()async{//  On contact Hit  ==> get the benId from the response
                var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
                var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
                var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
                var toMobileNumber = "9865327410";
                var queries = <String,dynamic>{
                  "mobile":toMobileNumber,
                  "appId":PSPConfig.APP_NAME,
                  "accessToken": tokenResponse?.token,
                  "pspId": deviceRegInfo?.pspIdentifier,
                };
                await getIt.get<TransactionRepository>().searchBeneficiary(queries);

              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Get Beneficiary Details")),
              OutlineButton.icon(onPressed: ()async{
                //Base info required for the requests
                var toMobileNumber = "+919161654647";
                var amount= "100";
                var remarks = "Test amount transfer";
                var merchantTxnId = uuid.v1();//need to keep this transaction ID alive for track the transactionr equest.
                var benId = 38; // get these from Search beneficiary call by passing the mobile number to the api
                var bic = "CENAID00001"; // get these from Search beneficiary call by passing the mobile number to the api
                var initiatorAccountId = -6848046393958140242; //


                var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
                var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
                var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
                var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
                var preTransactionRequest = PreTransactionRequest(type: RequestType.PAY,
                  acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
                  requestedLocale: "en",
                  merchantId: PSPConfig.MERCHANT_ID,
                  accessToken: tokenResponse.token,
                  transactionId: sessionInfo.transactionId,
                  custPSPId: deviceRegInfo.pspIdentifier,
                  amount: amount,
                  );
                var resp = await getIt.get<TransactionRepository>().initiatePreTransactionRequest(preTransactionRequest);
                if(resp.isRight()){
                  var preTransactionResponse = resp.getOrElse(() => null);
                  if(preTransactionResponse.success){
                    var payeeInfo = PayeesBean(
                        amount: amount,
                        mobileNo: toMobileNumber,
                        // beneId: benId,//MIGHT NOT REQUIRED
                        appId: PSPConfig.APP_NAME
                    );
                    var transactionRequest = TransactionRequest(type: RequestType.PAY,
                      acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean(),
                      requestedLocale: "en",
                      merchantId: PSPConfig.MERCHANT_ID,
                      accessToken: tokenResponse.token,
                      transactionId: sessionInfo.transactionId,
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
                      if(initiateTransactionResponse.success){
                          //Retrieve Key Request
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

                        await getIt.get<TransactionRepository>().retrieveKey(retrieveKeyRequest);
                      }else{
                        //Show Toast or dailog here..
                      }


                    }
                  }

                }
              }, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Initiate Transaction"))
            ],
          ),
        ),
      ),
    );
  }

  initRequest(){
    var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
    return getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
  }
  /*static String decodeQrCode(String encryptedString) {
    try {
      // pad the encrypted base64 string with '=' characters until length matches a multiple of 4
      final int toPad = encryptedString.length % 4;
      if (toPad != 0) {
        encryptedString = encryptedString.padRight(encryptedString.length + toPad, "=");
      }
      print("Encrypted String==> "+encryptedString);
      // get first 16 bytes which is the initialization vector
      final iv = encrypt.IV(Uint8List.fromList(base64Decode(encryptedString).getRange(0, 16).toList()));

      // get cipher bytes (without initialization vector)
      final encrypt.Encrypted encrypted = encrypt.Encrypted(Uint8List.fromList(
          base64Decode(encryptedString).getRange(16, base64Decode(encryptedString).length).toList()));

      // decrypt the string using the key and the initialization vector
      final key = encrypt.Key.fromUtf8(PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      print("Error while decoding QR code : $e");
      return null;
    }
  }*/

}
