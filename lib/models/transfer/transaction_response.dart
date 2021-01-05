import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse {
  String transactionId;
  bool success;
  dynamic errorCode;
  dynamic errorReason;
  String status; //C, P
  dynamic bic;
  String merchantTxnId;
  String feeTaxRefId;
  bool awaitingConfirmation;
  dynamic fee;
  dynamic tax;
  dynamic finalAmount;
  dynamic listPayeeStatus;


  TransactionResponse({
      this.transactionId,
      this.success,
      this.errorCode,
      this.errorReason,
      this.status,
      this.bic,
      this.merchantTxnId,
      this.feeTaxRefId,
      this.awaitingConfirmation,
      this.fee,
      this.tax,
      this.finalAmount,
      this.listPayeeStatus});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}

