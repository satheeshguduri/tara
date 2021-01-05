import 'package:json_annotation/json_annotation.dart';

part 'transfer_base_response.g.dart';

@JsonSerializable()
class TransferBaseResponse {
  String transactionId;
  bool success;
  dynamic errorCode;
  dynamic errorReason;
  String status;

  TransferBaseResponse({this.transactionId, this.success, this.errorCode, this.errorReason, this.status});

  factory TransferBaseResponse.fromJson(Map<String, dynamic> json) => _$TransferBaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransferBaseResponseToJson(this);
}

