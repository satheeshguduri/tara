// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
    name: json['name'] as String,
    address: json['address'] == null
        ? null
        : OwnerAddress.fromJson(json['address'] as Map<String, dynamic>),
    kycStatus: json['kycStatus'] as bool,
    types: (json['types'] as List)
        ?.map((e) => e == null
            ? null
            : StoreTypeAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    owners: (json['owners'] as List)
        ?.map((e) => e == null
            ? null
            : StoreOwnerAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    integrationId: json['integrationId'] as int,
  );
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address?.toJson(),
      'kycStatus': instance.kycStatus,
      'types': instance.types?.map((e) => e?.toJson())?.toList(),
      'owners': instance.owners?.map((e) => e?.toJson())?.toList(),
      'integrationId': instance.integrationId,
    };
