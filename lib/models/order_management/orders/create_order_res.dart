import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';



import 'order_address.dart';
import 'order_items.dart';

part 'create_order_res.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateOrderResponse {
  String orderId;
  Store storeId;
  Catalogue catalogueId;
  List<OrderItems> items;
  int customerId;
  List<OrderAddress> deliveryAddress;
  Statuses status; //
  double price;
  double tax;
  String deliveryDate;
  String orderDate;
  OrderTypes orderType;
  String transactionId;
  String merchantId;
  JsonbOrderExtra order_extra;

  CreateOrderResponse(
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

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) => _$CreateOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderResponseToJson(this);
}
