import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
/*

part 'order.g.dart';
*  order.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {

     String type;
     String orderId;
     List<OrderItems> items;//TODO proper object from order service
     num total;
     String customerId;
     String merchantId;
     int timestamp;
     String transactionId;
     String orderStatus;

     Order({this.type, this.orderId, this.items, this.total, this.customerId,
      this.merchantId, this.timestamp, this.transactionId, this.orderStatus});

     factory Order.fromJson(Map<dynamic, dynamic> json) => _$OrderFromJson(json);

     factory Order.fromSnapshot(DataSnapshot snapshot){
          final json = jsonEncode(snapshot.value);
          final jsonMap = jsonDecode(json);
          return _$OrderFromJson(jsonMap);
     }

     Map<String, dynamic> toJson( instance) => _$OrderToJson(this);

}


