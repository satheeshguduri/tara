import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'payer_collect_request.g.dart';

@JsonSerializable()
class PayerCollectRequest extends CommonRegistrationRequest{
  String approvedAmount;
  bool approved;
  num accountTokenId;
  String merchantTxnId;

  PayerCollectRequest({String custPSPId, String accessToken, String transactionId, AcquiringSourceBean acquiringSource, String merchantId, String requestedLocale, this.approvedAmount, this.approved, this.accountTokenId, this.merchantTxnId}):super(custPSPId:custPSPId, accessToken:accessToken, transactionId:transactionId, acquiringSource: acquiringSource, merchantId:merchantId, requestedLocale:requestedLocale);

  factory PayerCollectRequest.fromJson(Map<String, dynamic> json) => _$PayerCollectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayerCollectRequestToJson(this);
}

