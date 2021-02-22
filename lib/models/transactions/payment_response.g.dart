// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) {
  return PaymentResponse(
    transactionId: json['transactionId'] as String,
    fromContactNumber: json['fromContactNumber'] as String,
    toContactNumber: json['toContactNumber'] as String,
    fromAccount: json['fromAccount'] as String,
    toAccount: json['toAccount'] as String,
    paid: json['paid'] as bool,
    transactionType: json['transactionType'] as String,
    subType: json['subType'] as String,
    status: json['status'] as String,
    transactionDate: json['transactionDate'] == null
        ? null
        : DateTime.parse(json['transactionDate'] as String),
    toType: json['toType'] as String,
  );
}

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'fromContactNumber': instance.fromContactNumber,
      'toContactNumber': instance.toContactNumber,
      'fromAccount': instance.fromAccount,
      'toAccount': instance.toAccount,
      'paid': instance.paid,
      'transactionType': instance.transactionType,
      'subType': instance.subType,
      'status': instance.status,
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'toType': instance.toType,
    };
