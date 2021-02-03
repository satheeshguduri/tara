import 'package:json_annotation/json_annotation.dart';

part 'create_card_or_pay_request.g.dart';

@JsonSerializable()
class CreateCardOrPayRequest {
  String register_id;
  String callback_url;
  String return_url;
  bool is_transaction;
  TransactionBean transaction;
  OptionalDataBean optionalData;

  CreateCardOrPayRequest({this.register_id, this.callback_url, this.return_url, this.is_transaction, this.transaction, this.optionalData});

  factory CreateCardOrPayRequest.fromJson(Map<String, dynamic> json) => _$CreateCardOrPayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCardOrPayRequestToJson(this);
}

@JsonSerializable()
class OptionalDataBean {
  String customerId;

  OptionalDataBean({this.customerId});

  factory OptionalDataBean.fromJson(Map<String, dynamic> json) => _$OptionalDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OptionalDataBeanToJson(this);
}

@JsonSerializable()
class TransactionBean {
  num amount;
  String description;

  TransactionBean({this.amount, this.description});

  factory TransactionBean.fromJson(Map<String, dynamic> json) => _$TransactionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionBeanToJson(this);
}

