// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) {
  return OrderAddress(
    dno: json['dno'] as String,
    streetName: json['streetName'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
    zipcode: json['zipcode'] as int,
  );
}

Map<String, dynamic> _$OrderAddressToJson(OrderAddress instance) =>
    <String, dynamic>{
      'dno': instance.dno,
      'streetName': instance.streetName,
      'city': instance.city,
      'country': instance.country,
      'zipcode': instance.zipcode,
    };
