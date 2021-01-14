import 'dart:convert';

import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/token_response.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/core/device/user_registration_txn_request.dart';
import 'package:tara_app/models/transfer/register_request.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import '../tara_app.dart';
import 'auth_controller.dart';

class DeviceRegisterController extends GetxController{
  Future registerDevice() async
  {
    var userInfo = Get.find<AuthController>().user.value.customerProfile;
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
      if(isSessionInitiated){
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    //  var request = RegisterRequest(userName: "USER: 9542829992",
        var request = RegisterRequest(userName: userInfo.firstName,

      accessToken: tokenResponse.token,
         // acquiringSource: AcquiringSourceBean(mobileNumber: "9542829992"));
            acquiringSource: AcquiringSourceBean(mobileNumber: userInfo.mobileNumber));
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
         // mobileNumber: "9542829992",
          mobileNumber: userInfo.mobileNumber,
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
              acquiringSource: AcquiringSourceBean(mobileNumber:  userInfo.mobileNumber));
         var response =  await getIt.get<DeviceRegisterRepository>().trackRegistration(trackRequest);

         if(response.isRight()){
            var result= response.getOrElse(() => null);
            if(result.success){
              print("fourth");
              Get.find<AuthController>().showProgress.value = false;
              Get.offAll(Utils().getLandingScreen());
              await getIt.get<SessionLocalDataStore>().setToken(TokenResponse());
            }

          }
        }
      }
    }else{

    }
  }
}