import 'package:json_annotation/json_annotation.dart';
part 'order_address.g.dart';
@JsonSerializable()
class OrderAddress{

   String dno;
   String streetName;
   String city;
   String country;
   int zipcode;

   OrderAddress(
      this.dno, this.streetName, this.city, this.country, this.zipcode);



factory OrderAddress.fromJson(Map<String, dynamic> json) => _$OrderAddressFromJson(json);

Map<String, dynamic> toJson() => _$OrderAddressToJson(this);
}