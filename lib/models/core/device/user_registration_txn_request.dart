import 'package:json_annotation/json_annotation.dart';

part 'user_registration_txn_request.g.dart';


///Request object for
/// -- urn:apiver:1.0/user-registration-txn
///
@JsonSerializable()
class UserRegistrationTxnRequest {
  String txnId;
  String mobileNumber;
  String sessionKeyKi;
  String status;
  dynamic crtnTs;
  dynamic lstUpdTs;

  UserRegistrationTxnRequest({this.txnId, this.mobileNumber, this.sessionKeyKi, this.status, this.crtnTs, this.lstUpdTs});

  factory UserRegistrationTxnRequest.fromJson(Map<String, dynamic> json) => _$UserRegistrationTxnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationTxnRequestToJson(this);
}

