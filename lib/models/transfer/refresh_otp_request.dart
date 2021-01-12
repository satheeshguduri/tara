import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/device_info.dart';

part 'refresh_otp_request.g.dart';

@JsonSerializable()
class RefreshOtpRequest {
  String bic;
  String referenceId;
  ActionType action;
  DeviceInfoBean deviceInfo;

  RefreshOtpRequest({this.bic, this.referenceId, this.action, this.deviceInfo});

  factory RefreshOtpRequest.fromJson(Map<String, dynamic> json) => _$RefreshOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshOtpRequestToJson(this);
}

