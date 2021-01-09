// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBaseResponse _$TransferBaseResponseFromJson(Map<String, dynamic> json) {
  return TransferBaseResponse(
    transactionId: json['transactionId'] as String,
    success: json['success'] as bool,
    errorCode: json['errorCode'] as String,
    errorReason: json['errorReason'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$TransferBaseResponseToJson(
        TransferBaseResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
    };
