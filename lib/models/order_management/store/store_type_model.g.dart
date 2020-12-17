// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTypeModel _$StoreTypeModelFromJson(Map<String, dynamic> json) {
  return StoreTypeModel(
    id: (json['id'] as num)?.toDouble(),
    type: json['type'] as String,
    storeTypeAssociations: (json['storeTypeAssociations'] as List)
        ?.map((e) => e == null
            ? null
            : StoreTypeAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StoreTypeModelToJson(StoreTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'storeTypeAssociations': instance.storeTypeAssociations,
    };
