/*
*  confirm_account_registration_common_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_request.dart';
part 'fetch_otp_common_request.g.dart';

@JsonSerializable()
class FetchOtpCommonRequest {
  CommonRequestBean commonRequest;
  String fetchOtpCodePayloadEnc; // for confirm Account


  FetchOtpCommonRequest({this.commonRequest, this.fetchOtpCodePayloadEnc});

  factory FetchOtpCommonRequest.fromJson(Map<String, dynamic> json) => _$FetchOtpCommonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FetchOtpCommonRequestToJson(this);
}