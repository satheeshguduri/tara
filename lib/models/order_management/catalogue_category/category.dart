import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/item/item.dart';

part 'category.g.dart';
@JsonSerializable(explicitToJson: true)
class Category{
 
   double id;
   String name;
   List<Item> items;

   Category({this.id, this.name, this.items});

factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

Map<String, dynamic> toJson() => _$CategoryToJson(this);
}