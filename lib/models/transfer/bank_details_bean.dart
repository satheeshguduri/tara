import 'package:json_annotation/json_annotation.dart';

part 'bank_details_bean.g.dart';

@JsonSerializable()
class BankDetailsBean {
  String bic;
  String name;
  bool active;
  bool isRefUrl;

  BankDetailsBean({this.bic, this.name, this.active, this.isRefUrl});

  factory BankDetailsBean.fromJson(Map<String, dynamic> json) => _$BankDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsBeanToJson(this);
}


