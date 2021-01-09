import 'package:json_annotation/json_annotation.dart';

part 'validate_mobile_response.g.dart';

@JsonSerializable()
class ValidateMobileResponse {
  dynamic transactionId;
  bool success;
  String errorCode;//RC_PSP_VALIDATE_PA_INVALID_PA
  String errorReason;//Invalid User
  String status;
  String name;

  ValidateMobileResponse({this.transactionId, this.success, this.errorCode, this.errorReason, this.status, this.name});

  factory ValidateMobileResponse.fromJson(Map<String, dynamic> json) => _$ValidateMobileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateMobileResponseToJson(this);
}

