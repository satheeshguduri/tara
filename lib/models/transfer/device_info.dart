/*
*  device_info.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfoBean {
  String deviceId;
  String appId;
  String imei1;
  String imei2;
  String mobileNo;
  String pspIdentifier;
  String languageSet;
  String os;
  String timezoneOffset;
  String cpuArch;
  String userAgent;
  String screenResolution;
  String maxTouchPoints;
  bool hardwareTouchSupport;

  DeviceInfoBean({this.deviceId, this.appId, this.imei1, this.imei2, this.mobileNo, this.pspIdentifier, this.languageSet, this.os, this.timezoneOffset, this.cpuArch, this.userAgent, this.screenResolution, this.maxTouchPoints, this.hardwareTouchSupport});

  factory DeviceInfoBean.fromJson(Map<String, dynamic> json) => _$DeviceInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoBeanToJson(this);
}