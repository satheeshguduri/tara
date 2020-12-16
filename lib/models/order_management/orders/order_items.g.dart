// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) {
  return OrderItems(
    name: json['name'] as String,
    quantity: json['quantity'] as int,
    price: (json['price'] as num)?.toDouble(),
    currency: (json['currency'] as num)?.toDouble(),
    unit: json['unit'] as String,
  );
}

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'currency': instance.currency,
      'unit': instance.unit,
    };
