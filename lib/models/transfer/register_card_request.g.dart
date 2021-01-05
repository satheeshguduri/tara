// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterCardRequest _$RegisterCardRequestFromJson(Map<String, dynamic> json) {
  return RegisterCardRequest(
    startDateTime: json['startDateTime'] as num,
    card: json['card'] == null
        ? null
        : CardBean.fromJson(json['card'] as Map<String, dynamic>),
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
    accountInfo: json['accountInfo'] == null
        ? null
        : AccountInfoBean.fromJson(json['accountInfo'] as Map<String, dynamic>),
    bic: json['bic'] as String,
  );
}

Map<String, dynamic> _$RegisterCardRequestToJson(
        RegisterCardRequest instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime,
      'card': instance.card,
      'deviceInfo': instance.deviceInfo,
      'accountInfo': instance.accountInfo,
      'bic': instance.bic,
    };

AccountInfoBean _$AccountInfoBeanFromJson(Map<String, dynamic> json) {
  return AccountInfoBean(
    bic: json['bic'] as String,
    accountNo: json['accountNo'] as String,
  );
}

Map<String, dynamic> _$AccountInfoBeanToJson(AccountInfoBean instance) =>
    <String, dynamic>{
      'bic': instance.bic,
      'accountNo': instance.accountNo,
    };

CardBean _$CardBeanFromJson(Map<String, dynamic> json) {
  return CardBean(
    number: json['number'] as String,
    cvv: json['cvv'] as String,
    expiryMonth: json['expiryMonth'] as String,
    expiryYear: json['expiryYear'] as String,
    fullName: json['fullName'] as String,
  );
}

Map<String, dynamic> _$CardBeanToJson(CardBean instance) => <String, dynamic>{
      'number': instance.number,
      'cvv': instance.cvv,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'fullName': instance.fullName,
    };
