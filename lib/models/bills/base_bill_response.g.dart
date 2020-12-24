// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_bill_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBillResponse _$BaseBillResponseFromJson(Map<String, dynamic> json) {
  return BaseBillResponse(
    responseCode: json['responseCode'] as num,
    success: json['success'] as bool,
    message: json['message'] == null
        ? null
        : MessageBean.fromJson(json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BaseBillResponseToJson(BaseBillResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'success': instance.success,
      'message': instance.message,
    };

MessageBean _$MessageBeanFromJson(Map<String, dynamic> json) {
  return MessageBean(
    id: json['ID'] as String,
    en: json['EN'] as String,
  );
}

Map<String, dynamic> _$MessageBeanToJson(MessageBean instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'EN': instance.en,
    };
