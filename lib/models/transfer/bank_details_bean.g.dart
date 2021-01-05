// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetailsBean _$BankDetailsBeanFromJson(Map<String, dynamic> json) {
  return BankDetailsBean(
    bic: json['bic'] as String,
    name: json['name'] as String,
    active: json['active'] as bool,
    isRefUrl: json['isRefUrl'] as bool,
  );
}

Map<String, dynamic> _$BankDetailsBeanToJson(BankDetailsBean instance) =>
    <String, dynamic>{
      'bic': instance.bic,
      'name': instance.name,
      'active': instance.active,
      'isRefUrl': instance.isRefUrl,
    };
