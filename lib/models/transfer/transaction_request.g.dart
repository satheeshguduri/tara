// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRequest _$TransactionRequestFromJson(Map<String, dynamic> json) {
  return TransactionRequest(
    custPSPId: json['custPSPId'],
    accessToken: json['accessToken'],
    transactionId: json['transactionId'],
    acquiringSource: json['acquiringSource'],
    merchantId: json['merchantId'],
    requestedLocale: json['requestedLocale'],
    type: _$enumDecodeNullable(_$RequestTypeEnumMap, json['type']),
    payer: json['payer'] == null
        ? null
        : PayeesBean.fromJson(json['payer'] as Map<String, dynamic>),
    payees: (json['payees'] as List)
        ?.map((e) =>
            e == null ? null : PayeesBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    initiatorAccountId: json['initiatorAccountId'] as num,
    remarks: json['remarks'] as String,
    timeTillExpireMins: json['timeTillExpireMins'],
    merchantTxnId: json['merchantTxnId'] as String,
    feeTaxRefId: json['feeTaxRefId'] as String,
  )
    ..userName = json['userName'] as String
    ..bic = json['bic'] as String
    ..cardLast6Digits = json['cardLast6Digits'] as String;
}

Map<String, dynamic> _$TransactionRequestToJson(TransactionRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'userName': instance.userName,
      'bic': instance.bic,
      'cardLast6Digits': instance.cardLast6Digits,
      'type': _$RequestTypeEnumMap[instance.type],
      'payer': instance.payer,
      'payees': instance.payees,
      'initiatorAccountId': instance.initiatorAccountId,
      'remarks': instance.remarks,
      'timeTillExpireMins': instance.timeTillExpireMins,
      'merchantTxnId': instance.merchantTxnId,
      'feeTaxRefId': instance.feeTaxRefId,
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

PayeesBean _$PayeesBeanFromJson(Map<String, dynamic> json) {
  return PayeesBean(
    targetSelfAccountTokenId: json['targetSelfAccountTokenId'],
    beneId: json['beneId'],
    mobileNo: json['mobileNo'] as String,
    appId: json['appId'] as String,
    accountNumber: json['accountNumber'],
    bic: json['bic'] as String,
    amount: json['amount'] as String,
    minAmount: json['minAmount'],
  );
}

Map<String, dynamic> _$PayeesBeanToJson(PayeesBean instance) =>
    <String, dynamic>{
      'targetSelfAccountTokenId': instance.targetSelfAccountTokenId,
      'beneId': instance.beneId,
      'mobileNo': instance.mobileNo,
      'appId': instance.appId,
      'accountNumber': instance.accountNumber,
      'bic': instance.bic,
      'amount': instance.amount,
      'minAmount': instance.minAmount,
    };
