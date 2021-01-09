import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'account_details_request.g.dart';

@JsonSerializable()
class AccountDetailsRequest extends CommonRegistrationRequest{
  String bic;
  String cardLast6Digits;

  AccountDetailsRequest({custPSPId, accessToken, transactionId, acquiringSource, merchantId, requestedLocale, this.bic, this.cardLast6Digits});

  factory AccountDetailsRequest.fromJson(Map<String, dynamic> json) => _$AccountDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailsRequestToJson(this);
}


