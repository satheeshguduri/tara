import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart';

@JsonSerializable()
class CardData {
  IdBean id;
  num amount;
  String bankIssuer;
  String cardBrand;
  String cardExpDate;
  String cardHolderName;
  String token;
  String maskedCardNumber;
  String status;

  CardData({this.id, this.amount, this.bankIssuer, this.cardBrand, this.cardExpDate, this.cardHolderName, this.token, this.maskedCardNumber, this.status});

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}

@JsonSerializable()
class IdBean {
  String mcPaymentCardId;
  num customerId;

  IdBean({this.mcPaymentCardId, this.customerId});

  factory IdBean.fromJson(Map<String, dynamic> json) => _$IdBeanFromJson(json);

  Map<String, dynamic> toJson() => _$IdBeanToJson(this);
}

