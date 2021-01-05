// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchOtpResponse _$FetchOtpResponseFromJson(Map<String, dynamic> json) {
  return FetchOtpResponse(
    referenceId: json['referenceId'] as String,
    action: json['action'] as String,
    otpPhoneNumber: json['otpPhoneNumber'] as String,
    otpExpiry: json['otpExpiry'] as String,
    otpChallengeCode: json['otpChallengeCode'] as String,
  );
}

Map<String, dynamic> _$FetchOtpResponseToJson(FetchOtpResponse instance) =>
    <String, dynamic>{
      'referenceId': instance.referenceId,
      'action': instance.action,
      'otpPhoneNumber': instance.otpPhoneNumber,
      'otpExpiry': instance.otpExpiry,
      'otpChallengeCode': instance.otpChallengeCode,
    };
