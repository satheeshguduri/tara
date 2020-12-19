// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    type: json['type'] as String,
    orderId: json['orderId'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : OrderItems.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    total: json['total'] as num,
    customerId: json['customerId'] as String,
    merchantId: json['merchantId'] as String,
    timestamp: json['timestamp'] as int,
    transactionId: json['transactionId'] as String,
    orderStatus: _$enumDecodeNullable(_$StatusesEnumMap, json['orderStatus']),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'type': instance.type,
      'orderId': instance.orderId,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'total': instance.total,
      'customerId': instance.customerId,
      'merchantId': instance.merchantId,
      'timestamp': instance.timestamp,
      'transactionId': instance.transactionId,
      'orderStatus': _$StatusesEnumMap[instance.orderStatus],
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
