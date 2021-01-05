// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationResponse _$UserRegistrationResponseFromJson(
    Map<String, dynamic> json) {
  return UserRegistrationResponse(
    pspIdentifier: json['pspIdentifier'] as String,
    splKey: json['splKey'] as String,
  );
}

Map<String, dynamic> _$UserRegistrationResponseToJson(
        UserRegistrationResponse instance) =>
    <String, dynamic>{
      'pspIdentifier': instance.pspIdentifier,
      'splKey': instance.splKey,
    };

SplRegistrationResponseEnc _$SplRegistrationResponseEncFromJson(
    Map<String, dynamic> json) {
  return SplRegistrationResponseEnc(
    commonResponse: json['commonResponse'] == null
        ? null
        : CommonResponseBean.fromJson(
            json['commonResponse'] as Map<String, dynamic>),
    userRegistrationResponsePayloadEnc:
        json['userRegistrationResponsePayloadEnc'] as String,
  );
}

Map<String, dynamic> _$SplRegistrationResponseEncToJson(
        SplRegistrationResponseEnc instance) =>
    <String, dynamic>{
      'commonResponse': instance.commonResponse,
      'userRegistrationResponsePayloadEnc':
          instance.userRegistrationResponsePayloadEnc,
    };
