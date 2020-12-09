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

  final String firstName;
  final String id;
  final String lastName;
  final String mobileNumber;
  final String country;
  final String dateOfBirth;
  final bool isKyc;
  final String email;
  final String customerType;
  final String firebaseId;
  final String credential;
  final String token;
  final String address;


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
  final String mobileNumber;
  final String password;
  final CustomerProfile data;

  SignUpRequest({this.mobileNumber, this.password, this.data});

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}