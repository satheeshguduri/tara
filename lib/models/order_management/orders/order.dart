import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/chat/message_type.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/store/store.dart';

import 'order_address.dart';
import 'order_items.dart';

part 'order.g.dart';
@JsonSerializable(explicitToJson: true)
class OrderModel{
  String orderId;
  Store storeId;
  Catalogue catalogueId;
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
  JsonbOrderExtra order_extra;
//  MessageType messageType;

  OrderModel(
  {this.orderId,
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
      this.order_extra,});
//  this.messageType

factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
Map<String, dynamic> toJson() => _$OrderModelToJson(this);

}