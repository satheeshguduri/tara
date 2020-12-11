// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) {
  return TransferRequest(
    payeeId: json['payeeId'] as String,
    payerId: json['payerId'] as String,
    amount: json['amount'] as num,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$TransferRequestToJson(TransferRequest instance) =>
    <String, dynamic>{
      'payeeId': instance.payeeId,
      'payerId': instance.payerId,
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
      'status': instance.status,
    };
