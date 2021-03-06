import 'dart:convert';

import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
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
  Future registerDevice({bool isAfterRegistration = false}) async
  {
    var commonRegistrationRequest = CommonRegistrationRequest(acquiringSource: AcquiringSourceBean());
    await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
    var userInfo = Get.find<AuthController>().user?.value?.customerProfile;
    var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession(isNewUser: true);
      if(isSessionInitiated){
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
        var request = RegisterRequest(
            userName: userInfo.firstName,
            accessToken: tokenResponse.token,
            acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean());
      print(jsonEncode(request.toJson()));
      print(jsonEncode(request.acquiringSource.toJson()));
      var data = await getIt.get<DeviceRegisterRepository>().register(request);

      if(data.isRight()){
        var registerResponse = data.orElse(() => null);
        print(registerResponse);
        print("======================== Register user Transaction ========================================");
        var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
        var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
        var txnRequest = UserRegistrationTxnRequest(
          txnId: sessionInfo.transactionId,
         // mobileNumber: "9542829992",
          mobileNumber: userInfo?.mobileNumber,
        );
        await getIt.get<DeviceRegisterRepository>().registerUserTxn(txnRequest);
        var deviceId = await FlutterUdid.udid;
        await getIt.get<SessionLocalDataStore>().setIdentifier(uuid.v1());
        var splIdentifier = await getIt.get<SessionLocalDataStore>().getIdentifier();
        var userRegistrationRequest = UserRegistrationRequest(
            splIdentifier: splIdentifier,
            deviceInfo: await BaseRequestHelper().getDeviceInfoBean()

        );
        print(userRegistrationRequest.toJson().toString());
        var userRegResponseEither = await getIt.get<DeviceRegisterRepository>().registerUser(userRegistrationRequest);
        if(userRegResponseEither.isRight()){
          var userRegResponse = userRegResponseEither.getOrElse(() => null);
          var trackRequest=  TrackTransactionRequest(
              accessToken:tokenResponse.token,
              transactionId: sessionInfo.transactionId,
              acquiringSource: await BaseRequestHelper().getCommonAcquiringSourceBean());
         var response =  await getIt.get<DeviceRegisterRepository>().trackRegistration(trackRequest);

         if(response.isRight()){
            var result= response.getOrElse(() => null);
            if(result.success){
              Get.find<AuthController>().showProgress.value = false;
              await getIt.get<SessionLocalDataStore>().clear();
              Get.offAll(Utils().getLandingScreen());
            }
          }
        }
      }
    }else{

    }
  }
}