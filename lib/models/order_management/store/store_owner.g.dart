// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
    json['id'] as String,
    json['name'] as String,
    json['address'] == null
        ? null
        : OwnerAddress.fromJson(json['address'] as Map<String, dynamic>),
    json['kycStatus'] as bool,
    (json['types'] as List)
        ?.map((e) => e == null
            ? null
            : StoreTypeAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['owners'] as List)
        ?.map((e) => e == null
            ? null
            : StoreOwnerAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['integrationId'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address?.toJson(),
      'kycStatus': instance.kycStatus,
      'types': instance.types?.map((e) => e?.toJson())?.toList(),
      'owners': instance.owners?.map((e) => e?.toJson())?.toList(),
      'integrationId': instance.integrationId,
    };
