import 'package:dartz/dartz.dart';
import 'package:tara_app/models/cart/cart_model.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class CartRepository {
  Future<Either<Failure, Map<int,CartItem>>> addToCart(Item item);
  Future<Either<Failure, Map<int,CartItem>>> updateCart(Item item, int qty);
  Future<Either<Failure, Map<int,CartItem>>> getCart();
  Future<Either<Failure, Map<int,CartItem>>> removeFromCart(Item item);
  clearCart();
}
