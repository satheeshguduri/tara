// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityToken _$SecurityTokenFromJson(Map<String, dynamic> json) {
  return SecurityToken(
    id: json['id'] as int,
    token: json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
    createdDate: json['createdDate'] as String,
    updatedDate: json['updatedDate'] as String,
    expiryDate: json['expiryDate'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$SecurityTokenToJson(SecurityToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'expiryDate': instance.expiryDate,
      'refreshToken': instance.refreshToken,
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    id: json['id'] as int,
    tara: json['tara'] as String,
    ndmp: json['ndmp'] as String,
    rtp: json['rtp'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'id': instance.id,
      'tara': instance.tara,
      'ndmp': instance.ndmp,
      'rtp': instance.rtp,
    };
