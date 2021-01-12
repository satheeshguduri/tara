// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_otp_common_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchOtpCommonRequest _$FetchOtpCommonRequestFromJson(
    Map<String, dynamic> json) {
  return FetchOtpCommonRequest(
    commonRequest: json['commonRequest'] == null
        ? null
        : CommonRequestBean.fromJson(
            json['commonRequest'] as Map<String, dynamic>),
    fetchOtpCodePayloadEnc: json['fetchOtpCodePayloadEnc'] as String,
  );
}

Map<String, dynamic> _$FetchOtpCommonRequestToJson(
        FetchOtpCommonRequest instance) =>
    <String, dynamic>{
      'commonRequest': instance.commonRequest,
      'fetchOtpCodePayloadEnc': instance.fetchOtpCodePayloadEnc,
    };
