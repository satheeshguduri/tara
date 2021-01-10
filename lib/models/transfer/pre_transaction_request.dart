import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';

part 'pre_transaction_request.g.dart';

@JsonSerializable()
class PreTransactionRequest extends CommonRegistrationRequest{
  RequestType type;
  String amount;

  PreTransactionRequest({String custPSPId, String accessToken, String transactionId, AcquiringSourceBean acquiringSource, String merchantId, String requestedLocale, this.type, this.amount}):super(custPSPId:custPSPId, accessToken:accessToken, transactionId:transactionId, acquiringSource: acquiringSource, merchantId:merchantId, requestedLocale:requestedLocale);

  factory PreTransactionRequest.fromJson(Map<String, dynamic> json) => _$PreTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PreTransactionRequestToJson(this);
}
