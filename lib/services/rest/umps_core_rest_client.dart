/*
*  umps_core_rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/common_request.dart';
import 'package:tara_app/models/core/device/common_response.dart';
import 'package:tara_app/models/core/device/spl_registration_request_enc.dart';
import 'package:tara_app/models/core/device/user_registration_response.dart';
import 'package:tara_app/models/core/device/user_registration_txn_request.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_common_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_common_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/track_account_details_response.dart';
import 'package:tara_app/services/config/api.dart';
import 'package:tara_app/services/config/psp_config.dart';

part 'umps_core_rest_client.g.dart';

@RestApi(baseUrl: PSPConfig.PUBLIC_IP_UMPS_CORE)
abstract class UMPSCoreRestClient {

  factory UMPSCoreRestClient(Dio dio, {String baseUrl}) = _UMPSCoreRestClient;

  @POST(UMPSCoreApi.user_registration_txn)
  Future<void> registerUserTxn(@Body() UserRegistrationTxnRequest userRegistrationTxnRequest);// empty response just with status code 200 to be checked

  @POST(UMPSCoreApi.user_registration)
  Future<SplRegistrationResponseEnc> registerUser(@Body() SplRegistrationRequestEnc splRegistrationRequestEnc);//from this extract RegistrationResponse

  @POST(UMPSCoreApi.retrieve_key)
  Future<CommonResponse> retrieveKey(@Body() CommonRequest commonRequest);//from this extract RetrieveKey Response and pass RetrieveKey request

  @POST(UMPSCoreApi.register_card_detail)
  Future<CommonResponse> registerCardDetail(@Body() CommonRequest commonRequest);//from this extract RegisterCardResponse and pass RegisterCardRequest

  @POST(UMPSCoreApi.confirm_account_registration)
  Future<CommonResponse> confirmAccountRegistration(@Body() ConfirmAccountRegistrationCommonRequest commonRequest);// pass ConfirmAccountRegistrationRequest

  @POST(UMPSCoreApi.fetch_otp_challenge_code)
  Future<CommonResponse> fetchOtp(@Body() FetchOtpCommonRequest commonRequest);// pass FetchOTPRequest and extract FetchOTP Response

  @POST(UMPSCoreApi.refresh_otp_api)
  Future<CommonResponse> refreshOtp(@Body() CommonRequest commonRequest);// pass RefreshOTPRequest and extract FetchOTPResponse

  @POST(UMPSCoreApi.validate_otp_api)
  Future<CommonResponse> validateOtp(@Body() CommonRequest commonRequest);// pass ValidateOTPRequest

  @POST(UMPSCoreApi.authorize)
  Future<CommonResponse> authorize(@Body() CommonRequest commonRequest);// pass ValidateOTPRequest
}