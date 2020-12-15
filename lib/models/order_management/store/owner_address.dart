import 'package:json_annotation/json_annotation.dart';
part 'owner_address.g.dart';
@JsonSerializable()
class OwnerAddress{
   String dno;
   String streetName;
   String city;
   String country;
   double zipcode;


   OwnerAddress(
   {this.dno, this.streetName, this.city, this.country, this.zipcode});

  factory OwnerAddress.fromJson(Map<String, dynamic> json) => _$OwnerAddressFromJson(json);

Map<String, dynamic> toJson() => _$OwnerAddressToJson(this);
}