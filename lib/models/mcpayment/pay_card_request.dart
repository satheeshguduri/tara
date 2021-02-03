import 'package:json_annotation/json_annotation.dart';

part 'pay_card_request.g.dart';

@JsonSerializable()
class PayCardRequest {
  String register_id;
  dynamic callback_url;
  String return_url;
  String token;
  num amount;
  String description;

  PayCardRequest({this.register_id, this.callback_url, this.return_url, this.token, this.amount, this.description});

  factory PayCardRequest.fromJson(Map<String, dynamic> json) => _$PayCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayCardRequestToJson(this);
}

