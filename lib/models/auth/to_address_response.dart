
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/auth/customer_profile.dart';




part 'to_address_response.g.dart';


@JsonSerializable()
class ToAddressResponse {

  final num id;
  final String mobileNumber;
  final CustomerProfile customerProfile;


  ToAddressResponse({this.id,this.mobileNumber,this.customerProfile});

  factory ToAddressResponse.fromJson(Map<String, dynamic> json) => _$ToAddressResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ToAddressResponseToJson(this);

}
