// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    type: json['type'] as String,
    orderId: json['orderId'] as String,
    items: (json['items'] as List)?.map((e) => e as String)?.toList(),
    total: json['total'] as num,
    customerId: json['customerId'] as String,
    merchantId: json['merchantId'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    transactionId: json['transactionId'] as String,
    orderStatus: json['orderStatus'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'type': instance.type,
      'orderId': instance.orderId,
      'items': instance.items,
      'total': instance.total,
      'customerId': instance.customerId,
      'merchantId': instance.merchantId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'transactionId': instance.transactionId,
      'orderStatus': instance.orderStatus,
    };
