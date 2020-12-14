import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/store/store_type_id.dart';

part 'store_type_association.g.dart';
@JsonSerializable(explicitToJson: true)
class StoreTypeAssociation{
   StoreTypeId storeTypeId;
   DateTime dateOfAssociation;
   bool active;

   StoreTypeAssociation(this.storeTypeId, this.dateOfAssociation, this.active);

  factory StoreTypeAssociation.fromJson(Map<String, dynamic> json) => _$StoreTypeAssociationFromJson(json);

Map<String, dynamic> toJson() => _$StoreTypeAssociationToJson(this);

}