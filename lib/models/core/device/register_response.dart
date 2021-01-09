import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

//Response for api psp-umps-adaptor/umps-app/register
@JsonSerializable()
class RegisterResponse {
  String transactionId;
  bool success;
  String errorCode;
  String errorReason;
  String status;
  String sessionKey;

  RegisterResponse({this.transactionId, this.success, this.errorCode, this.errorReason, this.status, this.sessionKey});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

