import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/store/owner_address.dart';
import 'package:tara_app/models/order_management/store/store_owner_association.dart';
import 'package:tara_app/models/order_management/store/store_type_association.dart';

part 'store_owner.g.dart';
@JsonSerializable(explicitToJson: true)
class Owner{
   String id;
   String name;
   OwnerAddress address;
   bool kycStatus;
   List<StoreTypeAssociation> types;
   List<StoreOwnerAssociation> owners;
   double integrationId;

   Owner({this.id, this.name, this.address, this.kycStatus, this.types,
      this.owners, this.integrationId});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

Map<String, dynamic> toJson() => _$OwnerToJson(this);



}