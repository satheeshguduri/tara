// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationRequest _$UserRegistrationRequestFromJson(
    Map<String, dynamic> json) {
  return UserRegistrationRequest(
    splIdentifier: json['splIdentifier'] as String,
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserRegistrationRequestToJson(
        UserRegistrationRequest instance) =>
    <String, dynamic>{
      'splIdentifier': instance.splIdentifier,
      'deviceInfo': instance.deviceInfo,
    };

DeviceInfoBean _$DeviceInfoBeanFromJson(Map<String, dynamic> json) {
  return DeviceInfoBean(
    deviceId: json['deviceId'] as String,
    appId: json['appId'] as String,
    imei1: json['imei1'] as String,
    imei2: json['imei2'] as String,
    languageSet: json['languageSet'] as String,
    os: json['os'] as String,
    timezoneOffset: json['timezoneOffset'] as String,
    cpuArch: json['cpuArch'] as String,
    userAgent: json['userAgent'] as String,
    screenResolution: json['screenResolution'] as String,
    maxTouchPoints: json['maxTouchPoints'] as String,
    hardwareTouchSupport: json['hardwareTouchSupport'] as bool,
  );
}

Map<String, dynamic> _$DeviceInfoBeanToJson(DeviceInfoBean instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'appId': instance.appId,
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'languageSet': instance.languageSet,
      'os': instance.os,
      'timezoneOffset': instance.timezoneOffset,
      'cpuArch': instance.cpuArch,
      'userAgent': instance.userAgent,
      'screenResolution': instance.screenResolution,
      'maxTouchPoints': instance.maxTouchPoints,
      'hardwareTouchSupport': instance.hardwareTouchSupport,
    };
