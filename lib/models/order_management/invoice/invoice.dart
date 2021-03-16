import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/order_management/invoice/customer_address.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/orders/order.dart';

part 'invoice.g.dart';
@JsonSerializable(explicitToJson: true)
class Invoice{
   double id;
   String invoiceId; //TODO what is the pattern of this id
   double totalAmount;
   double tax;
   double deliveryCost;
   List<Item> items;
   OrderModel order;
   CustomerAddress customerAddress;

   Invoice({this.id, this.invoiceId, this.totalAmount, this.tax,
       this.deliveryCost, this.items, this.order, this.customerAddress});

factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}