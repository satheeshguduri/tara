// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_type_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTypeId _$StoreTypeIdFromJson(Map<String, dynamic> json) {
  return StoreTypeId(
    json['store'] == null
        ? null
        : Store.fromJson(json['store'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$StoreTypesEnumMap, json['storeType']),
  );
}

Map<String, dynamic> _$StoreTypeIdToJson(StoreTypeId instance) =>
    <String, dynamic>{
      'store': instance.store?.toJson(),
      'storeType': _$StoreTypesEnumMap[instance.storeType],
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

const _$StoreTypesEnumMap = {
  StoreTypes.Groceries: 'Groceries',
  StoreTypes.Meat: 'Meat',
  StoreTypes.FruitAndVegies: 'FruitAndVegies',
};
