import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';

part 'delete_account_request.g.dart';

@JsonSerializable()
class DeleteAccountRequest extends CommonRegistrationRequest {
  List<num> accountTokenIds;
  DeleteAccountRequest({
    String custPSPId,
    String accessToken,
    String transactionId,
    AcquiringSourceBean acquiringSource,
    String merchantId,
    String requestedLocale,
    this.accountTokenIds,
  }) : super(
            custPSPId: custPSPId,
            accessToken: accessToken,
            transactionId: transactionId,
            acquiringSource: acquiringSource,
            merchantId: merchantId,
            requestedLocale: requestedLocale);

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);
}
