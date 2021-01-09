// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_beneficiary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBeneficiaryResponse _$AddBeneficiaryResponseFromJson(
    Map<String, dynamic> json) {
  return AddBeneficiaryResponse(
    transactionId: json['transactionId'] as String,
    success: json['success'] as bool,
    errorCode: json['errorCode'],
    errorReason: json['errorReason'],
    status: json['status'] as String,
    beneAccountNo: json['beneAccountNo'] as String,
    beneBic: json['beneBic'] as String,
    beneName: json['beneName'] as String,
    beneMobile: json['beneMobile'] as String,
    beneAppId: json['beneAppId'] as String,
    accountType: json['accountType'] as String,
    beneType: json['beneType'] as String,
  );
}

Map<String, dynamic> _$AddBeneficiaryResponseToJson(
        AddBeneficiaryResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'beneAccountNo': instance.beneAccountNo,
      'beneBic': instance.beneBic,
      'beneName': instance.beneName,
      'beneMobile': instance.beneMobile,
      'beneAppId': instance.beneAppId,
      'accountType': instance.accountType,
      'beneType': instance.beneType,
    };
