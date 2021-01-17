import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'add_beneficiary_request.g.dart';

@JsonSerializable()
class AddBeneficiaryRequest extends CommonRegistrationRequest{
  String beneId;
  String beneAccountNo;
  String beneBic;
  String beneName;
  String beneMobile;
  String beneAppName;
  String beneType;
  String accountType;
  dynamic crtnTs;

  AddBeneficiaryRequest({String custPSPId, String accessToken, String transactionId, AcquiringSourceBean acquiringSource, String merchantId, String requestedLocale, this.beneId, this.beneAccountNo, this.beneBic, this.beneName, this.beneMobile, this.beneAppName, this.beneType, this.accountType, this.crtnTs}):super(custPSPId:custPSPId, accessToken:accessToken, transactionId:transactionId, acquiringSource: acquiringSource, merchantId:merchantId, requestedLocale:requestedLocale);

  factory AddBeneficiaryRequest.fromJson(Map<String, dynamic> json) => _$AddBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryRequestToJson(this);
}


@JsonSerializable()
class MapBeneficiaryRequest extends CommonRegistrationRequest{
  bool accepted;

  MapBeneficiaryRequest({String custPSPId, String accessToken, String transactionId, AcquiringSourceBean acquiringSource, String merchantId, String requestedLocale, this.accepted}):super(custPSPId:custPSPId, accessToken:accessToken, transactionId:transactionId, acquiringSource: acquiringSource, merchantId:merchantId, requestedLocale:requestedLocale);

  factory MapBeneficiaryRequest.fromJson(Map<String, dynamic> json) => _$MapBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MapBeneficiaryRequestToJson(this);
}