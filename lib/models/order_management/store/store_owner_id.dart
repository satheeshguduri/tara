import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';

part 'store_owner_id.g.dart';
@JsonSerializable(explicitToJson: true)
class StoreOwnerId{
   Store store;
   Owner owner;

   StoreOwnerId({this.store, this.owner});

  factory StoreOwnerId.fromJson(Map<String, dynamic> json) => _$StoreOwnerIdFromJson(json);

Map<String, dynamic> toJson() => _$StoreOwnerIdToJson(this);
}