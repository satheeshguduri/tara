// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel(
    transactionId: json['transactionId'] as String,
    fromData: json['fromData'] == null
        ? null
        : FromDataBean.fromJson(json['fromData'] as Map<String, dynamic>),
    toData: json['toData'] == null
        ? null
        : ToDataBean.fromJson(json['toData'] as Map<String, dynamic>),
    paid: json['paid'] as bool,
    transactionType: json['transactionType'] as String,
    subType: json['subType'] as String,
    status: json['status'] as String,
    transactionDate: json['transactionDate'] as String,
    toType: json['toType'],
    optionalData: json['optionalData'] == null
        ? null
        : OptionalDataBean.fromJson(
            json['optionalData'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'fromData': instance.fromData,
      'toData': instance.toData,
      'paid': instance.paid,
      'transactionType': instance.transactionType,
      'subType': instance.subType,
      'status': instance.status,
      'transactionDate': instance.transactionDate,
      'toType': instance.toType,
      'optionalData': instance.optionalData,
    };

OptionalDataBean _$OptionalDataBeanFromJson(Map<String, dynamic> json) {
  return OptionalDataBean(
    data: json['data'] == null
        ? null
        : DataBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OptionalDataBeanToJson(OptionalDataBean instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) {
  return DataBean(
    createFirebaseEntry: json['createFirebaseEntry'] as String,
    amount: json['amount'] as num,
    transactionContext: json['transactionContext'] as String,
  );
}

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'createFirebaseEntry': instance.createFirebaseEntry,
      'transactionContext': instance.transactionContext,
      'amount': instance.amount,
    };

ToDataBean _$ToDataBeanFromJson(Map<String, dynamic> json) {
  return ToDataBean(
    toContactNumber: json['toContactNumber'] as String,
    toAccount: json['toAccount'],
    toUserFirebaseId: json['toUserFirebaseId'] as String,
  );
}

Map<String, dynamic> _$ToDataBeanToJson(ToDataBean instance) =>
    <String, dynamic>{
      'toContactNumber': instance.toContactNumber,
      'toAccount': instance.toAccount,
      'toUserFirebaseId': instance.toUserFirebaseId,
    };

FromDataBean _$FromDataBeanFromJson(Map<String, dynamic> json) {
  return FromDataBean(
    fromContactNumber: json['fromContactNumber'] as String,
    fromAccount: json['fromAccount'],
    fromUserFirebaseId: json['fromUserFirebaseId'] as String,
  );
}

Map<String, dynamic> _$FromDataBeanToJson(FromDataBean instance) =>
    <String, dynamic>{
      'fromContactNumber': instance.fromContactNumber,
      'fromAccount': instance.fromAccount,
      'fromUserFirebaseId': instance.fromUserFirebaseId,
    };
