// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerAddress _$OwnerAddressFromJson(Map<String, dynamic> json) {
  return OwnerAddress(
    json['dno'] as String,
    json['streetName'] as String,
    json['city'] as String,
    json['country'] as String,
    (json['zipcode'] as num)?.toDouble(),
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
