import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/bills/base_bill_response.dart';

part 'bill_details_response.g.dart';

@JsonSerializable()
class BillDetailsResponse extends BaseBillResponse{
  BillDetailsData data;

  BillDetailsResponse({this.data});

  factory BillDetailsResponse.fromJson(Map<String, dynamic> json) => _$BillDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BillDetailsResponseToJson(this);
}

@JsonSerializable()
class BillDetailsData {
  String refNumber;
  num transactionId;
  String accountNumber;
  num amount;
  num totalAdmin;
  num processingFee;
  String denom;
  String productCode;
  String productName;
  String category;
  String token;
  List<CustomerDetailsBean> customerDetails;
  dynamic billDetails;
  List<ProductDetailsBean> productDetails;
  dynamic extraFields;

  BillDetailsData({this.refNumber, this.transactionId, this.accountNumber, this.amount, this.totalAdmin, this.processingFee, this.denom, this.productCode, this.productName, this.category, this.token, this.customerDetails, this.billDetails, this.productDetails, this.extraFields});

  factory BillDetailsData.fromJson(Map<String, dynamic> json) => _$BillDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BillDetailsDataToJson(this);
}

@JsonSerializable()
class ProductDetailsBean {
  String key;
  String value;

  ProductDetailsBean({this.key, this.value});

  factory ProductDetailsBean.fromJson(Map<String, dynamic> json) => _$ProductDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsBeanToJson(this);
}

@JsonSerializable()
class CustomerDetailsBean {
  String key;
  String value;

  CustomerDetailsBean({this.key, this.value});

  factory CustomerDetailsBean.fromJson(Map<String, dynamic> json) => _$CustomerDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsBeanToJson(this);
}


