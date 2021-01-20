// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_mobile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateMobileRequest _$ValidateMobileRequestFromJson(
    Map<String, dynamic> json) {
  return ValidateMobileRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    validationMobile: json['validationMobile'] as String,
    validationAppName: json['validationAppName'] as String,
  );
}

Map<String, dynamic> _$ValidateMobileRequestToJson(
        ValidateMobileRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'validationMobile': instance.validationMobile,
      'validationAppName': instance.validationAppName,
    };
