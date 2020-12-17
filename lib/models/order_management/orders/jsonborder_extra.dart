import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/order_extra_data.dart';
part 'jsonborder_extra.g.dart';

@JsonSerializable(explicitToJson: true)
class JsonbOrderExtra{

   OrderExtraData data;

   JsonbOrderExtra({this.data});

  factory JsonbOrderExtra.fromJson(Map<String, dynamic> json) => _$JsonbOrderExtraFromJson(json);

Map<String, dynamic> toJson() => _$JsonbOrderExtraToJson(this);


}