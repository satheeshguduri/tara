// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponse _$CommonResponseFromJson(Map<String, dynamic> json) {
  return CommonResponse(
    commonResponse: json['commonResponse'] == null
        ? null
        : CommonResponseBean.fromJson(
            json['commonResponse'] as Map<String, dynamic>),
    encryptionKeyRetrievalResponsePayloadEnc:
        json['encryptionKeyRetrievalResponsePayloadEnc'] as String,
    registerCardDetailResponsePayloadEnc:
        json['registerCardDetailResponsePayloadEnc'] as String,
    fetchOtpCodeResponsePayloadEnc:
        json['fetchOtpCodeResponsePayloadEnc'] as String,
  )..validateOtpApiPayloadEnc = json['validateOtpApiPayloadEnc'] as String;
}

Map<String, dynamic> _$CommonResponseToJson(CommonResponse instance) =>
    <String, dynamic>{
      'commonResponse': instance.commonResponse,
      'encryptionKeyRetrievalResponsePayloadEnc':
          instance.encryptionKeyRetrievalResponsePayloadEnc,
      'registerCardDetailResponsePayloadEnc':
          instance.registerCardDetailResponsePayloadEnc,
      'fetchOtpCodeResponsePayloadEnc': instance.fetchOtpCodeResponsePayloadEnc,
      'validateOtpApiPayloadEnc': instance.validateOtpApiPayloadEnc,
    };

CommonResponseBean _$CommonResponseBeanFromJson(Map<String, dynamic> json) {
  return CommonResponseBean(
    reqMsgId: json['reqMsgId'] as String,
    symmetricKey: json['symmetricKey'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$CommonResponseBeanToJson(CommonResponseBean instance) =>
    <String, dynamic>{
      'reqMsgId': instance.reqMsgId,
      'symmetricKey': instance.symmetricKey,
      'success': instance.success,
    };
