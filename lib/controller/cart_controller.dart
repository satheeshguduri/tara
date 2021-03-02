import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/cart/cart_model.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/orders/jsonborder_extra.dart';
import 'package:tara_app/models/order_management/orders/order_address.dart';
import 'package:tara_app/models/order_management/orders/order_extra_data.dart';
import 'package:tara_app/models/order_management/orders/order_types.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/repositories/cart_repositorty.dart';
import 'package:tara_app/repositories/cart_repositorty_impl.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/services/error/failure.dart';

import 'auth_controller.dart';
import 'order_controller.dart';

class CartController extends GetxController {
  var cart = {}.obs;
  var price = 0.0.obs;
  var loading = false.obs;
  var isDelivery = true.obs;

  Store merchantStore;
  CustomerProfile merchantProfile;

  setMerchant(Store store, {CustomerProfile profile}) {
    merchantStore = store;
    // merchantProfile = profile;
  }

  addToCart(Item item) async {
    var v = await getIt.get<CartRepository>().addToCart(item);
    v.fold((l) => print(l), (r) {
      getTotalPrice();
      cart.value = r;
    });
  }

  getCart() async {
    var v = await getIt.get<CartRepository>().getCart();
    v.fold((l) => print("item there already"), (r) {
      getTotalPrice();
      cart.value = r;
    });
  }

  updateCart(Item item, int qty) async {
    var v = await getIt.get<CartRepository>().updateCart(item, qty);
    v.fold((l) => print("item there already"), (r) {
      cart.value = r;
      getTotalPrice();
    });
  }

  removeFromCart(
    Item item,
  ) async {
    var v = await getIt.get<CartRepository>().removeFromCart(item);
    v.fold((l) => print("Something went wrong while deleting"), (r) {
      cart.value = r;
      getTotalPrice();
    });
  }

  getTotalPrice() {
    price.value = 0.0;
    cart.keys.forEach((element) {
      try {
        price += cart[element].quantity * cart[element].item.price;
      } catch (e) {
        print(e);
      }
    });
  }

  clearCart() {
    getIt.get<CartRepository>().clearCart();
    cart.clear();
  }

  createOrder() async {
    if (cart.keys.length > 0) {
      loading.value = true;
      AuthResponse user = Get.find<AuthController>().user.value;
      OrderController controller = Get.find();
      List<OrderAddress> address = List<OrderAddress>();
      var address1 = OrderAddress(
          dno: "1-2-3",
          streetName: "kattedan",
          city: "Hyderabad",
          country: "india",
          zipcode: 500077);
      address.add(address1);
      var orderReq = order.Order();
      orderReq.items = cart.keys.map((e) => null).toList();
      orderReq.customerId = user.customerProfile.id;
      orderReq.merchantId = merchantStore.owner.integrationId.toString();
      orderReq.storeId = merchantStore;
      orderReq.deliveryAddress = address;
      orderReq.status = Statuses.PENDING;
      orderReq.orderDate = DateTime.now(); //"2020-10-09";
      orderReq.orderType = OrderTypes.TEXT_BASED;
      var data = OrderExtraData(
          customer_commid: user.customerProfile?.firebaseId,
          merchant_commid: merchantProfile?.firebaseId,
          interpret: "true");
      var orderExtra = JsonbOrderExtra(data: data);
      orderReq.order_extra = orderExtra;
      Either<Failure, order.Order> response =
          await controller.createOrder(orderReq);
      response.fold((l) {
        Get.dialog(AlertDialog(
          title: Text("Error"),
          content: Text(l.message),
        ));
        print(l.message);
      }, (r) {
        cart.clear();
        Get.dialog(AlertDialog(
          title: Text("Success"),
          content: Text("Order Created"),
        ));
        print("order created");
      });
      loading.value = false;
    }
  }
}
