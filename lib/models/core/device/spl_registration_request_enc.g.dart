// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spl_registration_request_enc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplRegistrationRequestEnc _$SplRegistrationRequestEncFromJson(
    Map<String, dynamic> json) {
  return SplRegistrationRequestEnc(
    msgId: json['msgId'] as String,
    pspOrgId: json['pspOrgId'] as String,
    symmetricKey: json['symmetricKey'] as String,
    txnId: json['txnId'] as String,
    splRegistrationRequestEnc: json['splRegistrationRequestEnc'] as String,
  );
}

Map<String, dynamic> _$SplRegistrationRequestEncToJson(
        SplRegistrationRequestEnc instance) =>
    <String, dynamic>{
      'msgId': instance.msgId,
      'pspOrgId': instance.pspOrgId,
      'symmetricKey': instance.symmetricKey,
      'txnId': instance.txnId,
      'splRegistrationRequestEnc': instance.splRegistrationRequestEnc,
    };
