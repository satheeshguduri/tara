import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'search_beneficiary_response.g.dart';

@JsonSerializable()
class SearchBeneficiaryResponse {
  String transactionId;
  bool success;
  String errorCode;
  String errorReason;
  String status;
  BeneDetailBean beneDetail;

  SearchBeneficiaryResponse({this.transactionId, this.success, this.errorCode, this.errorReason, this.status, this.beneDetail});

  factory SearchBeneficiaryResponse.fromJson(Map<String, dynamic> json) => _$SearchBeneficiaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBeneficiaryResponseToJson(this);
}

@JsonSerializable()
class BeneDetailBean {
  String custPSPId;
  String accessToken;
  String transactionId;
  AcquiringSourceBean acquiringSource;
  String merchantId;
  String requestedLocale;
  num beneId;
  String beneAccountNo;
  String beneBic;
  String beneName;
  String beneMobile;
  String beneAppName;
  String beneType;
  String accountType;
  num crtnTs;

  BeneDetailBean({this.custPSPId, this.accessToken, this.transactionId, this.acquiringSource, this.merchantId, this.requestedLocale, this.beneId, this.beneAccountNo, this.beneBic, this.beneName, this.beneMobile, this.beneAppName, this.beneType, this.accountType, this.crtnTs});

  factory BeneDetailBean.fromJson(Map<String, dynamic> json) => _$BeneDetailBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BeneDetailBeanToJson(this);
}

