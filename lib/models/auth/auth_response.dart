/*
*  auth_response.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/auth/security_token.dart';

import 'customer_profile.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  CustomerProfile customerProfile;
  SecurityToken securityToken;

  AuthResponse({this.customerProfile, this.securityToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
