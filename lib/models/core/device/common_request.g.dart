// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonRequest _$CommonRequestFromJson(Map<String, dynamic> json) {
  return CommonRequest(
    commonRequest: json['commonRequest'] == null
        ? null
        : CommonRequestBean.fromJson(
            json['commonRequest'] as Map<String, dynamic>),
    credentialKeysRetrievalPayloadEnc:
        json['credentialKeysRetrievalPayloadEnc'] as String,
    registerCardDetailPayloadEnc:
        json['registerCardDetailPayloadEnc'] as String,
    confirmAccountRegPayloadEnc: json['confirmAccountRegPayloadEnc'] as String,
    refreshOtpApiPayloadEnc: json['refreshOtpApiPayloadEnc'] as String,
    credentialSubmissionPayloadEnc:
        json['credentialSubmissionPayloadEnc'] as String,
    validateOtpApiPayloadEnc: json['validateOtpApiPayloadEnc'] as String,
  );
}

Map<String, dynamic> _$CommonRequestToJson(CommonRequest instance) =>
    <String, dynamic>{
      'commonRequest': instance.commonRequest,
      'credentialKeysRetrievalPayloadEnc':
          instance.credentialKeysRetrievalPayloadEnc,
      'registerCardDetailPayloadEnc': instance.registerCardDetailPayloadEnc,
      'confirmAccountRegPayloadEnc': instance.confirmAccountRegPayloadEnc,
      'refreshOtpApiPayloadEnc': instance.refreshOtpApiPayloadEnc,
      'validateOtpApiPayloadEnc': instance.validateOtpApiPayloadEnc,
      'credentialSubmissionPayloadEnc': instance.credentialSubmissionPayloadEnc,
    };

CommonRequestBean _$CommonRequestBeanFromJson(Map<String, dynamic> json) {
  return CommonRequestBean(
    msgId: json['msgId'] as String,
    txnId: json['txnId'] as String,
    pspIdentifier: json['pspIdentifier'] as String,
    splIdentifier: json['splIdentifier'] as String,
    symmetricKey: json['symmetricKey'] as String,
    transactionType:
        _$enumDecodeNullable(_$TransactionTypeEnumMap, json['transactionType']),
  );
}

Map<String, dynamic> _$CommonRequestBeanToJson(CommonRequestBean instance) =>
    <String, dynamic>{
      'msgId': instance.msgId,
      'txnId': instance.txnId,
      'pspIdentifier': instance.pspIdentifier,
      'splIdentifier': instance.splIdentifier,
      'symmetricKey': instance.symmetricKey,
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TransactionTypeEnumMap = {
  TransactionType.REGISTER_CARD_ACC_DETAIL: 'REGISTER_CARD_ACC_DETAIL',
  TransactionType.FINANCIAL_TXN: 'FINANCIAL_TXN',
};
