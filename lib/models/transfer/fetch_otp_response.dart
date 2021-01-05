import 'package:json_annotation/json_annotation.dart';

part 'fetch_otp_response.g.dart';

@JsonSerializable()
class FetchOtpResponse {
  String referenceId;
  String action;
  String otpPhoneNumber;
  String otpExpiry;
  String otpChallengeCode;

  FetchOtpResponse({this.referenceId, this.action, this.otpPhoneNumber, this.otpExpiry, this.otpChallengeCode});

  factory FetchOtpResponse.fromJson(Map<String, dynamic> json) => _$FetchOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FetchOtpResponseToJson(this);
}

