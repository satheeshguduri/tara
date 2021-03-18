// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_put_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPutRequest _$AuthPutRequestFromJson(Map<String, dynamic> json) {
  return AuthPutRequest(
    json['mobileNumber'] as String,
    json['password'] as String,
    json['accountStatus'] as bool,
    json['customerType'] as String,
  );
}

Map<String, dynamic> _$AuthPutRequestToJson(AuthPutRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'accountStatus': instance.accountStatus,
      'customerType': instance.customerType,
    };
