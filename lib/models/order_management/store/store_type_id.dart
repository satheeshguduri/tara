import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_type.dart';

part 'store_type_id.g.dart';
@JsonSerializable(explicitToJson: true)
class StoreTypeId{
   Store store;
   StoreTypes storeType;

   StoreTypeId({this.store, this.storeType});

  factory StoreTypeId.fromJson(Map<String, dynamic> json) => _$StoreTypeIdFromJson(json);

Map<String, dynamic> toJson() => _$StoreTypeIdToJson(this);
}