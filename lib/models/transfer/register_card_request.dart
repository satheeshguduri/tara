import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/device_info.dart';

part 'register_card_request.g.dart';

@JsonSerializable()
class RegisterCardRequest {
  num startDateTime;
  CardBean card;
  DeviceInfoBean deviceInfo;
  AccountInfoBean accountInfo;
  String bic;

  RegisterCardRequest({this.startDateTime, this.card, this.deviceInfo, this.accountInfo, this.bic});

  factory RegisterCardRequest.fromJson(Map<String, dynamic> json) => _$RegisterCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterCardRequestToJson(this);
}

@JsonSerializable()
class AccountInfoBean {
  String bic;
  String accountNo;

  AccountInfoBean({this.bic, this.accountNo});

  factory AccountInfoBean.fromJson(Map<String, dynamic> json) => _$AccountInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoBeanToJson(this);
}
@JsonSerializable()
class CardBean {
  String number;
  String cvv;
  String expiryMonth;
  String expiryYear;
  String fullName;

  CardBean({this.number, this.cvv, this.expiryMonth, this.expiryYear, this.fullName});

  factory CardBean.fromJson(Map<String, dynamic> json) => _$CardBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CardBeanToJson(this);
}

