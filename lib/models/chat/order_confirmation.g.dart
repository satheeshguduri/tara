// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_confirmation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderConfirmation _$OrderConfirmationFromJson(Map<String, dynamic> json) {
  return OrderConfirmation(
    orderId: json['orderId'] as num,
    status: json['status'] as String,
    delivery: json['delivery'] as String,
    amount: json['amount'] as num,
    deliveryAddress: json['deliveryAddress'] as String,
    customerId: json['customerId'] as String,
    merchantId: json['merchantId'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$OrderConfirmationToJson(OrderConfirmation instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'status': instance.status,
      'delivery': instance.delivery,
      'amount': instance.amount,
      'deliveryAddress': instance.deliveryAddress,
      'customerId': instance.customerId,
      'merchantId': instance.merchantId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
