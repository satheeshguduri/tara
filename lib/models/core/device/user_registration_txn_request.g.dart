// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_txn_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationTxnRequest _$UserRegistrationTxnRequestFromJson(
    Map<String, dynamic> json) {
  return UserRegistrationTxnRequest(
    txnId: json['txnId'] as String,
    mobileNumber: json['mobileNumber'] as String,
    sessionKeyKi: json['sessionKeyKi'] as String,
    status: json['status'] as String,
    crtnTs: json['crtnTs'],
    lstUpdTs: json['lstUpdTs'],
  );
}

Map<String, dynamic> _$UserRegistrationTxnRequestToJson(
        UserRegistrationTxnRequest instance) =>
    <String, dynamic>{
      'txnId': instance.txnId,
      'mobileNumber': instance.mobileNumber,
      'sessionKeyKi': instance.sessionKeyKi,
      'status': instance.status,
      'crtnTs': instance.crtnTs,
      'lstUpdTs': instance.lstUpdTs,
    };
