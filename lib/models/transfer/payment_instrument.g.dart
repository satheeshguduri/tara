// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_instrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInstrumentBean _$PaymentInstrumentBeanFromJson(
    Map<String, dynamic> json) {
  return PaymentInstrumentBean(
    paymentInstrumentType: json['paymentInstrumentType'] as String,
    bic: json['bic'] as String,
  );
}

Map<String, dynamic> _$PaymentInstrumentBeanToJson(
        PaymentInstrumentBean instance) =>
    <String, dynamic>{
      'paymentInstrumentType': instance.paymentInstrumentType,
      'bic': instance.bic,
    };
