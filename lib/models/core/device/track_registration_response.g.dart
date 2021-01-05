// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackRegistrationResponse _$TrackRegistrationResponseFromJson(
    Map<String, dynamic> json) {
  return TrackRegistrationResponse(
    transactionId: json['transactionId'],
    success: json['success'],
    errorCode: json['errorCode'],
    errorReason: json['errorReason'],
    status: json['status'],
    mobileNumber: json['mobileNumber'] as String,
    pspId: json['pspId'] as String,
  )..sessionKey = json['sessionKey'] as String;
}

Map<String, dynamic> _$TrackRegistrationResponseToJson(
        TrackRegistrationResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'sessionKey': instance.sessionKey,
      'mobileNumber': instance.mobileNumber,
      'pspId': instance.pspId,
    };
