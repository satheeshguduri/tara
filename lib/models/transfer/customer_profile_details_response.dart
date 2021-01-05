import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'customer_profile_details_response.g.dart';

@JsonSerializable()
class CustomerProfileDetailsResponse {
  String mobileNo;
  String appId;
  List<MappedBankAccountsBean> mappedBankAccounts;
  String customerName;

  CustomerProfileDetailsResponse({this.mobileNo, this.appId, this.mappedBankAccounts, this.customerName});

  factory CustomerProfileDetailsResponse.fromJson(Map<String, dynamic> json) => _$CustomerProfileDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerProfileDetailsResponseToJson(this);
}

@JsonSerializable()
class MappedBankAccountsBean {
  String custPSPId;
  String accessToken;
  String transactionId;
  AcquiringSourceBean acquiringSource;
  String merchantId;
  String requestedLocale;
  num id;
  num accountTokenId;
  String accountToken;
  String maskedAccountNumber;
  String customerPspId;
  bool isDefault;
  bool mpinExists;
  String bic;
  String accountType;
  String bankName;

  MappedBankAccountsBean({this.custPSPId, this.accessToken, this.transactionId, this.acquiringSource, this.merchantId, this.requestedLocale, this.id, this.accountTokenId, this.accountToken, this.maskedAccountNumber, this.customerPspId, this.isDefault, this.mpinExists, this.bic, this.accountType, this.bankName});

  factory MappedBankAccountsBean.fromJson(Map<String, dynamic> json) => _$MappedBankAccountsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MappedBankAccountsBeanToJson(this);
}

