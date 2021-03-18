import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/base_request.dart';

part 'auth_put_request.g.dart';

@JsonSerializable()
class AuthPutRequest extends BaseRequest {
  final String mobileNumber;
  final String password;
  final bool accountStatus;
  final String customerType;

  AuthPutRequest(
      this.mobileNumber, this.password, this.accountStatus, this.customerType);

  factory AuthPutRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthPutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthPutRequestToJson(this);
}