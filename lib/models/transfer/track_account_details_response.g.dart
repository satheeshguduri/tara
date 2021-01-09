// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_account_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackAccountDetailsResponse _$TrackAccountDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return TrackAccountDetailsResponse(
    transactionId: json['transactionId'] as String,
    success: json['success'] as bool,
    errorCode: json['errorCode'] as String,
    errorReason: json['errorReason'] as String,
    status: json['status'] as String,
    listOfMappedAccount: (json['listOfMappedAccount'] as List)
        ?.map((e) => e == null
            ? null
            : ListOfMappedAccountBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pending: json['pending'] as bool,
  );
}

Map<String, dynamic> _$TrackAccountDetailsResponseToJson(
        TrackAccountDetailsResponse instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'errorReason': instance.errorReason,
      'status': instance.status,
      'listOfMappedAccount': instance.listOfMappedAccount,
      'pending': instance.pending,
    };

ListOfMappedAccountBean _$ListOfMappedAccountBeanFromJson(
    Map<String, dynamic> json) {
  return ListOfMappedAccountBean(
    mappedAccountSeq: json['mappedAccountSeq'] as num,
    bic: json['bic'] as String,
    registeredName: json['registeredName'],
    accountNumber: json['accountNumber'] as String,
    accountType: json['accountType'] as String,
    alreadyMappedAccount: json['alreadyMappedAccount'] as bool,
    bankName: json['bankName'] as String,
    accountToken: json['accountToken'] as String,
    mpinAvailable: json['mpinAvailable'] as bool,
  );
}

Map<String, dynamic> _$ListOfMappedAccountBeanToJson(
        ListOfMappedAccountBean instance) =>
    <String, dynamic>{
      'mappedAccountSeq': instance.mappedAccountSeq,
      'bic': instance.bic,
      'registeredName': instance.registeredName,
      'accountNumber': instance.accountNumber,
      'accountType': instance.accountType,
      'alreadyMappedAccount': instance.alreadyMappedAccount,
      'bankName': instance.bankName,
      'accountToken': instance.accountToken,
      'mpinAvailable': instance.mpinAvailable,
    };
