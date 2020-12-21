/*
*  payment_success.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/chat/message_type.dart';

part 'payment_success.g.dart';

@JsonSerializable()
class PaymentSuccess {

     MessageType messageType;
     String payerId;
     String payeeId;
     num amount;
     String transactionId;
     int timestamp;
     String status;

     PaymentSuccess({this.payerId, this.payeeId, this.amount, this.transactionId,
      this.timestamp, this.status,this.messageType});

     factory PaymentSuccess.fromJson(Map<String, dynamic> json) => _$PaymentSuccessFromJson(json);
     Map<String, dynamic> toJson() => _$PaymentSuccessToJson(this);

     factory PaymentSuccess.fromSnapshot(DataSnapshot snapshot){
          final json = jsonEncode(snapshot.value);
          final jsonMap = jsonDecode(json);
          return _$PaymentSuccessFromJson(jsonMap);
     }

}
