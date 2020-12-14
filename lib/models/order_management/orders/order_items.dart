import 'package:json_annotation/json_annotation.dart';
part 'order_items.g.dart';
@JsonSerializable()
class OrderItems{


   String name;
   int quantity;
   double price;
   double currency;

   OrderItems(this.name, this.quantity, this.price, this.currency);



factory OrderItems.fromJson(Map<String, dynamic> json) => _$OrderItemsFromJson(json);

Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}