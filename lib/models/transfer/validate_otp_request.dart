import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/device_info.dart';

part 'validate_otp_request.g.dart';

@JsonSerializable()
class ValidateOtpRequest {
  String bic;
  String referenceId;
  String otp;
  ActionType action;
  DeviceInfoBean deviceInfo;

  ValidateOtpRequest({this.bic, this.referenceId, this.otp, this.action, this.deviceInfo});

  factory ValidateOtpRequest.fromJson(Map<String, dynamic> json) => _$ValidateOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateOtpRequestToJson(this);
}
