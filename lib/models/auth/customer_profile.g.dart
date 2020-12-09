// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerProfile _$CustomerProfileFromJson(Map<String, dynamic> json) {
  return CustomerProfile(
    firstName: json['firstName'] as String,
    id: json['id'] as String,
    lastName: json['lastName'] as String,
    mobileNumber: json['mobileNumber'] as String,
    country: json['country'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    isKyc: json['isKyc'] as bool,
    email: json['email'] as String,
    customerType: json['customerType'] as String,
    firebaseId: json['firebaseId'] as String,
    credential: json['credential'] as String,
    token: json['token'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$CustomerProfileToJson(CustomerProfile instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'id': instance.id,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'country': instance.country,
      'dateOfBirth': instance.dateOfBirth,
      'isKyc': instance.isKyc,
      'email': instance.email,
      'customerType': instance.customerType,
      'firebaseId': instance.firebaseId,
      'credential': instance.credential,
      'token': instance.token,
      'address': instance.address,
    };

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return SignUpRequest(
    data: json['data'] == null
        ? null
        : CustomerProfile.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
