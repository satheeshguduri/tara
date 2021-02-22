
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {


  String transactionId;
  String fromContactNumber;
  String toContactNumber;
  String fromAccount;
  String toAccount;
  bool paid;
  String transactionType;
  String subType;
  String status;
  DateTime transactionDate;
  String toType;


  PaymentResponse({
    this.transactionId,
    this.fromContactNumber,
    this.toContactNumber,
    this.fromAccount,
    this.toAccount,
    this.paid,
    this.transactionType,
    this.subType,
    this.status,
    this.transactionDate,
    this.toType,
  });



  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);




}
