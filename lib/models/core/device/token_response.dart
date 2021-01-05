import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';


///response of
/// - issue-private-access-token
/// - app-login -- decoded response
@JsonSerializable()
class TokenResponse {
  String token;
  num issuedAtMillis;
  num validTillMillis;
  String appName;
  dynamic custPSPId;

  TokenResponse({this.token, this.issuedAtMillis, this.validTillMillis, this.appName, this.custPSPId});

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

