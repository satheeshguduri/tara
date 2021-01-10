// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieve_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrieveKeyResponse _$RetrieveKeyResponseFromJson(Map<String, dynamic> json) {
  return RetrieveKeyResponse(
    sessionKey: json['sessionKey'] as String,
    bankKi: json['bankKi'] as String,
    publicKey: json['publicKey'] as String,
    isUrlPage: json['isUrlPage'] as bool,
    rule: json['rule'] as String,
  );
}

Map<String, dynamic> _$RetrieveKeyResponseToJson(
        RetrieveKeyResponse instance) =>
    <String, dynamic>{
      'sessionKey': instance.sessionKey,
      'bankKi': instance.bankKi,
      'publicKey': instance.publicKey,
      'isUrlPage': instance.isUrlPage,
      'rule': instance.rule,
    };
