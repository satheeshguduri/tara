// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBeneficiaryRequest _$AddBeneficiaryRequestFromJson(
    Map<String, dynamic> json) {
  return AddBeneficiaryRequest(
    custPSPId: json['custPSPId'],
    accessToken: json['accessToken'],
    transactionId: json['transactionId'],
    acquiringSource: json['acquiringSource'],
    merchantId: json['merchantId'],
    requestedLocale: json['requestedLocale'],
    beneId: json['beneId'],
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
