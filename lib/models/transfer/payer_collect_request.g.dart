// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payer_collect_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayerCollectRequest _$PayerCollectRequestFromJson(Map<String, dynamic> json) {
  return PayerCollectRequest(
    custPSPId: json['custPSPId'],
    accessToken: json['accessToken'],
    transactionId: json['transactionId'],
    acquiringSource: json['acquiringSource'],
    merchantId: json['merchantId'],
    requestedLocale: json['requestedLocale'],
    approvedAmount: json['approvedAmount'] as String,
    approved: json['approved'] as bool,
    accountTokenId: json['accountTokenId'] as num,
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
    };
