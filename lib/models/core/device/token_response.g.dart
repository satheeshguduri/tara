// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return TokenResponse(
    token: json['token'] as String,
    issuedAtMillis: json['issuedAtMillis'] as num,
    validTillMillis: json['validTillMillis'] as num,
    appName: json['appName'] as String,
    custPSPId: json['custPSPId'],
  );
}

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'issuedAtMillis': instance.issuedAtMillis,
      'validTillMillis': instance.validTillMillis,
      'appName': instance.appName,
      'custPSPId': instance.custPSPId,
    };
