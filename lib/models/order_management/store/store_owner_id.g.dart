// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_owner_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOwnerId _$StoreOwnerIdFromJson(Map<String, dynamic> json) {
  return StoreOwnerId(
    json['store'] == null
        ? null
        : Store.fromJson(json['store'] as Map<String, dynamic>),
    json['owner'] == null
        ? null
        : Owner.fromJson(json['owner'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StoreOwnerIdToJson(StoreOwnerId instance) =>
    <String, dynamic>{
      'store': instance.store?.toJson(),
      'owner': instance.owner?.toJson(),
    };
