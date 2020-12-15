// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerAddress _$CustomerAddressFromJson(Map<String, dynamic> json) {
  return CustomerAddress(
    id: (json['id'] as num)?.toDouble(),
    address: json['address'] == null
        ? null
        : JsonbCustomerAddress.fromJson(
            json['address'] as Map<String, dynamic>),
    addressType: json['addressType'] as String,
  );
}

Map<String, dynamic> _$CustomerAddressToJson(CustomerAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address?.toJson(),
      'addressType': instance.addressType,
    };
