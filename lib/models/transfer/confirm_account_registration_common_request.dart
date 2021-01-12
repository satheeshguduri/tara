/*
*  confirm_account_registration_common_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_request.dart';
part 'confirm_account_registration_common_request.g.dart';

@JsonSerializable()
class ConfirmAccountRegistrationCommonRequest {
  CommonRequestBean commonRequest;
  String confirmAccountRegPayloadEnc; // for confirm Account


  ConfirmAccountRegistrationCommonRequest({this.commonRequest, this.confirmAccountRegPayloadEnc});

  factory ConfirmAccountRegistrationCommonRequest.fromJson(Map<String, dynamic> json) => _$ConfirmAccountRegistrationCommonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAccountRegistrationCommonRequestToJson(this);
}