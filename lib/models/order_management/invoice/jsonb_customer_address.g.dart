// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonb_customer_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonbCustomerAddress _$JsonbCustomerAddressFromJson(Map<String, dynamic> json) {
  return JsonbCustomerAddress(
    addressLine: json['addressLine'] as String,
    street: json['street'] as String,
    district: json['district'] as String,
    state: json['state'] as String,
    country: json['country'] as String,
    pinCode: json['pinCode'] as String,
  );
}

Map<String, dynamic> _$JsonbCustomerAddressToJson(
        JsonbCustomerAddress instance) =>
    <String, dynamic>{
      'addressLine': instance.addressLine,
      'street': instance.street,
      'district': instance.district,
      'state': instance.state,
      'country': instance.country,
      'pinCode': instance.pinCode,
    };
