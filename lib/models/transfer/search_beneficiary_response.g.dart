// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_beneficiary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBeneficiaryResponse _$SearchBeneficiaryResponseFromJson(
    Map<String, dynamic> json) {
  return SearchBeneficiaryResponse(
    transactionId: json['transactionId'] as String,
    success: json['success'] as bool,
    errorCode: json['errorCode'] as String,
    errorReason: json['errorReason'] as String,
    status: json['status'] as String,
    beneDetail: json['beneDetail'] == null
        ? null
        : BeneDetailBean.fromJson(json['beneDetail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchBeneficiaryResponseToJson(
        SearchBeneficiaryResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'beneDetail': instance.beneDetail,
    };

BeneDetailBean _$BeneDetailBeanFromJson(Map<String, dynamic> json) {
  return BeneDetailBean(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    beneId: json['beneId'] as num,
    beneAccountNo: json['beneAccountNo'] as String,
    beneBic: json['beneBic'] as String,
    beneName: json['beneName'] as String,
    beneMobile: json['beneMobile'] as String,
    beneAppName: json['beneAppName'] as String,
    beneType: json['beneType'] as String,
    accountType: json['accountType'] as String,
    crtnTs: json['crtnTs'] as num,
  );
}

Map<String, dynamic> _$BeneDetailBeanToJson(BeneDetailBean instance) =>
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
