import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/store/store_owner_id.dart';

part 'store_owner_association.g.dart';
@JsonSerializable(explicitToJson: true)
class StoreOwnerAssociation{
   StoreOwnerId storeOwnerId;
   DateTime dateOfAssociation;
   bool active;

   StoreOwnerAssociation({this.storeOwnerId, this.dateOfAssociation, this.active});

  factory StoreOwnerAssociation.fromJson(Map<String, dynamic> json) => _$StoreOwnerAssociationFromJson(json);

Map<String, dynamic> toJson() => _$StoreOwnerAssociationToJson(this);
}