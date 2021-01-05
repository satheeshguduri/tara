import 'package:json_annotation/json_annotation.dart';

part 'track_account_details_response.g.dart';

@JsonSerializable()
class TrackAccountDetailsResponse {
  String transactionId;
  bool success;
  dynamic errorCode;
  dynamic errorReason;
  String status;
  List<ListOfMappedAccountBean> listOfMappedAccount;
  bool pending;

  TrackAccountDetailsResponse({this.transactionId, this.success, this.errorCode, this.errorReason, this.status, this.listOfMappedAccount, this.pending});

  factory TrackAccountDetailsResponse.fromJson(Map<String, dynamic> json) => _$TrackAccountDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackAccountDetailsResponseToJson(this);
}

@JsonSerializable()
class ListOfMappedAccountBean {
  num mappedAccountSeq;
  String bic;
  dynamic registeredName;
  String accountNumber;
  String accountType;
  bool alreadyMappedAccount;
  String bankName;
  String accountToken;
  bool mpinAvailable;

  ListOfMappedAccountBean({this.mappedAccountSeq, this.bic, this.registeredName, this.accountNumber, this.accountType, this.alreadyMappedAccount, this.bankName, this.accountToken, this.mpinAvailable});

  factory ListOfMappedAccountBean.fromJson(Map<String, dynamic> json) => _$ListOfMappedAccountBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ListOfMappedAccountBeanToJson(this);
}

