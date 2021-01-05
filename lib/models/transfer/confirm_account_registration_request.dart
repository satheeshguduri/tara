import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/device_info.dart';

part 'confirm_account_registration_request.g.dart';

@JsonSerializable()
class ConfirmAccountRegistrationRequest {
  String bic;
  bool accepted;
  DeviceInfoBean deviceInfo;

  ConfirmAccountRegistrationRequest({this.bic, this.accepted, this.deviceInfo});

  factory ConfirmAccountRegistrationRequest.fromJson(Map<String, dynamic> json) => _$ConfirmAccountRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAccountRegistrationRequestToJson(this);
}
