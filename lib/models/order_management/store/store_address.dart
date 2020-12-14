import 'package:json_annotation/json_annotation.dart';
part 'store_address.g.dart';
@JsonSerializable()
class StoreAddress{
   String dno;
   String streetName;
   String city;
   String country;
   double zipcode;

   StoreAddress(
      this.dno, this.streetName, this.city, this.country, this.zipcode);

  factory StoreAddress.fromJson(Map<String, dynamic> json) => _$StoreAddressFromJson(json);

Map<String, dynamic> toJson() => _$StoreAddressToJson(this);
}