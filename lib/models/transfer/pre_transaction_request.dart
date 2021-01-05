import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';

part 'pre_transaction_request.g.dart';

@JsonSerializable()
class PreTransactionRequest extends CommonRegistrationRequest{
  RequestType type;
  String amount;

  PreTransactionRequest({custPSPId, accessToken, transactionId, acquiringSource, merchantId, requestedLocale, this.type, this.amount});

  factory PreTransactionRequest.fromJson(Map<String, dynamic> json) => _$PreTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PreTransactionRequestToJson(this);
}
