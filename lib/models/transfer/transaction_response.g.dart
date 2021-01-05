// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) {
  return TransactionResponse(
    transactionId: json['transactionId'] as String,
    success: json['success'] as bool,
    errorCode: json['errorCode'],
    errorReason: json['errorReason'],
    status: json['status'] as String,
    bic: json['bic'],
    merchantTxnId: json['merchantTxnId'] as String,
    feeTaxRefId: json['feeTaxRefId'] as String,
    awaitingConfirmation: json['awaitingConfirmation'] as bool,
    fee: json['fee'],
    tax: json['tax'],
    finalAmount: json['finalAmount'],
    listPayeeStatus: json['listPayeeStatus'],
  );
}

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'bic': instance.bic,
      'merchantTxnId': instance.merchantTxnId,
      'feeTaxRefId': instance.feeTaxRefId,
      'awaitingConfirmation': instance.awaitingConfirmation,
      'fee': instance.fee,
      'tax': instance.tax,
      'finalAmount': instance.finalAmount,
      'listPayeeStatus': instance.listPayeeStatus,
    };
