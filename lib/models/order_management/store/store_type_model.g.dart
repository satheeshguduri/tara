// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTypeModel _$StoreTypeModelFromJson(Map<String, dynamic> json) {
  return StoreTypeModel(
    id: (json['id'] as num)?.toDouble(),
    type: _$enumDecodeNullable(_$StoreTypesEnumMap, json['type']),
    storeTypeAssociations: (json['storeTypeAssociations'] as List)
        ?.map((e) => e == null
            ? null
            : StoreTypeAssociation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StoreTypeModelToJson(StoreTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$StoreTypesEnumMap[instance.type],
      'storeTypeAssociations': instance.storeTypeAssociations,
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
