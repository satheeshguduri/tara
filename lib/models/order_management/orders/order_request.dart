import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';

import 'order_address.dart';
import 'order_items.dart';

part 'order_request.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderRequest {
  String orderId;
  String storeId;
  //Store storeId;
  num catalogueId;
  List<OrderItems> items;
  int customerId;
  List<OrderAddress> deliveryAddress;
  Statuses status; //
  double price;
//  double tax;
  DateTime deliveryDate;
  DateTime orderDate;
  OrderTypes orderType;
  String transactionId;
  String merchantId;
  JsonbOrderExtra data;
   JsonbOrderExtra order_extra;
//  MessageType messageType;

  OrderRequest(
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

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
