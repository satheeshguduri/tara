// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackTransactionRequest _$TrackTransactionRequestFromJson(
    Map<String, dynamic> json) {
  return TrackTransactionRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    merchantTxnId: json['merchantTxnId'],
    waitForCompletion: json['waitForCompletion'] as bool,
  );
}

Map<String, dynamic> _$TrackTransactionRequestToJson(
        TrackTransactionRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'merchantTxnId': instance.merchantTxnId,
      'waitForCompletion': instance.waitForCompletion,
    };
