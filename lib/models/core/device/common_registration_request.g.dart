// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonRegistrationRequest _$CommonRegistrationRequestFromJson(
    Map<String, dynamic> json) {
  return CommonRegistrationRequest(
    custPSPId: json['custPSPId'] as String,
    accessToken: json['accessToken'] as String,
    transactionId: json['transactionId'] as String,
    acquiringSource: json['acquiringSource'] == null
        ? null
        : AcquiringSourceBean.fromJson(
            json['acquiringSource'] as Map<String, dynamic>),
    merchantId: json['merchantId'] as String,
    requestedLocale: json['requestedLocale'] as String,
    userName: json['userName'] as String,
    bic: json['bic'] as String,
    cardLast6Digits: json['cardLast6Digits'] as String,
  );
}

Map<String, dynamic> _$CommonRegistrationRequestToJson(
        CommonRegistrationRequest instance) =>
    <String, dynamic>{
      'custPSPId': instance.custPSPId,
      'accessToken': instance.accessToken,
      'transactionId': instance.transactionId,
      'acquiringSource': instance.acquiringSource,
      'merchantId': instance.merchantId,
      'requestedLocale': instance.requestedLocale,
      'userName': instance.userName,
      'bic': instance.bic,
      'cardLast6Digits': instance.cardLast6Digits,
    };

AcquiringSourceBean _$AcquiringSourceBeanFromJson(Map<String, dynamic> json) {
  return AcquiringSourceBean(
    mobileNumber: json['mobileNumber'] as String,
    sourceIPv4: json['sourceIPv4'] as String,
    sourceIPv6: json['sourceIPv6'] as String,
    appName: json['appName'] as String,
    geoCode: json['geoCode'] == null
        ? null
        : GeoCodeBean.fromJson(json['geoCode'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AcquiringSourceBeanToJson(
        AcquiringSourceBean instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'sourceIPv4': instance.sourceIPv4,
      'sourceIPv6': instance.sourceIPv6,
      'appName': instance.appName,
      'geoCode': instance.geoCode,
    };

GeoCodeBean _$GeoCodeBeanFromJson(Map<String, dynamic> json) {
  return GeoCodeBean(
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
  );
}

Map<String, dynamic> _$GeoCodeBeanToJson(GeoCodeBean instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
