// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonborder_extra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonbOrderExtra _$JsonbOrderExtraFromJson(Map<String, dynamic> json) {
  return JsonbOrderExtra(
    json['customer_commid'] as String,
    json['merchant_commid'] as String,
    json['interpret'] as bool,
  );
}

Map<String, dynamic> _$JsonbOrderExtraToJson(JsonbOrderExtra instance) =>
    <String, dynamic>{
      'customer_commid': instance.customer_commid,
      'merchant_commid': instance.merchant_commid,
      'interpret': instance.interpret,
    };
