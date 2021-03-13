import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';

import 'order_address.dart';
import 'order_items.dart';

part 'create_order_req.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateOrderRequest {
  String orderId;
  String storeId;
  //Store storeId;
  num catalogueId;
  List<OrderItems> items;
  int customerId;
  List<OrderAddress> deliveryAddress;
  Statuses status; //
  String price;
//  double tax;
  DateTime deliveryDate;
  DateTime orderDate;
  OrderTypes orderType;
  String transactionId;
  num merchantId;
  JsonbOrderExtra data;
   JsonbOrderExtra order_extra;
//  MessageType messageType;

  CreateOrderRequest(
      {this.orderId,
      // this.storeIdOnly,
      this.storeId,
      this.catalogueId,
      this.items,
      this.customerId,
      this.deliveryAddress,
      this.status,
      this.price,
//      this.tax,
      this.deliveryDate,
      this.orderDate,
      this.orderType,
      this.transactionId,
      this.merchantId,
      this.data,
      this.order_extra});
//  this.messageType

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}
