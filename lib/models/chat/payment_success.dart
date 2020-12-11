/*
*  payment_success.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_success.g.dart';

@JsonSerializable()
class PaymentSuccess {


     String payerId;
     String payeeId;
     num amount;
     String transactionId;
     DateTime timestamp;
     String status;

     PaymentSuccess({this.payerId, this.payeeId, this.amount, this.transactionId,
      this.timestamp, this.status});

     factory PaymentSuccess.fromJson(Map<String, dynamic> json) => _$PaymentSuccessFromJson(json);
     Map<String, dynamic> toJson() => _$PaymentSuccessToJson(this);

     factory PaymentSuccess.fromSnapShot(DataSnapshot snapshot) => _$PaymentSuccessFromJson(snapshot.value);

}
