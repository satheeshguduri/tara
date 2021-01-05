import 'package:json_annotation/json_annotation.dart';

part 'user_registration_request.g.dart';

@JsonSerializable()
class UserRegistrationRequest {
  String splIdentifier;
  DeviceInfoBean deviceInfo;

  UserRegistrationRequest({this.splIdentifier, this.deviceInfo});

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) => _$UserRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationRequestToJson(this);
}

@JsonSerializable()
class DeviceInfoBean {
  String deviceId;
  String appId;
  String imei1;
  String imei2;
  String languageSet;
  String os;
  String timezoneOffset;
  String cpuArch;
  String userAgent;
  String screenResolution;
  String maxTouchPoints;
  bool hardwareTouchSupport;

  DeviceInfoBean({this.deviceId, this.appId, this.imei1, this.imei2, this.languageSet, this.os, this.timezoneOffset, this.cpuArch, this.userAgent, this.screenResolution, this.maxTouchPoints, this.hardwareTouchSupport});

  factory DeviceInfoBean.fromJson(Map<String, dynamic> json) => _$DeviceInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoBeanToJson(this);
}

