/*
*  common_registration_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/services/config/psp_config.dart';

part 'common_registration_request.g.dart';


 /// * Request Object
 /// * umps-app/register
 /// * umps-app/issue-private-access-token
 /// * umps-login/app-login  -- encrypted request of this payload
 /// * umps-app/track-registration

@JsonSerializable()
class CommonRegistrationRequest {
  String custPSPId;
  String accessToken;
  String transactionId;
  AcquiringSourceBean acquiringSource;
  String merchantId;
  String requestedLocale;
  String userName;
  String bic;
  String cardLast6Digits;


  CommonRegistrationRequest({
      this.custPSPId,
      this.accessToken,
      this.transactionId,
      this.acquiringSource,
      this.merchantId,
      this.requestedLocale,
      this.userName,
      this.bic,
      this.cardLast6Digits});

  factory CommonRegistrationRequest.fromJson(Map<String, dynamic> json) => _$CommonRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommonRegistrationRequestToJson(this);
}

@JsonSerializable()
class AcquiringSourceBean {
  String mobileNumber;
  String sourceIPv4;
  String sourceIPv6;
  String appName;
  GeoCodeBean geoCode;

  AcquiringSourceBean({this.mobileNumber, this.sourceIPv4, this.sourceIPv6, this.appName = PSPConfig.APP_NAME, this.geoCode});

  factory AcquiringSourceBean.fromJson(Map<String, dynamic> json) => _$AcquiringSourceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AcquiringSourceBeanToJson(this);
}

@JsonSerializable()
class GeoCodeBean {
  String latitude;
  String longitude;

  GeoCodeBean({this.latitude, this.longitude});

  factory GeoCodeBean.fromJson(Map<String, dynamic> json) => _$GeoCodeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GeoCodeBeanToJson(this);
}

