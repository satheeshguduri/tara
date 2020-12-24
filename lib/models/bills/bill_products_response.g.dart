// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillProductsResponse _$BillProductsResponseFromJson(Map<String, dynamic> json) {
  return BillProductsResponse(
    responseCode: json['responseCode'],
    success: json['success'],
    message: json['message'],
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : BillProductDataBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BillProductsResponseToJson(
        BillProductsResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BillProductDataBean _$BillProductDataBeanFromJson(Map<String, dynamic> json) {
  return BillProductDataBean(
    name: json['name'] as String,
    description: json['description'] as String,
    code: json['code'] as String,
    logo: json['logo'] as String,
    amount: json['amount'] as num,
    adminFee: json['adminFee'] as num,
    biller: json['biller'] as String,
    category: json['category'] as String,
    active: json['active'] as bool,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$BillProductDataBeanToJson(
        BillProductDataBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'code': instance.code,
      'logo': instance.logo,
      'amount': instance.amount,
      'adminFee': instance.adminFee,
      'biller': instance.biller,
      'category': instance.category,
      'active': instance.active,
      'type': instance.type,
    };
