// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateOtpRequest _$ValidateOtpRequestFromJson(Map<String, dynamic> json) {
  return ValidateOtpRequest(
    bic: json['bic'] as String,
    referenceId: json['referenceId'] as String,
    otp: json['otp'] as String,
    action: json['action'] as String,
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValidateOtpRequestToJson(ValidateOtpRequest instance) =>
    <String, dynamic>{
      'bic': instance.bic,
      'referenceId': instance.referenceId,
      'otp': instance.otp,
      'action': instance.action,
      'deviceInfo': instance.deviceInfo,
    };
