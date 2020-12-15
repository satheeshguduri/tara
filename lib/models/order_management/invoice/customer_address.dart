import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/invoice/jsonb_customer_address.dart';

part 'customer_address.g.dart';
@JsonSerializable(explicitToJson: true)
class CustomerAddress{
   double id;
   JsonbCustomerAddress address;
  String addressType;

   CustomerAddress({this.id, this.address, this.addressType});


   factory CustomerAddress.fromJson(Map<String, dynamic> json) => _$CustomerAddressFromJson(json);

Map<String, dynamic> toJson() => _$CustomerAddressToJson(this);
}