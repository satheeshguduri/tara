import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'track_transaction_request.g.dart';

@JsonSerializable()
class TrackTransactionRequest extends CommonRegistrationRequest{
  dynamic merchantTxnId;
  bool waitForCompletion;

  TrackTransactionRequest({String custPSPId,
    String accessToken, String transactionId,
    AcquiringSourceBean acquiringSource, String merchantId,
    String requestedLocale, this.merchantTxnId, this.waitForCompletion}): super(custPSPId:custPSPId, accessToken:accessToken, transactionId:transactionId, acquiringSource: acquiringSource, merchantId:merchantId, requestedLocale:requestedLocale);

  factory TrackTransactionRequest.fromJson(Map<String, dynamic> json) => _$TrackTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TrackTransactionRequestToJson(this);
}
