import 'package:json_annotation/json_annotation.dart';

import 'device_info.dart';

part 'authorize_request.g.dart';

@JsonSerializable()
class AuthorizeRequest {
  DeviceInfoBean deviceInfo;
  AuthorizePINCredBean authorizePINCred;

  AuthorizeRequest({this.deviceInfo, this.authorizePINCred});

  factory AuthorizeRequest.fromJson(Map<String, dynamic> json) => _$AuthorizeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizeRequestToJson(this);
}

@JsonSerializable()
class AuthorizePINCredBean {
  String credType;
  String credValue;

  AuthorizePINCredBean({this.credType, this.credValue});

  factory AuthorizePINCredBean.fromJson(Map<String, dynamic> json) => _$AuthorizePINCredBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizePINCredBeanToJson(this);
}

