// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) {
  return OrderAddress(
    json['dno'] as String,
    json['streetName'] as String,
    json['city'] as String,
    json['country'] as String,
    json['zipcode'] as int,
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
