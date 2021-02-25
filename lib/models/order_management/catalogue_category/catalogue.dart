import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/store/store.dart';
part 'catalogue.g.dart';

@JsonSerializable()
class Catalogue{
  int id;
  String name;
  Store storeId;

  Catalogue({this.id, this.name,this.storeId}); // Store store_id;
  // private List<Item> items;

factory Catalogue.fromJson(Map<String, dynamic> json) => _$CatalogueFromJson(json);

Map<String, dynamic> toJson() => _$CatalogueToJson(this);

}