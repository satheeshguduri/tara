// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_type_association.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTypeAssociation _$StoreTypeAssociationFromJson(Map<String, dynamic> json) {
  return StoreTypeAssociation(
    json['storeTypeId'] == null
        ? null
        : StoreTypeId.fromJson(json['storeTypeId'] as Map<String, dynamic>),
    json['dateOfAssociation'] == null
        ? null
        : DateTime.parse(json['dateOfAssociation'] as String),
    json['active'] as bool,
  );
}

Map<String, dynamic> _$StoreTypeAssociationToJson(
        StoreTypeAssociation instance) =>
    <String, dynamic>{
      'storeTypeId': instance.storeTypeId?.toJson(),
      'dateOfAssociation': instance.dateOfAssociation?.toIso8601String(),
      'active': instance.active,
    };
