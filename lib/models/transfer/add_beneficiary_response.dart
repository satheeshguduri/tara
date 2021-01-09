import 'package:json_annotation/json_annotation.dart';

part 'add_beneficiary_response.g.dart';

@JsonSerializable()
class AddBeneficiaryResponse {
  String transactionId;
  bool success;
  dynamic errorCode;
  dynamic errorReason;
  String status;
  String beneAccountNo;
  String beneBic;
  String beneName;
  String beneMobile;
  String beneAppId;
  String accountType;
  String beneType;

  AddBeneficiaryResponse({this.transactionId, this.success, this.errorCode, this.errorReason, this.status, this.beneAccountNo, this.beneBic, this.beneName, this.beneMobile, this.beneAppId, this.accountType, this.beneType});

  factory AddBeneficiaryResponse.fromJson(Map<String, dynamic> json) => _$AddBeneficiaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryResponseToJson(this);
}

