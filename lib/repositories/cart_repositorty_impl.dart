import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/repositories/cart_repositorty.dart';

class CartRepositoryImpl extends CartRepository {
  static const String CART_KEY = "CART";
  static const String ITEM = "item";
  static const String CART_MAP = "MY_MAP";
  static const String ITEM_ID = "item_id";
  static const String QTY = "quantity";

  GetStorage storage;

  CartRepositoryImpl(this.storage);

  Map<String, dynamic> _getCartMap() {
    var s = storage.read(CART_KEY);
    if (s == null) {
      return {};
    } else {
      return jsonDecode(s);
    }
  }

  @override
  Future<List<Map<Item, int>>> addToCart(Item item) async {
    Map<String, dynamic> itemMap = Map();
    itemMap.putIfAbsent(ITEM_ID, () => item.id);
    itemMap.putIfAbsent(ITEM, () => item.toJson());
    itemMap.putIfAbsent(QTY, () => 1);
    List cartList =
        _getCartMap().containsKey(CART_MAP) ? _getCartMap()[CART_MAP] : [];
    cartList.add(jsonEncode(itemMap));

    Map<String, List> map = {CART_MAP: cartList};
    storage.write(CART_KEY, jsonEncode(map));
    print("ggg ${storage.getKeys()}");
    storage.listen(() {
      print("storage ${storage.read(CART_KEY)}");
    });
    return getCart();
  }

  @override
  Future<Item> removeFromCart(Item item) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<Item, int>> updateCart(Item item, int qty) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<Item, int>>> getCart() async {
    List<Map<Item, int>> ite = List();
    _getCartMap()[CART_MAP]?.forEach((e) {
      var map = jsonDecode(e);
      Item i = Item.fromJson(map[ITEM]);
      int q = map[QTY];
      Map<Item, int> m = Map();
      m.putIfAbsent(i, () => q);
      ite.add(m);
    });

    return ite;
  }

  @override
  clearCart() {
    storage.remove(CART_KEY);
  }

}
