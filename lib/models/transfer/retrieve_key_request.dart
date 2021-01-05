import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/device_info.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';

part 'retrieve_key_request.g.dart';

@JsonSerializable()
class RetrieveKeyRequest {
  num startDateTime;
  bool resetCredentialCall;
  PaymentInstrumentBean paymentInstrument;
  DeviceInfoBean deviceInfo;

  RetrieveKeyRequest({this.startDateTime, this.resetCredentialCall, this.paymentInstrument, this.deviceInfo});

  factory RetrieveKeyRequest.fromJson(Map<String, dynamic> json) => _$RetrieveKeyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RetrieveKeyRequestToJson(this);
}


