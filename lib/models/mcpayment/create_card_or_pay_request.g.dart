// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_card_or_pay_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCardOrPayRequest _$CreateCardOrPayRequestFromJson(
    Map<String, dynamic> json) {
  return CreateCardOrPayRequest(
    register_id: json['register_id'] as String,
    callback_url: json['callback_url'] as String,
    return_url: json['return_url'] as String,
    is_transaction: json['is_transaction'] as bool,
    transaction: json['transaction'] == null
        ? null
        : TransactionBean.fromJson(json['transaction'] as Map<String, dynamic>),
    optionalData: json['optionalData'] == null
        ? null
        : OptionalDataBean.fromJson(
            json['optionalData'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateCardOrPayRequestToJson(
        CreateCardOrPayRequest instance) =>
    <String, dynamic>{
      'register_id': instance.register_id,
      'callback_url': instance.callback_url,
      'return_url': instance.return_url,
      'is_transaction': instance.is_transaction,
      'transaction': instance.transaction,
      'optionalData': instance.optionalData,
    };

OptionalDataBean _$OptionalDataBeanFromJson(Map<String, dynamic> json) {
  return OptionalDataBean(
    customerId: json['customerId'] as String,
  );
}

Map<String, dynamic> _$OptionalDataBeanToJson(OptionalDataBean instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
    };

TransactionBean _$TransactionBeanFromJson(Map<String, dynamic> json) {
  return TransactionBean(
    amount: json['amount'] as num,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$TransactionBeanToJson(TransactionBean instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
    };
