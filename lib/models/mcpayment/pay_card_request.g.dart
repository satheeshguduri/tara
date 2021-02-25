// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayCardRequest _$PayCardRequestFromJson(Map<String, dynamic> json) {
  return PayCardRequest(
    register_id: json['register_id'] as String,
    callback_url: json['callback_url'],
    return_url: json['return_url'] as String,
    token: json['token'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$PayCardRequestToJson(PayCardRequest instance) =>
    <String, dynamic>{
      'register_id': instance.register_id,
      'callback_url': instance.callback_url,
      'return_url': instance.return_url,
      'token': instance.token,
      'amount': instance.amount,
      'description': instance.description,
    };
