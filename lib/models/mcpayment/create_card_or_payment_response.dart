import 'package:json_annotation/json_annotation.dart';

part 'create_card_or_payment_response.g.dart';

@JsonSerializable()
class CreateCardOrPaymentResponse {
  bool error;
  DataBean data;

  CreateCardOrPaymentResponse({this.error, this.data});

  factory CreateCardOrPaymentResponse.fromJson(Map<String, dynamic> json) => _$CreateCardOrPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCardOrPaymentResponseToJson(this);
}

@JsonSerializable()
class DataBean {
  String seamless_url;
  String expired_date;

  DataBean({this.seamless_url, this.expired_date});

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

