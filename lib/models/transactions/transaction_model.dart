import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  String transactionId;
  FromDataBean fromData;
  ToDataBean toData;
  bool paid;
  String transactionType;
  String subType;
  String status;
  String transactionDate;
  dynamic toType;
  OptionalDataBean optionalData;

  TransactionModel({this.transactionId, this.fromData, this.toData, this.paid, this.transactionType, this.subType, this.status, this.transactionDate, this.toType, this.optionalData});

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}

@JsonSerializable()
class OptionalDataBean {
  DataBean data;

  OptionalDataBean({this.data});

  factory OptionalDataBean.fromJson(Map<String, dynamic> json) => _$OptionalDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OptionalDataBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  String createFirebaseEntry;
  String transactionContext; //"Payment_Request"
  num amount;

  DataBean({this.createFirebaseEntry, this.amount,this.transactionContext});

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

@JsonSerializable()
class ToDataBean {
  String toContactNumber;
  dynamic toAccount;
  String toUserFirebaseId;

  ToDataBean({this.toContactNumber, this.toAccount, this.toUserFirebaseId});

  factory ToDataBean.fromJson(Map<String, dynamic> json) => _$ToDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ToDataBeanToJson(this);
}

@JsonSerializable()
class FromDataBean {
  String fromContactNumber;
  dynamic fromAccount;
  String fromUserFirebaseId;

  FromDataBean({this.fromContactNumber, this.fromAccount, this.fromUserFirebaseId});

  factory FromDataBean.fromJson(Map<String, dynamic> json) => _$FromDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FromDataBeanToJson(this);
}

