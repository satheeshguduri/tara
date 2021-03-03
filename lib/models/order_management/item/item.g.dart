// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    sku: json['sku'] as String,
    itemName: json['itemName'] as String,
    price: (json['price'] as num)?.toDouble(),
    quantityInStock: json['quantityInStock'] as int,
    catalogue: (json['catalogue'] as List)
        ?.map((e) =>
            e == null ? null : Catalogue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    category: (json['category'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    orderQuantity: json['orderQuantity'] as num ?? 0,
    favouriteItem: json['favouriteItem'] as bool ?? false,
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
      'orderQuantity': instance.orderQuantity,
      'favouriteItem': instance.favouriteItem,
    };
