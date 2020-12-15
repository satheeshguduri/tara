import 'package:json_annotation/json_annotation.dart';
part 'jsonb_customer_address.g.dart';
@JsonSerializable()
class JsonbCustomerAddress{
   String addressLine;
   String street;
   String district;
   String state;
   String country;
   String pinCode;

   JsonbCustomerAddress({this.addressLine, this.street, this.district, this.state,
       this.country, this.pinCode});

factory JsonbCustomerAddress.fromJson(Map<String, dynamic> json) => _$JsonbCustomerAddressFromJson(json);

Map<String, dynamic> toJson() => _$JsonbCustomerAddressToJson(this);
}