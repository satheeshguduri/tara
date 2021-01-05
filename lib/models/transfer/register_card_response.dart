import 'package:json_annotation/json_annotation.dart';

part 'register_card_response.g.dart';

@JsonSerializable()
class RegisterCardResponse {
  String registeredName;

  RegisterCardResponse({this.registeredName});

  factory RegisterCardResponse.fromJson(Map<String, dynamic> json) => _$RegisterCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterCardResponseToJson(this);
}

