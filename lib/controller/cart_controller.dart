import 'package:get/get.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/repositories/cart_repositorty.dart';
import 'package:tara_app/repositories/cart_repositorty_impl.dart';

class CartController extends GetxController {
  List<Map<Item, int>> items = [].cast<Map<Item, int>>().obs;


  addToCart(Item item) async {
    items = await getIt.get<CartRepository>().addToCart(item);
  }

  getCart() async {
    items = await getIt.get<CartRepository>().getCart();
  }

  clearCart() {
    getIt.get<CartRepository>().clearCart();
    items.clear();
  }
}
