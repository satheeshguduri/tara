// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_profile_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerProfileDetailsResponse _$CustomerProfileDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return CustomerProfileDetailsResponse(
    mobileNo: json['mobileNo'] as String,
    appId: json['appId'] as String,
    mappedBankAccounts: (json['mappedBankAccounts'] as List)
        ?.map((e) => e == null
            ? null
            : MappedBankAccountsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    customerName: json['customerName'] as String,
  );
}

Map<String, dynamic> _$CustomerProfileDetailsResponseToJson(
        CustomerProfileDetailsResponse instance) =>
    <String, dynamic>{
      'mobileNo': instance.mobileNo,
      'appId': instance.appId,
      'mappedBankAccounts': instance.mappedBankAccounts,
      'customerName': instance.customerName,
    };

MappedBankAccountsBean _$MappedBankAccountsBeanFromJson(
    Map<String, dynamic> json) {
  return MappedBankAccountsBean(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    id: json['id'] as num,
    accountTokenId: json['accountTokenId'] as num,
    accountToken: json['accountToken'] as String,
    maskedAccountNumber: json['maskedAccountNumber'] as String,
    customerPspId: json['customerPspId'] as String,
    isDefault: json['isDefault'] as bool,
    mpinExists: json['mpinExists'] as bool,
    bic: json['bic'] as String,
    accountType: json['accountType'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$MappedBankAccountsBeanToJson(
        MappedBankAccountsBean instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'id': instance.id,
      'accountTokenId': instance.accountTokenId,
      'accountToken': instance.accountToken,
      'maskedAccountNumber': instance.maskedAccountNumber,
      'customerPspId': instance.customerPspId,
      'isDefault': instance.isDefault,
      'mpinExists': instance.mpinExists,
      'bic': instance.bic,
      'accountType': instance.accountType,
      'bankName': instance.bankName,
    };
