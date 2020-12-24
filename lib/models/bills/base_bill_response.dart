/*
*  base_bill_response.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';

part 'base_bill_response.g.dart';

@JsonSerializable()
class BaseBillResponse{

  num responseCode;
  bool success;
  MessageBean message;

  BaseBillResponse({this.responseCode, this.success, this.message});
  factory BaseBillResponse.fromJson(Map<String, dynamic> json) => _$BaseBillResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseBillResponseToJson(this);

}

@JsonSerializable()
class MessageBean {
  @JsonKey(name:"ID")
  String id;
  @JsonKey(name:"EN")
  String en;

  MessageBean({this.id, this.en});

  factory MessageBean.fromJson(Map<String, dynamic> json) => _$MessageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MessageBeanToJson(this);
}

