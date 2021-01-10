// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorize_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizeRequest _$AuthorizeRequestFromJson(Map<String, dynamic> json) {
  return AuthorizeRequest(
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
    authorizePINCred: json['authorizePINCred'] == null
        ? null
        : AuthorizePINCredBean.fromJson(
            json['authorizePINCred'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthorizeRequestToJson(AuthorizeRequest instance) =>
    <String, dynamic>{
      'deviceInfo': instance.deviceInfo,
      'authorizePINCred': instance.authorizePINCred,
    };

AuthorizePINCredBean _$AuthorizePINCredBeanFromJson(Map<String, dynamic> json) {
  return AuthorizePINCredBean(
    credType: json['credType'] as String,
    credValue: json['credValue'] as String,
  );
}

Map<String, dynamic> _$AuthorizePINCredBeanToJson(
        AuthorizePINCredBean instance) =>
    <String, dynamic>{
      'credType': instance.credType,
      'credValue': instance.credValue,
    };
