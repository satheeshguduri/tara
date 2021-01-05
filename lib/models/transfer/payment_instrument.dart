/*
*  payment_instrument.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';

part 'payment_instrument.g.dart';

@JsonSerializable()
class PaymentInstrumentBean {
  String paymentInstrumentType;
  String bic;

  PaymentInstrumentBean({this.paymentInstrumentType, this.bic});

  factory PaymentInstrumentBean.fromJson(Map<String, dynamic> json) => _$PaymentInstrumentBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInstrumentBeanToJson(this);
}