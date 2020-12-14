// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    (json['id'] as num)?.toDouble(),
    json['sku'] as String,
    json['itemName'] as String,
    (json['price'] as num)?.toDouble(),
    json['quantityInStock'] as int,
    (json['catalogue'] as List)
        ?.map((e) =>
            e == null ? null : Catalogue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['category'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'itemName': instance.itemName,
      'price': instance.price,
      'quantityInStock': instance.quantityInStock,
      'catalogue': instance.catalogue?.map((e) => e?.toJson())?.toList(),
      'category': instance.category?.map((e) => e?.toJson())?.toList(),
    };
