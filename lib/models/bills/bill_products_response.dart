import 'package:json_annotation/json_annotation.dart';

part 'bill_products_response.g.dart';

@JsonSerializable()
class BillProductsResponse {
  num responseCode;
  bool success;
  MessageBean message;
  List<BillProductDataBean> data;

  BillProductsResponse({this.responseCode, this.success, this.message, this.data});

  factory BillProductsResponse.fromJson(Map<String, dynamic> json) => _$BillProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BillProductsResponseToJson(this);
}

@JsonSerializable()
class BillProductDataBean {
  String name;
  String description;
  String code;
  String logo;
  num amount;
  num adminFee;
  String biller;
  String category;
  bool active;
  String type;

  BillProductDataBean({this.name, this.description, this.code, this.logo, this.amount, this.adminFee, this.biller, this.category, this.active, this.type});

  factory BillProductDataBean.fromJson(Map<String, dynamic> json) => _$BillProductDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BillProductDataBeanToJson(this);
}

@JsonSerializable()
class MessageBean {
  @JsonKey(name:"ID")
  String id;
  @JsonKey(name:"EN")
  String en;

  MessageBean({this.id, this.en});

  factory MessageBean.fromJson(Map<String, dynamic> json) => _$MessageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MessageBeanToJson(this);
}

