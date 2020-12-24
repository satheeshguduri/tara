import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/bills/base_bill_response.dart';

part 'balance_data_response.g.dart';

@JsonSerializable()
class BalanceDataResponse extends BaseBillResponse{
  BalanceData data;

  BalanceDataResponse({this.data});

  factory BalanceDataResponse.fromJson(Map<String, dynamic> json) => _$BalanceDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceDataResponseToJson(this);
}


@JsonSerializable()
class BalanceData {
  num balance;
  String currency;
  String partnerId;

  BalanceData({this.balance, this.currency, this.partnerId});

  factory BalanceData.fromJson(Map<String, dynamic> json) => _$BalanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceDataToJson(this);
}

