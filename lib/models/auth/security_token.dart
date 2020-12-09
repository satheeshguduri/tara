import 'package:json_annotation/json_annotation.dart';

part 'security_token.g.dart';

/*
*  base_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

@JsonSerializable()
class SecurityToken{

  final String id;
  final Token token;
  final String createdDate;
  final String updatedDate;
  final String expiryDate;
  final String refreshToken;

  SecurityToken({this.id, this.token, this.createdDate, this.updatedDate,
      this.expiryDate, this.refreshToken});

  factory SecurityToken.fromJson(Map<String, dynamic> json) => _$SecurityTokenFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityTokenToJson(this);
}
@JsonSerializable()
class Token{

  final String id;
  final String tara;
  final String ndmp;
  final String rtp;


  Token({this.id, this.tara, this.ndmp, this.rtp});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}