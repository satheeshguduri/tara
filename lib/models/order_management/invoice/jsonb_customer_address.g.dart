// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonb_customer_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonbCustomerAddress _$JsonbCustomerAddressFromJson(Map<String, dynamic> json) {
  return JsonbCustomerAddress(
    json['addressLine'] as String,
    json['street'] as String,
    json['district'] as String,
    json['state'] as String,
    json['country'] as String,
    json['pinCode'] as String,
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
