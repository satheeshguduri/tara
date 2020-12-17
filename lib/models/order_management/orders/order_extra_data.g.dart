// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderExtraData _$OrderExtraDataFromJson(Map<String, dynamic> json) {
  return OrderExtraData(
    customer_commid: json['customer_commid'] as String,
    merchant_commid: json['merchant_commid'] as String,
  );
}

Map<String, dynamic> _$OrderExtraDataToJson(OrderExtraData instance) =>
    <String, dynamic>{
      'customer_commid': instance.customer_commid,
      'merchant_commid': instance.merchant_commid,
    };
