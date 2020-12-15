// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catalogue _$CatalogueFromJson(Map<String, dynamic> json) {
  return Catalogue(
    id: (json['id'] as num)?.toDouble(),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CatalogueToJson(Catalogue instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
