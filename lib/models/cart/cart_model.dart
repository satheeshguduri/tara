import 'package:tara_app/models/order_management/item/item.dart';

class CartItem {
  Item item;
  int quantity;

  CartItem({this.item, this.quantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}