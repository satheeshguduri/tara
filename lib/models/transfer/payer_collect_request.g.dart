// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payer_collect_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayerCollectRequest _$PayerCollectRequestFromJson(Map<String, dynamic> json) {
  return PayerCollectRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    approvedAmount: json['approvedAmount'] as String,
    approved: json['approved'] as bool,
    accountTokenId: json['accountTokenId'] as num,
    merchantTxnId: json['merchantTxnId'] as String,
  );
}

Map<String, dynamic> _$PayerCollectRequestToJson(
        PayerCollectRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'approvedAmount': instance.approvedAmount,
      'approved': instance.approved,
      'accountTokenId': instance.accountTokenId,
      'merchantTxnId': instance.merchantTxnId,
    };
