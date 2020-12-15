import 'package:json_annotation/json_annotation.dart';
part 'jsonborder_extra.g.dart';
@JsonSerializable()
class JsonbOrderExtra{

   String customer_commid;
   String merchant_commid;
   bool interpret;


   JsonbOrderExtra({this.customer_commid, this.merchant_commid, this.interpret});

  factory JsonbOrderExtra.fromJson(Map<String, dynamic> json) => _$JsonbOrderExtraFromJson(json);

Map<String, dynamic> toJson() => _$JsonbOrderExtraToJson(this);


}