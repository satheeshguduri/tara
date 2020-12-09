
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/base_request.dart';

part 'base_user_request.g.dart';

/*
*  base_user_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

@JsonSerializable()
class BaseUserRequest extends BaseRequest{

  final String logId;
  final String refId;
  final String userName;


  BaseUserRequest({this.logId, this.refId,this.userName});

  factory BaseUserRequest.fromJson(Map<String, dynamic> json) => _$BaseUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BaseUserRequestToJson(this);


}