// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] == null
        ? null
        : StoreAddress.fromJson(json['address'] as Map<String, dynamic>),
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    registration_status: json['registration_status'] as bool,
    status: _$enumDecodeNullable(_$StatusEnumMap, json['status']),
    types: (json['types'] as List)
        ?.map((e) => e == null
            ? null
            : StoreTypeAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    registerStore: json['registerStore'] == null
        ? null
        : RegisterStore.fromJson(json['registerStore'] as Map<String, dynamic>),
    owner: json['owner'] == null
        ? null
        : Owner.fromJson(json['owner'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address?.toJson(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'registration_status': instance.registration_status,
      'status': _$StatusEnumMap[instance.status],
      'types': instance.types?.map((e) => e?.toJson())?.toList(),
      'registerStore': instance.registerStore?.toJson(),
      'owner': instance.owner?.toJson(),
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

const _$StatusEnumMap = {
  Status.OPEN: 'OPEN',
  Status.CLOSED: 'CLOSED',
  Status.OUTOFBBUSINESS: 'OUTOFBBUSINESS',
  Status.UNKNOWN: 'UNKNOWN',
};
