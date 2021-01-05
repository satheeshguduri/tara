// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackTransactionRequest _$TrackTransactionRequestFromJson(
    Map<String, dynamic> json) {
  return TrackTransactionRequest(
    custPSPId: json['custPSPId'],
    accessToken: json['accessToken'],
    transactionId: json['transactionId'],
    acquiringSource: json['acquiringSource'],
    merchantId: json['merchantId'],
    requestedLocale: json['requestedLocale'],
    merchantTxnId: json['merchantTxnId'],
    waitForCompletion: json['waitForCompletion'] as bool,
  )
    ..userName = json['userName'] as String
    ..bic = json['bic'] as String
    ..cardLast6Digits = json['cardLast6Digits'] as String;
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
      'userName': instance.userName,
      'bic': instance.bic,
      'cardLast6Digits': instance.cardLast6Digits,
      'merchantTxnId': instance.merchantTxnId,
      'waitForCompletion': instance.waitForCompletion,
    };
