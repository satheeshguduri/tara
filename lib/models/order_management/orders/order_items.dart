import 'package:json_annotation/json_annotation.dart';
part 'order_items.g.dart';
@JsonSerializable(explicitToJson: true)
class OrderItems{


   String name;
   int quantity;
   double price;
   String currency;
   String metric;

   OrderItems({this.name, this.quantity, this.price, this.currency, this.metric});


factory OrderItems.fromJson(Map<dynamic, dynamic> json) => _$OrderItemsFromJson(json);

Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}