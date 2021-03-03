import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';

part 'item.g.dart';
@JsonSerializable(explicitToJson: true)
class Item{
 
   int id;
   String sku;
   String itemName;
   double price;
   int quantityInStock;
   List<Catalogue> catalogue;
   List<Category> category;
   @JsonKey(defaultValue: 0)
   num orderQuantity;
   @JsonKey(defaultValue:false)
   bool favouriteItem;

   Item({this.id, this.sku, this.itemName, this.price, this.quantityInStock,
       this.catalogue, this.category,this.orderQuantity,this.favouriteItem});

factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

Map<String, dynamic> toJson() => _$ItemToJson(this);
}