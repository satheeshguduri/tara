/*
*  common_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';

part 'common_request.g.dart';

@JsonSerializable()
class CommonRequest {
  CommonRequestBean commonRequest;
  String credentialKeysRetrievalPayloadEnc; //for RetrieveKey API
  String registerCardDetailPayloadEnc;
  String confirmAccountRegPayloadEnc; // for confirm Account
  String fetchOtpCodePayloadEnc; // for confirm Account
  String refreshOtpApiPayloadEnc; // for refresh otp
  String validateOtpApiPayloadEnc; // for validate otp
  String credentialSubmissionPayloadEnc; // for authorize


  CommonRequest({this.commonRequest, this.credentialKeysRetrievalPayloadEnc,this.registerCardDetailPayloadEnc,this.confirmAccountRegPayloadEnc,this.refreshOtpApiPayloadEnc,this.credentialSubmissionPayloadEnc,this.validateOtpApiPayloadEnc,this.fetchOtpCodePayloadEnc});

  factory CommonRequest.fromJson(Map<String, dynamic> json) => _$CommonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommonRequestToJson(this);
}

@JsonSerializable()
class CommonRequestBean {
  String msgId;
  String txnId;
  String pspIdentifier;
  String splIdentifier;
  String symmetricKey;
  TransactionType transactionType;

  CommonRequestBean({this.msgId, this.txnId, this.pspIdentifier, this.splIdentifier, this.symmetricKey, this.transactionType});

  factory CommonRequestBean.fromJson(Map<String, dynamic> json) => _$CommonRequestBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CommonRequestBeanToJson(this);
}

