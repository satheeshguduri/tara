/*
*  common_response.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  CommonResponseBean commonResponse;
  String encryptionKeyRetrievalResponsePayloadEnc;
  String registerCardDetailResponsePayloadEnc;
  String fetchOtpCodeResponsePayloadEnc;

  CommonResponse({this.commonResponse, this.encryptionKeyRetrievalResponsePayloadEnc,this.registerCardDetailResponsePayloadEnc,this.fetchOtpCodeResponsePayloadEnc});

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}

@JsonSerializable()
class CommonResponseBean {
  String reqMsgId;
  String symmetricKey;
  bool success;

  CommonResponseBean({this.reqMsgId, this.symmetricKey, this.success});

  factory CommonResponseBean.fromJson(Map<String, dynamic> json) => _$CommonResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseBeanToJson(this);
}

