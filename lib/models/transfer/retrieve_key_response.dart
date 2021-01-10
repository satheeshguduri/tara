import 'package:json_annotation/json_annotation.dart';

part 'retrieve_key_response.g.dart';

@JsonSerializable()
class RetrieveKeyResponse {
  String sessionKey;
  String bankKi;
  String publicKey;
  bool isUrlPage;
  String rule;

  RetrieveKeyResponse({this.sessionKey, this.bankKi, this.publicKey, this.isUrlPage, this.rule});

  factory RetrieveKeyResponse.fromJson(Map<String, dynamic> json) => _$RetrieveKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RetrieveKeyResponseToJson(this);
}

