// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchOtpRequest _$FetchOtpRequestFromJson(Map<String, dynamic> json) {
  return FetchOtpRequest(
    paymentInstrument: json['paymentInstrument'] == null
        ? null
        : PaymentInstrumentBean.fromJson(
            json['paymentInstrument'] as Map<String, dynamic>),
    action: json['action'] as String,
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FetchOtpRequestToJson(FetchOtpRequest instance) =>
    <String, dynamic>{
      'paymentInstrument': instance.paymentInstrument,
      'action': instance.action,
      'deviceInfo': instance.deviceInfo,
    };
