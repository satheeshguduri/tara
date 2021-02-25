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
    timestamp: json['timestamp'] as int,
    status: json['status'] as String,
    messageType:
        _$enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']),
  );
}

Map<String, dynamic> _$PaymentSuccessToJson(PaymentSuccess instance) =>
    <String, dynamic>{
      'messageType': _$MessageTypeEnumMap[instance.messageType],
      'payerId': instance.payerId,
      'payeeId': instance.payeeId,
      'amount': instance.amount,
      'transactionId': instance.transactionId,
      'timestamp': instance.timestamp,
      'status': instance.status,
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

const _$MessageTypeEnumMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.REQUEST_TRANSFER: 'REQUEST_TRANSFER',
  MessageType.PAYMENT_SUCCESS: 'PAYMENT_SUCCESS',
  MessageType.TRANSFER_SUCCESS: 'TRANSFER_SUCCESS',
  MessageType.ORDER: 'ORDER',
  MessageType.ORDER_CONFIRMATION: 'ORDER_CONFIRMATION',
  MessageType.ORDER_DECLINED: 'ORDER_DECLINED',
  MessageType.TRANSFER: 'TRANSFER',
  MessageType.PAYMENT: 'PAYMENT',
  MessageType.BILL_PAYMENT: 'BILL_PAYMENT',
};
