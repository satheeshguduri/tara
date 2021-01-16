import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

import 'constants/request_type.dart';

part 'transaction_history_response.g.dart';

@JsonSerializable()
class TransactionHistoryResponse {
  List<TransactionListBean> transactionList;
  num pageNo;
  num pageSize;

  TransactionHistoryResponse({this.transactionList, this.pageNo, this.pageSize});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) => _$TransactionHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryResponseToJson(this);
}

@JsonSerializable()
class TransactionListBean {
  String transactionId;
  bool success;
  String errorCode;
  String errorReason;
  String status;
  RequestType txnType;
  bool selfInitiated;
  bool waitingForApproval;
  String selfAccountNumber;
  String selfBIC;
  String selfMobileNumber;
  String counterpartName;
  String counterpartMobile;
  String counterpartAppName;
  dynamic counterpartAccountNumber;
  dynamic counterpartBIC;
  String counterpartContactMobile;
  bool counterpartSelf;
  String amount;
  dynamic minimumAmount;
  String remarks;
  dynamic expiringAt;
  num timestamp;
  String month;

  TransactionListBean({this.transactionId, this.success, this.errorCode, this.errorReason, this.status, this.txnType, this.selfInitiated, this.waitingForApproval, this.selfAccountNumber, this.selfBIC, this.selfMobileNumber, this.counterpartName, this.counterpartMobile, this.counterpartAppName, this.counterpartAccountNumber, this.counterpartBIC, this.counterpartContactMobile, this.counterpartSelf, this.amount, this.minimumAmount, this.remarks, this.expiringAt, this.timestamp,this.month});

  factory TransactionListBean.fromJson(Map<String, dynamic> json) => _$TransactionListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionListBeanToJson(this);
}

