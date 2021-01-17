// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBeneficiaryRequest _$AddBeneficiaryRequestFromJson(
    Map<String, dynamic> json) {
  return AddBeneficiaryRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    beneId: json['beneId'] as String,
    beneAccountNo: json['beneAccountNo'] as String,
    beneBic: json['beneBic'] as String,
    beneName: json['beneName'] as String,
    beneMobile: json['beneMobile'] as String,
    beneAppName: json['beneAppName'] as String,
    beneType: json['beneType'] as String,
    accountType: json['accountType'] as String,
    crtnTs: json['crtnTs'],
  );
}

Map<String, dynamic> _$AddBeneficiaryRequestToJson(
        AddBeneficiaryRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'beneId': instance.beneId,
      'beneAccountNo': instance.beneAccountNo,
      'beneBic': instance.beneBic,
      'beneName': instance.beneName,
      'beneMobile': instance.beneMobile,
      'beneAppName': instance.beneAppName,
      'beneType': instance.beneType,
      'accountType': instance.accountType,
      'crtnTs': instance.crtnTs,
    };

MapBeneficiaryRequest _$MapBeneficiaryRequestFromJson(
    Map<String, dynamic> json) {
  return MapBeneficiaryRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    accepted: json['accepted'] as bool,
  );
}

Map<String, dynamic> _$MapBeneficiaryRequestToJson(
        MapBeneficiaryRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'accepted': instance.accepted,
    };
