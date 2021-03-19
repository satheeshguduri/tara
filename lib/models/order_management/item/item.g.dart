// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    description: json['description'] as String,
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
      'description': instance.description,
      'quantityInStock': instance.quantityInStock,
      'catalogue': instance.catalogue?.map((e) => e?.toJson())?.toList(),
      'category': instance.category?.map((e) => e?.toJson())?.toList(),
      'orderQuantity': instance.orderQuantity,
      'favouriteItem': instance.favouriteItem,
    };

AddProductsResponse _$AddProductsResponseFromJson(Map<String, dynamic> json) {
  return AddProductsResponse(
    json['message'] as String,
    (json['itemList'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddProductsResponseToJson(
        AddProductsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'itemList': instance.itemList,
    };

GetProductResponse _$GetProductResponseFromJson(Map<String, dynamic> json) {
  return GetProductResponse(
    (json['content'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['last'] as bool,
  );
}

Map<String, dynamic> _$GetProductResponseToJson(GetProductResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
    };

UpdateProductResponse _$UpdateProductResponseFromJson(
    Map<String, dynamic> json) {
  return UpdateProductResponse(
    json['message'] as String,
  );
}

Map<String, dynamic> _$UpdateProductResponseToJson(
        UpdateProductResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

DeleteProductResponse _$DeleteProductResponseFromJson(
    Map<String, dynamic> json) {
  return DeleteProductResponse(
    json['message'] as String,
  );
}

Map<String, dynamic> _$DeleteProductResponseToJson(
        DeleteProductResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
