// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAddress _$StoreAddressFromJson(Map<String, dynamic> json) {
  return StoreAddress(
    dno: json['dno'] as String,
    streetName: json['streetName'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
    zipcode: (json['zipcode'] as num)?.toDouble(),
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
