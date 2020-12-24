import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/bills/balance_data_response.dart';
import 'package:tara_app/models/bills/base_bill_response.dart';

part 'bill_products_response.g.dart';

@JsonSerializable()
class BillProductsResponse extends BaseBillResponse{

  List<BillProductDataBean> data;

  BillProductsResponse({responseCode, success, message, this.data});

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
