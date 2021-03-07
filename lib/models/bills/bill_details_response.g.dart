// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillDetailsResponse _$BillDetailsResponseFromJson(Map<String, dynamic> json) {
  return BillDetailsResponse(
    data: json['data'] == null
        ? null
        : BillDetailsData.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..responseCode = json['responseCode'] as num
    ..success = json['success'] as bool
    ..message = json['message'] == null
        ? null
        : MessageBean.fromJson(json['message'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BillDetailsResponseToJson(
        BillDetailsResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BillDetailsData _$BillDetailsDataFromJson(Map<String, dynamic> json) {
  return BillDetailsData(
    inquiryId: json['inquiryId'] as num,
    refNumber: json['refNumber'] as String,
    transactionId: json['transactionId'] as num,
    accountNumber: json['accountNumber'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    totalAdmin: json['totalAdmin'] as num,
    processingFee: json['processingFee'] as num,
    denom: json['denom'] as String,
    productCode: json['productCode'] as String,
    productName: json['productName'] as String,
    category: json['category'] as String,
    token: json['token'] as String,
    customerDetails: (json['customerDetails'] as List)
        ?.map((e) => e == null
            ? null
            : CustomerDetailsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    billDetails: json['billDetails'],
    productDetails: (json['productDetails'] as List)
        ?.map((e) => e == null
            ? null
            : ProductDetailsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extraFields: json['extraFields'],
  );
}

Map<String, dynamic> _$BillDetailsDataToJson(BillDetailsData instance) =>
    <String, dynamic>{
      'refNumber': instance.refNumber,
      'transactionId': instance.transactionId,
      'inquiryId': instance.inquiryId,
      'accountNumber': instance.accountNumber,
      'amount': instance.amount,
      'totalAdmin': instance.totalAdmin,
      'processingFee': instance.processingFee,
      'denom': instance.denom,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'category': instance.category,
      'token': instance.token,
      'customerDetails': instance.customerDetails,
      'billDetails': instance.billDetails,
      'productDetails': instance.productDetails,
      'extraFields': instance.extraFields,
    };

ProductDetailsBean _$ProductDetailsBeanFromJson(Map<String, dynamic> json) {
  return ProductDetailsBean(
    key: json['key'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ProductDetailsBeanToJson(ProductDetailsBean instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

CustomerDetailsBean _$CustomerDetailsBeanFromJson(Map<String, dynamic> json) {
  return CustomerDetailsBean(
    key: json['key'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$CustomerDetailsBeanToJson(
        CustomerDetailsBean instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
