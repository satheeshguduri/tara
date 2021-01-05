import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/device_info.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';

part 'fetch_otp_request.g.dart';

@JsonSerializable()
class FetchOtpRequest {
  PaymentInstrumentBean paymentInstrument;
  String action;
  DeviceInfoBean deviceInfo;

  FetchOtpRequest({this.paymentInstrument, this.action, this.deviceInfo});

  factory FetchOtpRequest.fromJson(Map<String, dynamic> json) => _$FetchOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FetchOtpRequestToJson(this);
}



