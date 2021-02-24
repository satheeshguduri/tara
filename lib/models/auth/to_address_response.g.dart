// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToAddressResponse _$ToAddressResponseFromJson(Map<String, dynamic> json) {
  return ToAddressResponse(
    id: json['id'] as num,
    mobileNumber: json['mobileNumber'] as String,
    customerProfile: json['customerProfile'] == null
        ? null
        : CustomerProfile.fromJson(
            json['customerProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ToAddressResponseToJson(ToAddressResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mobileNumber': instance.mobileNumber,
      'customerProfile': instance.customerProfile,
    };
