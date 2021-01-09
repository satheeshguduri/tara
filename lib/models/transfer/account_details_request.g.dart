// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsRequest _$AccountDetailsRequestFromJson(
    Map<String, dynamic> json) {
  return AccountDetailsRequest(
    custPSPId: json['custPSPId'],
    accessToken: json['accessToken'],
    transactionId: json['transactionId'],
    acquiringSource: json['acquiringSource'],
    merchantId: json['merchantId'],
    requestedLocale: json['requestedLocale'],
    bic: json['bic'] as String,
    cardLast6Digits: json['cardLast6Digits'] as String,
  );
}

Map<String, dynamic> _$AccountDetailsRequestToJson(
        AccountDetailsRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'bic': instance.bic,
      'cardLast6Digits': instance.cardLast6Digits,
    };
