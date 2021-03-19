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
   String description;
   int quantityInStock;
   List<Catalogue> catalogue;
   List<Category> category;
   @JsonKey(defaultValue: 0)
   num orderQuantity;
   @JsonKey(defaultValue:false)
   bool favouriteItem;

  Item({
    this.id,
    this.description,
    this.sku,
    this.itemName,
    this.price,
    this.quantityInStock,
    this.catalogue,
    this.category,
    this.orderQuantity,
    this.favouriteItem,
  });

factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class AddProductsResponse {
  final String message;
  final List<Item> itemList;

  AddProductsResponse(this.message, this.itemList);

  factory AddProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$AddProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductsResponseToJson(this);
}

@JsonSerializable()
class GetProductResponse {
  final List<Item> content;
  bool last;

  GetProductResponse(this.content, this.last);

  factory GetProductResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductResponseToJson(this);
}

@JsonSerializable()
class UpdateProductResponse {
  final String message;

  UpdateProductResponse(this.message);

  factory UpdateProductResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProductResponseToJson(this);
}

@JsonSerializable()
class DeleteProductResponse {
  final String message;

  DeleteProductResponse(this.message);

  factory DeleteProductResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteProductResponseToJson(this);
}
