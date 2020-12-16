import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/order_status.dart';
import 'package:tara_app/models/order_management/store/register_store.dart';
import 'package:tara_app/models/order_management/store/store_address.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_association.dart';

part 'store.g.dart';
@JsonSerializable(explicitToJson: true)
class Store{
   String id;
   String name;
   StoreAddress address;
   String latitude;
   String longitude;
   bool registration_status;
   Status status;
   List<StoreTypeAssociation> types;
   RegisterStore registerStore;
   Owner owner;
   int integrationId;
   List<int> storeTypeId;


   Store({
      this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.registration_status,
      this.status,
      this.types,
      this.registerStore,
      this.owner,
      this.integrationId,this.storeTypeId});

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

Map<String, dynamic> toJson() => _$StoreToJson(this);
}