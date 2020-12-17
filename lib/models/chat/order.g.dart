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
    orderStatus: json['orderStatus'] as String,
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
      'orderStatus': instance.orderStatus,
    };
