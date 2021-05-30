import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/item/item.dart';

part 'category.g.dart';
@JsonSerializable(explicitToJson: true)
class Category{
 
   int id;
   String name;
   String imageUrl;
   List<Iteorm> items;

   Category({this.id, this.name, this.items,this.imageUrl});

factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

Map<String, dynamic> toJson() => _$CategoryToJson(this);
}