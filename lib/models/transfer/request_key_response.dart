import 'package:json_annotation/json_annotation.dart';

part 'request_key_response.g.dart';

@JsonSerializable()
class RequestKeyResponse {
  String sessionKey;
  String bankKi;
  String publicKey;
  bool isUrlPage;
  String rule;

  RequestKeyResponse({this.sessionKey, this.bankKi, this.publicKey, this.isUrlPage, this.rule});

  factory RequestKeyResponse.fromJson(Map<String, dynamic> json) => _$RequestKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestKeyResponseToJson(this);
}

