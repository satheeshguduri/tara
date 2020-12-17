
import 'package:json_annotation/json_annotation.dart';
part 'order_extra_data.g.dart';

@JsonSerializable()
class OrderExtraData{

  String customer_commid;
  String merchant_commid;
  bool interpret;


  OrderExtraData({this.customer_commid, this.merchant_commid, this.interpret});

  factory OrderExtraData.fromJson(Map<String, dynamic> json) => _$OrderExtraDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderExtraDataToJson(this);


}