// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerProfile _$CustomerProfileFromJson(Map<String, dynamic> json) {
  return CustomerProfile(
    firstName: json['firstName'] as String,
    id: json['id'] as int,
    lastName: json['lastName'] as String,
    mobileNumber: json['mobileNumber'] as String,
    country: json['country'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    isKyc: json['isKyc'] as bool,
    email: json['email'] as String,
    customerType: json['customerType'] as String,
    firebaseId: json['firebaseId'] as String,
    credential: json['credential'] as String,
    token: json['token'] as String,
    address: json['address'],
    registrationStatus: _$enumDecodeNullable(
        _$RegistrationStatusEnumMap, json['registrationStatus']),
  )..plainMobileNumber = json['plainMobileNumber'] as String;
}

Map<String, dynamic> _$CustomerProfileToJson(CustomerProfile instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'id': instance.id,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'plainMobileNumber': instance.plainMobileNumber,
      'country': instance.country,
      'dateOfBirth': instance.dateOfBirth,
      'isKyc': instance.isKyc,
      'email': instance.email,
      'customerType': instance.customerType,
      'firebaseId': instance.firebaseId,
      'credential': instance.credential,
      'token': instance.token,
      'address': instance.address,
      'registrationStatus':
          _$RegistrationStatusEnumMap[instance.registrationStatus],
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

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.TARA: 'TARA',
  RegistrationStatus.RTP: 'RTP',
  RegistrationStatus.INACTIVE: 'INACTIVE',
  RegistrationStatus.BENEFICIARY: 'BENEFICIARY',
};

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return SignUpRequest(
    mobileNumber: json['mobileNumber'] as String,
    password: json['password'] as String,
    customerProfile: json['customerProfile'] == null
        ? null
        : CustomerProfile.fromJson(
            json['customerProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'customerProfile': instance.customerProfile,
    };
