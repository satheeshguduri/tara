/*
*  auth_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/base_request.dart';


part 'customer_profile.g.dart';

@JsonSerializable()
class CustomerProfile extends BaseRequest {

   String firstName;
   int id;
   String lastName;
   String mobileNumber;
   String country;
   String dateOfBirth;
   bool isKyc;
   String email;
   String customerType;
   String firebaseId;
   String credential;
   String token;
   dynamic address;


  CustomerProfile({
    this.firstName,
    this.id,
    this.lastName,
    this.mobileNumber,
    this.country,
    this.dateOfBirth,
    this.isKyc,
    this.email,
    this.customerType,
    this.firebaseId,
    this.credential,
    this.token,
    this.address
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) => _$CustomerProfileFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerProfileToJson(this);

}

@JsonSerializable()
class SignUpRequest {
   String mobileNumber;
   String password;
   CustomerProfile customerProfile;

  SignUpRequest({this.mobileNumber, this.password, this.customerProfile});

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}