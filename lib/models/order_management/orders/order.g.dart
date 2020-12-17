// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: json['orderId'] as String,
    storeId: json['storeId'] == null
        ? null
        : Store.fromJson(json['storeId'] as Map<String, dynamic>),
    catalogueId: json['catalogueId'] == null
        ? null
        : Catalogue.fromJson(json['catalogueId'] as Map<String, dynamic>),
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : OrderItems.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    customerId: json['customerId'] as int,
    deliveryAddress: (json['deliveryAddress'] as List)
        ?.map((e) =>
            e == null ? null : OrderAddress.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: _$enumDecodeNullable(_$StatusesEnumMap, json['status']),
    price: (json['price'] as num)?.toDouble(),
    deliveryDate: json['deliveryDate'] == null
        ? null
        : DateTime.parse(json['deliveryDate'] as String),
    orderDate: json['orderDate'] == null
        ? null
        : DateTime.parse(json['orderDate'] as String),
    orderType: _$enumDecodeNullable(_$OrderTypesEnumMap, json['orderType']),
    transactionId: json['transactionId'] as String,
    merchantId: json['merchantId'] as String,
    order_extra: json['order_extra'] == null
        ? null
        : JsonbOrderExtra.fromJson(json['order_extra'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'storeId': instance.storeId?.toJson(),
      'catalogueId': instance.catalogueId?.toJson(),
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'customerId': instance.customerId,
      'deliveryAddress':
          instance.deliveryAddress?.map((e) => e?.toJson())?.toList(),
      'status': _$StatusesEnumMap[instance.status],
      'price': instance.price,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'orderDate': instance.orderDate?.toIso8601String(),
      'orderType': _$OrderTypesEnumMap[instance.orderType],
      'transactionId': instance.transactionId,
      'merchantId': instance.merchantId,
      'order_extra': instance.order_extra?.toJson(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StatusesEnumMap = {
  Statuses.PENDING: 'PENDING',
  Statuses.ACCEPTED: 'ACCEPTED',
  Statuses.REJECTED: 'REJECTED',
  Statuses.CANCELLED: 'CANCELLED',
  Statuses.PAID: 'PAID',
  Statuses.UNKNOWN: 'UNKNOWN',
  Statuses.IN_TRANSIT: 'IN_TRANSIT',
  Statuses.DELIVERED: 'DELIVERED',
  Statuses.PAYMENT_FAILED: 'PAYMENT_FAILED',
  Statuses.ORDER_PAYMENT_DECLINED: 'ORDER_PAYMENT_DECLINED',
};

const _$OrderTypesEnumMap = {
  OrderTypes.CATALOGUE_BASED: 'CATALOGUE_BASED',
  OrderTypes.TEXT_BASED: 'TEXT_BASED',
};
