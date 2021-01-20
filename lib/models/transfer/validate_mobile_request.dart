import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'validate_mobile_request.g.dart';

@JsonSerializable()
class
ValidateMobileRequest extends CommonRegistrationRequest {
  String validationMobile;
  String validationAppName;

  ValidateMobileRequest({String custPSPId, String accessToken, String transactionId, AcquiringSourceBean acquiringSource, String merchantId, String requestedLocale, this.validationMobile, this.validationAppName}):super(custPSPId:custPSPId, accessToken:accessToken, transactionId:transactionId, acquiringSource: acquiringSource, merchantId:merchantId, requestedLocale:requestedLocale);

  factory ValidateMobileRequest.fromJson(Map<String, dynamic> json) => _$ValidateMobileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateMobileRequestToJson(this);
}

