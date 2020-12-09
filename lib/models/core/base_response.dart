import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/*
*  base_response.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

@JsonSerializable()
class BaseResponse{

  final String message;
  final int status;

  BaseResponse({this.message, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

}