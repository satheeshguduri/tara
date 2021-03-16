// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    id: (json['id'] as num)?.toDouble(),
    invoiceId: json['invoiceId'] as String,
    totalAmount: (json['totalAmount'] as num)?.toDouble(),
    tax: (json['tax'] as num)?.toDouble(),
    deliveryCost: (json['deliveryCost'] as num)?.toDouble(),
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    order: json['order'] == null
        ? null
        : OrderModel.fromJson(json['order'] as Map<String, dynamic>),
    customerAddress: json['customerAddress'] == null
        ? null
        : CustomerAddress.fromJson(
            json['customerAddress'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'invoiceId': instance.invoiceId,
      'totalAmount': instance.totalAmount,
      'tax': instance.tax,
      'deliveryCost': instance.deliveryCost,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'order': instance.order?.toJson(),
      'customerAddress': instance.customerAddress?.toJson(),
    };
