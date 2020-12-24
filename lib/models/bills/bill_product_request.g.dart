// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillProductRequest _$BillProductRequestFromJson(Map<String, dynamic> json) {
  return BillProductRequest(
    inquiryId: json['inquiryId'] as num,
    accountNumber: json['accountNumber'] as String,
    productCode: json['productCode'] as String,
    amount: json['amount'] as num,
    refNumber: json['refNumber'] as String,
    partnerId: json['partnerId'] as String,
    buyerDetails: json['buyerDetails'] == null
        ? null
        : BuyerDetailsBean.fromJson(
            json['buyerDetails'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BillProductRequestToJson(BillProductRequest instance) =>
    <String, dynamic>{
      'inquiryId': instance.inquiryId,
      'accountNumber': instance.accountNumber,
      'productCode': instance.productCode,
      'amount': instance.amount,
      'refNumber': instance.refNumber,
      'partnerId': instance.partnerId,
      'buyerDetails': instance.buyerDetails,
    };

BuyerDetailsBean _$BuyerDetailsBeanFromJson(Map<String, dynamic> json) {
  return BuyerDetailsBean(
    buyerEmail: json['buyerEmail'] as String,
    publicBuyerId: json['publicBuyerId'] as String,
  );
}

Map<String, dynamic> _$BuyerDetailsBeanToJson(BuyerDetailsBean instance) =>
    <String, dynamic>{
      'buyerEmail': instance.buyerEmail,
      'publicBuyerId': instance.publicBuyerId,
    };
