import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'add_beneficiary_request.g.dart';

@JsonSerializable()
class AddBeneficiaryRequest extends CommonRegistrationRequest{
  dynamic beneId;
  String beneAccountNo;
  String beneBic;
  String beneName;
  String beneMobile;
  String beneAppName;
  String beneType;
  String accountType;
  dynamic crtnTs;

  AddBeneficiaryRequest({custPSPId, accessToken, transactionId, acquiringSource, merchantId, requestedLocale, this.beneId, this.beneAccountNo, this.beneBic, this.beneName, this.beneMobile, this.beneAppName, this.beneType, this.accountType, this.crtnTs});

  factory AddBeneficiaryRequest.fromJson(Map<String, dynamic> json) => _$AddBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryRequestToJson(this);
}
