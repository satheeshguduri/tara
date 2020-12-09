// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest _$BaseRequestFromJson(Map<String, dynamic> json) {
  return BaseRequest(
    prd: json['prd'] as String,
    appVersion: json['appVersion'] as String,
    deviceId: json['deviceId'] as String,
  );
}

Map<String, dynamic> _$BaseRequestToJson(BaseRequest instance) =>
    <String, dynamic>{
      'prd': instance.prd,
      'appVersion': instance.appVersion,
      'deviceId': instance.deviceId,
    };
