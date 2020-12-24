import 'package:json_annotation/json_annotation.dart';

part 'bill_product_request.g.dart';

@JsonSerializable()
class BillProductRequest {
  num inquiryId;
  String accountNumber;
  String productCode;
  num amount;
  String refNumber;
  String partnerId;
  BuyerDetailsBean buyerDetails;

  BillProductRequest({this.inquiryId, this.accountNumber, this.productCode, this.amount, this.refNumber, this.partnerId, this.buyerDetails});

  factory BillProductRequest.fromJson(Map<String, dynamic> json) => _$BillProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BillProductRequestToJson(this);
}

@JsonSerializable()
class BuyerDetailsBean {
  String buyerEmail;
  String publicBuyerId;

  BuyerDetailsBean({this.buyerEmail, this.publicBuyerId});

  factory BuyerDetailsBean.fromJson(Map<String, dynamic> json) => _$BuyerDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BuyerDetailsBeanToJson(this);
}

