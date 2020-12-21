// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) {
  return TransferRequest(
    payeeId: json['payeeId'] as String,
    payerId: json['payerId'] as String,
    amount: json['amount'] as num,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    status: json['status'] as String,
    messageType:
        _$enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']),
  );
}

Map<String, dynamic> _$TransferRequestToJson(TransferRequest instance) =>
    <String, dynamic>{
      'messageType': _$MessageTypeEnumMap[instance.messageType],
      'payeeId': instance.payeeId,
      'payerId': instance.payerId,
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
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
};
