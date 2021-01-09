import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'validate_mobile_request.g.dart';

@JsonSerializable()
class ValidateMobileRequest extends CommonRegistrationRequest {
  String validationMobile;
  String validationAppName;

  ValidateMobileRequest({custPSPId, accessToken, transactionId, acquiringSource, merchantId, requestedLocale, this.validationMobile, this.validationAppName});

  factory ValidateMobileRequest.fromJson(Map<String, dynamic> json) => _$ValidateMobileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateMobileRequestToJson(this);
}

