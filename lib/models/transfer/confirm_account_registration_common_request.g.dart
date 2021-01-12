// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_account_registration_common_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmAccountRegistrationCommonRequest
    _$ConfirmAccountRegistrationCommonRequestFromJson(
        Map<String, dynamic> json) {
  return ConfirmAccountRegistrationCommonRequest(
    commonRequest: json['commonRequest'] == null
        ? null
        : CommonRequestBean.fromJson(
            json['commonRequest'] as Map<String, dynamic>),
    confirmAccountRegPayloadEnc: json['confirmAccountRegPayloadEnc'] as String,
  );
}

Map<String, dynamic> _$ConfirmAccountRegistrationCommonRequestToJson(
        ConfirmAccountRegistrationCommonRequest instance) =>
    <String, dynamic>{
      'commonRequest': instance.commonRequest,
      'confirmAccountRegPayloadEnc': instance.confirmAccountRegPayloadEnc,
    };
