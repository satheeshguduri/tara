// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreTransactionRequest _$PreTransactionRequestFromJson(
    Map<String, dynamic> json) {
  return PreTransactionRequest(
    custPSPId: json['custPSPId'],
    accessToken: json['accessToken'],
    transactionId: json['transactionId'],
    acquiringSource: json['acquiringSource'],
    merchantId: json['merchantId'],
    requestedLocale: json['requestedLocale'],
    type: _$enumDecodeNullable(_$RequestTypeEnumMap, json['type']),
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$PreTransactionRequestToJson(
        PreTransactionRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'type': _$RequestTypeEnumMap[instance.type],
      'amount': instance.amount,
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

const _$RequestTypeEnumMap = {
  RequestType.PAY: 'PAY',
  RequestType.COLLECT: 'COLLECT',
};
