// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_owner_association.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOwnerAssociation _$StoreOwnerAssociationFromJson(
    Map<String, dynamic> json) {
  return StoreOwnerAssociation(
    storeOwnerId: json['storeOwnerId'] == null
        ? null
        : StoreOwnerId.fromJson(json['storeOwnerId'] as Map<String, dynamic>),
    dateOfAssociation: json['dateOfAssociation'] == null
        ? null
        : DateTime.parse(json['dateOfAssociation'] as String),
    active: json['active'] as bool,
  );
}

Map<String, dynamic> _$StoreOwnerAssociationToJson(
        StoreOwnerAssociation instance) =>
    <String, dynamic>{
      'storeOwnerId': instance.storeOwnerId?.toJson(),
      'dateOfAssociation': instance.dateOfAssociation?.toIso8601String(),
      'active': instance.active,
    };
