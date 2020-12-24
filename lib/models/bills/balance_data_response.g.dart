// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceDataResponse _$BalanceDataResponseFromJson(Map<String, dynamic> json) {
  return BalanceDataResponse(
    data: json['data'] == null
        ? null
        : BalanceData.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..responseCode = json['responseCode'] as num
    ..success = json['success'] as bool
    ..message = json['message'] == null
        ? null
        : MessageBean.fromJson(json['message'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BalanceDataResponseToJson(
        BalanceDataResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BalanceData _$BalanceDataFromJson(Map<String, dynamic> json) {
  return BalanceData(
    balance: json['balance'] as num,
    currency: json['currency'] as String,
    partnerId: json['partnerId'] as String,
  );
}

Map<String, dynamic> _$BalanceDataToJson(BalanceData instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'currency': instance.currency,
      'partnerId': instance.partnerId,
    };
