import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';

part 'transaction_request.g.dart';

@JsonSerializable()
class TransactionRequest extends CommonRegistrationRequest{
  RequestType type;
  PayeesBean payer;
  List<PayeesBean> payees;
  num initiatorAccountId;
  String remarks;
  dynamic timeTillExpireMins;
  String merchantTxnId;
  String feeTaxRefId;

  TransactionRequest({custPSPId, accessToken, transactionId, acquiringSource, merchantId, requestedLocale, this.type, this.payer, this.payees, this.initiatorAccountId, this.remarks, this.timeTillExpireMins, this.merchantTxnId, this.feeTaxRefId});

  factory TransactionRequest.fromJson(Map<String, dynamic> json) => _$TransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRequestToJson(this);
}

@JsonSerializable()
class PayeesBean {
  dynamic targetSelfAccountTokenId;
  dynamic beneId;
  String mobileNo;
  String appId;
  dynamic accountNumber;
  String bic;
  String amount;
  dynamic minAmount;

  PayeesBean({this.targetSelfAccountTokenId, this.beneId, this.mobileNo, this.appId, this.accountNumber, this.bic, this.amount, this.minAmount});

  factory PayeesBean.fromJson(Map<String, dynamic> json) => _$PayeesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PayeesBeanToJson(this);
}

