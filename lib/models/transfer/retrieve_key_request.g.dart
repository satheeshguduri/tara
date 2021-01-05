// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieve_key_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrieveKeyRequest _$RetrieveKeyRequestFromJson(Map<String, dynamic> json) {
  return RetrieveKeyRequest(
    startDateTime: json['startDateTime'] as num,
    resetCredentialCall: json['resetCredentialCall'] as bool,
    paymentInstrument: json['paymentInstrument'] == null
        ? null
        : PaymentInstrumentBean.fromJson(
            json['paymentInstrument'] as Map<String, dynamic>),
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RetrieveKeyRequestToJson(RetrieveKeyRequest instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime,
      'resetCredentialCall': instance.resetCredentialCall,
      'paymentInstrument': instance.paymentInstrument,
      'deviceInfo': instance.deviceInfo,
    };
