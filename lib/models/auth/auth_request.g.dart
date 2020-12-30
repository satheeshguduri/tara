// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) {
  return AuthRequest(
    mobileNumber: json['mobileNumber'] as String,
    password: json['password'] as String,
    otp: json['otp'] as String,
    customerProfile: json['customerProfile'] == null
        ? null
        : CustomerProfile.fromJson(
            json['customerProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'otp': instance.otp,
      'customerProfile': instance.customerProfile,
    };

AuthRequestWithData _$AuthRequestWithDataFromJson(Map<String, dynamic> json) {
  return AuthRequestWithData(
    data: json['data'] == null
        ? null
        : AuthRequest.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthRequestWithDataToJson(
        AuthRequestWithData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
