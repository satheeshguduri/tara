/*
*  base_request_helper.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:flutter_udid/flutter_udid.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/common_request.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/device_info.dart' as DeviceInfoWithPSP;
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/tara_app.dart';

class BaseRequestHelper{
  BaseRequestHelper();


  Future<CommonRequestBean> getCommonRequestBean(TransactionType transactionType, String symmetricKey) async{
    var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    var splIdentifier = await getIt.get<SessionLocalDataStore>().getIdentifier();


    var commonRequestBean = CommonRequestBean(
      txnId:  sessionInfo?.transactionId,
      msgId: uuid.v1(),
      splIdentifier: splIdentifier,
      symmetricKey: symmetricKey,
      transactionType: transactionType,
      pspIdentifier: deviceRegInfo?.pspIdentifier);
    return Future.value(commonRequestBean);

  }

  Future<AcquiringSourceBean> getCommonAcquiringSourceBean({String mobileNumber}) async{
    String ip = "";//await Wifi.;
    var authResponse = await getIt.get<UserLocalDataStore>().getUser();
    return AcquiringSourceBean(
      mobileNumber: mobileNumber??authResponse?.customerProfile?.mobileNumber??"",
      geoCode: GeoCodeBean(latitude: "77.086877",longitude: "28.502991"),//TODO from geo_locator
      appName: PSPConfig.APP_NAME,
      // sourceIPv4: ip,
    );
  }
  Future<CommonRegistrationRequest> getCommonRegistrationRequest() async{
    var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
    var authResponse = await getIt.get<UserLocalDataStore>().getUser();
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    var splIdentifier = await getIt.get<SessionLocalDataStore>().getIdentifier();
    var acquiringSource = await getCommonAcquiringSourceBean(mobileNumber:"9542829992");
    // var acquiringSource = await getCommonAcquiringSourceBean(mobileNumber:authResponse?.customerProfile?.mobileNumber??"");

    var commonRequestBean = CommonRegistrationRequest(
        transactionId:  sessionInfo?.transactionId,
        accessToken:  tokenResponse?.token,
        // merchantId: PSPConfig.MERCHANT_ID,
        custPSPId: deviceRegInfo?.pspIdentifier,
        requestedLocale: "en",
        acquiringSource:acquiringSource
    );
    return Future.value(commonRequestBean);
  }

  Future<Map<String,dynamic>> getCustomerDataQueryParam() async{
    // var authResponse = await getIt.get<UserLocalDataStore>().getUser();
    var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    // appName=com.inde.ayopop&accessToken=7b9044ee-5530-40c5-97a3-ee4046f11ab6&custPSPId=afe400b8-c89a-4391-9a9b-172d7e5e502c&requestedLocale=en
    return <String,dynamic>{
      "appName":PSPConfig.APP_NAME,
      "accessToken": tokenResponse?.token,
      "custPSPId": deviceRegInfo?.pspIdentifier,
      "requestedLocale":"en"
    };
  }
  Future<DeviceInfoBean> getDeviceInfoBean() async {
    var deviceId = await FlutterUdid.udid;
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      return DeviceInfoBean(
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
      );
  }
  Future<DeviceInfoWithPSP.DeviceInfoBean> getDeviceInfoBeanWithPSP({mobileNumber}) async {
    var deviceId = await FlutterUdid.udid;
    var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    return DeviceInfoWithPSP.DeviceInfoBean(
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
        pspIdentifier:deviceRegInfo?.pspIdentifier,
        mobileNo: "9542829992"// CHECK HERE
    );
  }




}