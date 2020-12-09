/*
*  auth_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import '../core/base_request.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest extends BaseRequest {

  final String mobileNumber;
  final String password;
  final String otp;


  AuthRequest({this.mobileNumber, this.password, this.otp});

  factory AuthRequest.fromJson(Map<String, dynamic> json) => _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);

}

@JsonSerializable()
class AuthRequestWithData {

  final AuthRequest data;
  AuthRequestWithData({@required this.data});

  factory AuthRequestWithData.fromJson(Map<String, dynamic> json) => _$AuthRequestWithDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestWithDataToJson(this);
}