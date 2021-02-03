// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_card_or_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCardOrPaymentResponse _$CreateCardOrPaymentResponseFromJson(
    Map<String, dynamic> json) {
  return CreateCardOrPaymentResponse(
    error: json['error'] as bool,
    data: json['data'] == null
        ? null
        : DataBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateCardOrPaymentResponseToJson(
        CreateCardOrPaymentResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'data': instance.data,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) {
  return DataBean(
    seamless_url: json['seamless_url'] as String,
    expired_date: json['expired_date'] as String,
  );
}

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'seamless_url': instance.seamless_url,
      'expired_date': instance.expired_date,
    };
