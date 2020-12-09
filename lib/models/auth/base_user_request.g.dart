// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUserRequest _$BaseUserRequestFromJson(Map<String, dynamic> json) {
  return BaseUserRequest(
    logId: json['logId'] as String,
    refId: json['refId'] as String,
    userName: json['userName'] as String,
  );
}

Map<String, dynamic> _$BaseUserRequestToJson(BaseUserRequest instance) =>
    <String, dynamic>{
      'logId': instance.logId,
      'refId': instance.refId,
      'userName': instance.userName,
    };
