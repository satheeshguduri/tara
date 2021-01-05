// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshOtpRequest _$RefreshOtpRequestFromJson(Map<String, dynamic> json) {
  return RefreshOtpRequest(
    bic: json['bic'] as String,
    referenceId: json['referenceId'] as String,
    action: json['action'] as String,
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RefreshOtpRequestToJson(RefreshOtpRequest instance) =>
    <String, dynamic>{
      'bic': instance.bic,
      'referenceId': instance.referenceId,
      'action': instance.action,
      'deviceInfo': instance.deviceInfo,
    };
