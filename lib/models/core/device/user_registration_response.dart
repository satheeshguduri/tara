import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_response.dart';

part 'user_registration_response.g.dart';

@JsonSerializable()
class UserRegistrationResponse {
  String pspIdentifier;
  String splKey;

  UserRegistrationResponse({this.pspIdentifier, this.splKey});

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) => _$UserRegistrationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationResponseToJson(this);
}

@JsonSerializable()
class SplRegistrationResponseEnc{
  CommonResponseBean commonResponse;
  String userRegistrationResponsePayloadEnc;

  SplRegistrationResponseEnc({this.commonResponse,this.userRegistrationResponsePayloadEnc});

  factory SplRegistrationResponseEnc.fromJson(Map<String, dynamic> json) => _$SplRegistrationResponseEncFromJson(json);

  Map<String, dynamic> toJson() => _$SplRegistrationResponseEncToJson(this);


}



