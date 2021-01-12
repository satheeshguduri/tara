// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateOtpRequest _$ValidateOtpRequestFromJson(Map<String, dynamic> json) {
  return ValidateOtpRequest(
    bic: json['bic'] as String,
    referenceId: json['referenceId'] as String,
    otp: json['otp'] as String,
    action: _$enumDecodeNullable(_$ActionTypeEnumMap, json['action']),
    deviceInfo: json['deviceInfo'] == null
        ? null
        : DeviceInfoBean.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValidateOtpRequestToJson(ValidateOtpRequest instance) =>
    <String, dynamic>{
      'bic': instance.bic,
      'referenceId': instance.referenceId,
      'otp': instance.otp,
      'action': _$ActionTypeEnumMap[instance.action],
      'deviceInfo': instance.deviceInfo,
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

const _$ActionTypeEnumMap = {
  ActionType.CARD_REGISTRATION: 'CARD_REGISTRATION',
};
