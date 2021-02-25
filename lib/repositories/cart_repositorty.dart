import 'package:tara_app/models/order_management/item/item.dart';

abstract class CartRepository {
  Future<List<Map<Item, int>>> addToCart(Item item);
  Future<Map<Item, int>> updateCart(Item item, int qty);
  Future<List<Map<Item, int>>> getCart();
  Future<Item> removeFromCart(Item item);
  clearCart();
}
