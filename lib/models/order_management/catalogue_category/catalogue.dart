import 'package:json_annotation/json_annotation.dart';
part 'catalogue.g.dart';

@JsonSerializable()
class Catalogue{
  double id;
  String name;

  Catalogue(this.id, this.name); // Store store_id;
  // private List<Item> items;

factory Catalogue.fromJson(Map<String, dynamic> json) => _$CatalogueFromJson(json);

Map<String, dynamic> toJson() => _$CatalogueToJson(this);

}