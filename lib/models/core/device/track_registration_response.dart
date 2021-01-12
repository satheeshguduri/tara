import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/core/device/register_response.dart';

part 'track_registration_response.g.dart';

//Response of -- /track-registration + RegisterResponse object
@JsonSerializable()
class TrackRegistrationResponse extends RegisterResponse{
  String mobileNumber;
  String pspId;

  TrackRegistrationResponse({String transactionId, bool success, String errorCode, String errorReason, String status, this.mobileNumber, this.pspId}):super(transactionId:transactionId, success:success, errorCode:errorCode, errorReason:errorReason, status:status);

  factory TrackRegistrationResponse.fromJson(Map<String, dynamic> json) => _$TrackRegistrationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackRegistrationResponseToJson(this);
}
