// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_success.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSuccess _$PaymentSuccessFromJson(Map<String, dynamic> json) {
  return PaymentSuccess(
    payerId: json['payerId'] as String,
    payeeId: json['payeeId'] as String,
    amount: json['amount'] as num,
    transactionId: json['transactionId'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$PaymentSuccessToJson(PaymentSuccess instance) =>
    <String, dynamic>{
      'payerId': instance.payerId,
      'payeeId': instance.payeeId,
      'amount': instance.amount,
      'transactionId': instance.transactionId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'status': instance.status,
    };
