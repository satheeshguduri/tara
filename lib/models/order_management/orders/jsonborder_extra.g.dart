// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonborder_extra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonbOrderExtra _$JsonbOrderExtraFromJson(Map<String, dynamic> json) {
  return JsonbOrderExtra(
    data: json['data'] == null
        ? null
        : OrderExtraData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$JsonbOrderExtraToJson(JsonbOrderExtra instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };
