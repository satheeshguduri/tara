// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAddress _$StoreAddressFromJson(Map<String, dynamic> json) {
  return StoreAddress(
    json['dno'] as String,
    json['streetName'] as String,
    json['city'] as String,
    json['country'] as String,
    (json['zipcode'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$StoreAddressToJson(StoreAddress instance) =>
    <String, dynamic>{
      'dno': instance.dno,
      'streetName': instance.streetName,
      'city': instance.city,
      'country': instance.country,
      'zipcode': instance.zipcode,
    };
