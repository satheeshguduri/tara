// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) {
  return CardData(
    id: json['callbackResponsePk'] == null
        ? null
        : IdBean.fromJson(json['callbackResponsePk'] as Map<String, dynamic>),
    amount: json['amount'] as num,
    bankIssuer: json['bankIssuer'] as String,
    cardBrand: json['cardBrand'] as String,
    cardExpDate: json['cardExpDate'] as String,
    cardHolderName: json['cardHolderName'] as String,
    token: json['token'] as String,
    maskedCardNumber: json['maskedCardNumber'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'callbackResponsePk': instance.id,
      'amount': instance.amount,
      'bankIssuer': instance.bankIssuer,
      'cardBrand': instance.cardBrand,
      'cardExpDate': instance.cardExpDate,
      'cardHolderName': instance.cardHolderName,
      'token': instance.token,
      'maskedCardNumber': instance.maskedCardNumber,
      'status': instance.status,
    };

IdBean _$IdBeanFromJson(Map<String, dynamic> json) {
  return IdBean(
    mcPaymentCardId: json['mcPaymentCardId'] as String,
    customerId: json['customerId'] as num,
  );
}

Map<String, dynamic> _$IdBeanToJson(IdBean instance) => <String, dynamic>{
      'mcPaymentCardId': instance.mcPaymentCardId,
      'customerId': instance.customerId,
    };
