// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRequest _$TransactionRequestFromJson(Map<String, dynamic> json) {
  return TransactionRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
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
    refId: json['refId'] as String,
    custRefId: json['custRefId'] as String,
    initiatorAppId: json['initiatorAppId'] as String,
    initiatorMobileNo: json['initiatorMobileNo'] as String,
    refURL: json['refURL'] as String,
    subMerchantName: json['subMerchantName'] as String,
  );
}

Map<String, dynamic> _$TransactionRequestToJson(TransactionRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'type': _$RequestTypeEnumMap[instance.type],
      'payer': instance.payer,
      'payees': instance.payees,
      'initiatorAccountId': instance.initiatorAccountId,
      'remarks': instance.remarks,
      'timeTillExpireMins': instance.timeTillExpireMins,
      'merchantTxnId': instance.merchantTxnId,
      'feeTaxRefId': instance.feeTaxRefId,
      'initiatorMobileNo': instance.initiatorMobileNo,
      'initiatorAppId': instance.initiatorAppId,
      'custRefId': instance.custRefId,
      'subMerchantName': instance.subMerchantName,
      'refId': instance.refId,
      'refURL': instance.refURL,
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
  RequestType.CHAT: 'CHAT',
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
