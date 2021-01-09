// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_mobile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateMobileResponse _$ValidateMobileResponseFromJson(
    Map<String, dynamic> json) {
  return ValidateMobileResponse(
    transactionId: json['transactionId'],
    success: json['success'] as bool,
    errorCode: json['errorCode'] as String,
    errorReason: json['errorReason'] as String,
    status: json['status'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ValidateMobileResponseToJson(
        ValidateMobileResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'name': instance.name,
    };
