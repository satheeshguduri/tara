import 'package:json_annotation/json_annotation.dart';

part 'spl_registration_request_enc.g.dart';

@JsonSerializable()
class SplRegistrationRequestEnc {
  String msgId;
  String pspOrgId;
  String symmetricKey;
  String txnId;
  String splRegistrationRequestEnc;

  SplRegistrationRequestEnc({this.msgId, this.pspOrgId, this.symmetricKey, this.txnId, this.splRegistrationRequestEnc});

  factory SplRegistrationRequestEnc.fromJson(Map<String, dynamic> json) => _$SplRegistrationRequestEncFromJson(json);

  Map<String, dynamic> toJson() => _$SplRegistrationRequestEncToJson(this);
}

