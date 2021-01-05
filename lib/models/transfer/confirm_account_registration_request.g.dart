// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_account_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmAccountRegistrationRequest _$ConfirmAccountRegistrationRequestFromJson(
    Map<String, dynamic> json) {
  return ConfirmAccountRegistrationRequest(
    bic: json['bic'] as String,
    accepted: json['accepted'] as bool,
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConfirmAccountRegistrationRequestToJson(
        ConfirmAccountRegistrationRequest instance) =>
    <String, dynamic>{
      'bic': instance.bic,
      'accepted': instance.accepted,
      'deviceInfo': instance.deviceInfo,
    };
