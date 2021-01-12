import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'account_details_request.g.dart';

@JsonSerializable()
class AccountDetailsRequest extends CommonRegistrationRequest{
  String bic;
  String cardLast6Digits;

  AccountDetailsRequest({String custPSPId, String accessToken, String transactionId, AcquiringSourceBean acquiringSource, String merchantId, String requestedLocale, this.bic, this.cardLast6Digits}):
      super(custPSPId:custPSPId,accessToken:accessToken,transactionId:transactionId,acquiringSource:acquiringSource,merchantId:merchantId,requestedLocale:requestedLocale);

  factory AccountDetailsRequest.fromJson(Map<String, dynamic> json) => _$AccountDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailsRequestToJson(this);
}


