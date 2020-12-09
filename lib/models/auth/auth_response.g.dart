// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return AuthResponse(
    customerProfile: json['customerProfile'] == null
        ? null
        : CustomerProfile.fromJson(
            json['customerProfile'] as Map<String, dynamic>),
    securityToken: json['securityToken'] == null
        ? null
        : SecurityToken.fromJson(json['securityToken'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'customerProfile': instance.customerProfile,
      'securityToken': instance.securityToken,
    };
