import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/models/cart/cart_model.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/repositories/cart_repositorty.dart';
import 'package:tara_app/services/error/failure.dart';

class CartRepositoryImpl extends CartRepository {
  static const String CART_KEY = "my_cart";
  static const String ITEM = "item";
  static const String CART_MAP = "MY_MAP";
  static const String ITEM_ID = "item_id";
  static const String QTY = "quantity";

  GetStorage storage;

  CartRepositoryImpl(this.storage);

  @override
  Future<Either<Failure, Map<int, CartItem>>> addToCart(Item item) async {
    Map cartMap = getCartMap();
    if (cartMap.containsKey(item.id)) {
      // item with this id is already in cart
      return Left(Failure(message: "Item already in cart"));
    } else {
      // item is not in the cart
      cartMap.putIfAbsent(
          item.id.toString(), () => CartItem(item: item, quantity: 1).toJson());
      storage.write(CART_KEY, jsonEncode(cartMap));
      return Right(internalMapToUsable(cartMap));
    }
  }

  Map<int,CartItem> internalMapToUsable(Map map) {
    Map<int, CartItem> usableMap = Map();
    map.keys.forEach((element) {
      usableMap.putIfAbsent(
          int.tryParse(element), () => CartItem.fromJson(map[element]));
    });
    return usableMap;
  }

  @override
  clearCart() {
    storage.remove(CART_KEY);
    print("cart cleared");
  }

  @override
  Future<Either<Failure, Map<int, CartItem>>> getCart() async {
    Map cartMap = getCartMap();
    return Right(internalMapToUsable(cartMap));
  }

  @override
  Future<Either<Failure, Map<int, CartItem>>> removeFromCart(Item item) async {
    Map cartMap = getCartMap();

    ///Returns the value associated with key before it was removed. Returns null if key was not in the map.
    var v = cartMap.remove(item.id.toString());
    storage.write(CART_KEY, jsonEncode(cartMap));
    if (v != null) {
      //item was there and has been deleted
      return Right(internalMapToUsable(getCartMap()));
    } else {
      return Left(Failure(message: "Can't be deleted"));
    }
  }

  getCartMap() {
    bool hasData = storage.hasData(CART_KEY);
    Map cartMap = hasData ? jsonDecode(storage.read(CART_KEY)) : {};
    return cartMap;
  }

  @override
  Future<Either<Failure, Map<int, CartItem>>> updateCart(
      Item item, int qty) async {
    Map cartMap = getCartMap();
    if (cartMap.containsKey(item.id.toString())) {
      // item with this id is already in cart
      cartMap[item.id.toString()] =
          CartItem(item: item, quantity: qty).toJson();
      storage.write(CART_KEY, jsonEncode(cartMap));
      return Right(internalMapToUsable(cartMap));
    } else {
      // item is not in the cart
      print("cant update ");
      return Left(Failure(message: "Can't update, item not in cart"));
    }
  }
}
