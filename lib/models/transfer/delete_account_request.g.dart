// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountRequest _$DeleteAccountRequestFromJson(Map<String, dynamic> json) {
  return DeleteAccountRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    accountTokenIds:
        (json['accountTokenIds'] as List)?.map((e) => e as num)?.toList(),
  );
}

Map<String, dynamic> _$DeleteAccountRequestToJson(
        DeleteAccountRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'accountTokenIds': instance.accountTokenIds,
    };
