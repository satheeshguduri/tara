import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

/*
*  base_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

@JsonSerializable()
class BaseRequest{

  final String prd;
  final String appVersion;
  final String deviceId;


  BaseRequest({this.prd, this.appVersion, this.deviceId});

  factory BaseRequest.fromJson(Map<String, dynamic> json) => _$BaseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);






}