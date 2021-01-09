// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryResponse _$TransactionHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return TransactionHistoryResponse(
    transactionList: (json['transactionList'] as List)
        ?.map((e) => e == null
            ? null
            : TransactionListBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pageNo: json['pageNo'] as num,
    pageSize: json['pageSize'] as num,
  );
}

Map<String, dynamic> _$TransactionHistoryResponseToJson(
        TransactionHistoryResponse instance) =>
    <String, dynamic>{
      'transactionList': instance.transactionList,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };

TransactionListBean _$TransactionListBeanFromJson(Map<String, dynamic> json) {
  return TransactionListBean(
    transactionId: json['transactionId'] as String,
    success: json['success'] as bool,
    errorCode: json['errorCode'] as String,
    errorReason: json['errorReason'] as String,
    status: json['status'] as String,
    txnType: json['txnType'] as String,
    selfInitiated: json['selfInitiated'] as bool,
    waitingForApproval: json['waitingForApproval'] as bool,
    selfAccountNumber: json['selfAccountNumber'] as String,
    selfBIC: json['selfBIC'] as String,
    selfMobileNumber: json['selfMobileNumber'] as String,
    counterpartName: json['counterpartName'] as String,
    counterpartMobile: json['counterpartMobile'] as String,
    counterpartAppName: json['counterpartAppName'] as String,
    counterpartAccountNumber: json['counterpartAccountNumber'],
    counterpartBIC: json['counterpartBIC'],
    counterpartContactMobile: json['counterpartContactMobile'] as String,
    counterpartSelf: json['counterpartSelf'] as bool,
    amount: json['amount'] as String,
    minimumAmount: json['minimumAmount'],
    remarks: json['remarks'] as String,
    expiringAt: json['expiringAt'],
    timestamp: json['timestamp'] as num,
  );
}

Map<String, dynamic> _$TransactionListBeanToJson(
        TransactionListBean instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'txnType': instance.txnType,
      'selfInitiated': instance.selfInitiated,
      'waitingForApproval': instance.waitingForApproval,
      'selfAccountNumber': instance.selfAccountNumber,
      'selfBIC': instance.selfBIC,
      'selfMobileNumber': instance.selfMobileNumber,
      'counterpartName': instance.counterpartName,
      'counterpartMobile': instance.counterpartMobile,
      'counterpartAppName': instance.counterpartAppName,
      'counterpartAccountNumber': instance.counterpartAccountNumber,
      'counterpartBIC': instance.counterpartBIC,
      'counterpartContactMobile': instance.counterpartContactMobile,
      'counterpartSelf': instance.counterpartSelf,
      'amount': instance.amount,
      'minimumAmount': instance.minimumAmount,
      'remarks': instance.remarks,
      'expiringAt': instance.expiringAt,
      'timestamp': instance.timestamp,
    };
