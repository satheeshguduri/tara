// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerAddress _$OwnerAddressFromJson(Map<String, dynamic> json) {
  return OwnerAddress(
    dno: json['dno'] as String,
    streetName: json['streetName'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
    zipcode: (json['zipcode'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OwnerAddressToJson(OwnerAddress instance) =>
    <String, dynamic>{
      'dno': instance.dno,
      'streetName': instance.streetName,
      'city': instance.city,
      'country': instance.country,
      'zipcode': instance.zipcode,
    };
