import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
/*

part 'order_confirmation.g.dart';
*  order_confirmation.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
part 'order_confirmation.g.dart';

@JsonSerializable()
class OrderConfirmation {


     num orderId;
     String status;
     String delivery;
     num amount;
     String deliveryAddress;
     String customerId;
     String merchantId;
     DateTime timestamp;

     OrderConfirmation({this.orderId, this.status, this.delivery, this.amount,
      this.deliveryAddress, this.customerId, this.merchantId, this.timestamp});

     factory OrderConfirmation.fromJson(Map<String, dynamic> json) => _$OrderConfirmationFromJson(json);

     factory OrderConfirmation.fromSnapshot(DataSnapshot snapshot) => _$OrderConfirmationFromJson(snapshot.value);

     Map<String, dynamic> toJson() => _$OrderConfirmationToJson(this);
}
