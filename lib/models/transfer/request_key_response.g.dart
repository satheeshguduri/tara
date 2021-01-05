// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestKeyResponse _$RequestKeyResponseFromJson(Map<String, dynamic> json) {
  return RequestKeyResponse(
    sessionKey: json['sessionKey'] as String,
    bankKi: json['bankKi'] as String,
    publicKey: json['publicKey'] as String,
    isUrlPage: json['isUrlPage'] as bool,
    rule: json['rule'] as String,
  );
}

Map<String, dynamic> _$RequestKeyResponseToJson(RequestKeyResponse instance) =>
    <String, dynamic>{
      'sessionKey': instance.sessionKey,
      'bankKi': instance.bankKi,
      'publicKey': instance.publicKey,
      'isUrlPage': instance.isUrlPage,
      'rule': instance.rule,
    };
