// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterStore _$RegisterStoreFromJson(Map<String, dynamic> json) {
  return RegisterStore(
    storeId: json['storeId'] as String,
    picUrl: json['picUrl'] as String,
    registrationDocUrl: json['registrationDocUrl'] as String,
  );
}

Map<String, dynamic> _$RegisterStoreToJson(RegisterStore instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'picUrl': instance.picUrl,
      'registrationDocUrl': instance.registrationDocUrl,
    };
