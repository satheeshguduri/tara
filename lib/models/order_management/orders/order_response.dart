import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';



import 'order_address.dart';
import 'order_items.dart';

part 'order_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderResponse {
  String orderId;
  Store storeId;
  Catalogue catalogueId;
  List<OrderItems> items;
  int customerId;
  List<OrderAddress> deliveryAddress;
  Statuses status; //
  double price;
  double tax;
  DateTime deliveryDate;
  DateTime orderDate;
  OrderTypes orderType;
  String transactionId;
  num merchantId;
  JsonbOrderExtra order_extra;

  OrderResponse(
      {this.orderId,
        this.storeId,
        this.catalogueId,
        this.items,
        this.customerId,
        this.deliveryAddress,
        this.status,
        this.price,
        this.tax,
        this.deliveryDate,
        this.orderDate,
        this.orderType,
        this.transactionId,
        this.merchantId,
        this.order_extra});

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
