//controller for making inventory related calls

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/snackbars.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/repositories/order_repository.dart';
// import 'package:tara_app/repositories/product_controller.dart';
import 'package:tara_app/screens/merchant/inventory/choose_category_sheet.dart';
import 'package:tara_app/screens/merchant/inventory/single_product_field.dart';
import 'package:tara_app/services/error/failure.dart';

import '../injector.dart';

class InventoryController extends GetxController {
  var showProgress = false.obs;

  // empty item list
  var items = [].cast<Item>().obs;

  //list of inventory items
  var inventoryItems = [].cast<Item>().obs;

  bool isLast = false;
  int page = 0;

  //add empty item in the items list
  addItem() => items.add(Item());

  // remove item while newly adding the items in the inventory
  deleteEmptyItem(Item item) =>
      items.value = List.from(items)..removeAt(items.indexOf(item));

  //remove item from the inventory (backend)
  removeItem(List<Item> items) async {
    showProgress.value = true;
    Either<Failure, DeleteProductResponse> response = await getIt
        .get<OrderRepository>()
        .deleteProducts(items.map((e) => e.id).toList());
    showProgress.value = false;
    response.fold((l) => Get.showSnackbar(Snackbars.errorSnackbar(l.message)),
        (r) {
      Get.back();
      Get.showSnackbar(Snackbars.productAdditionSnackbar(r.message));

      // remove items from the inventory list
      items.forEach((element) {
        inventoryItems.value = List.from(inventoryItems)
          ..removeAt(inventoryItems.indexOf(element));
      });
    });
  }

  //edit inventory item(backend)
  editItems(List<Item> items) async {
    showProgress.value = true;
    Either<Failure, UpdateProductResponse> response =
        await getIt.get<OrderRepository>().updateProduct(items);
    showProgress.value = false;
    response.fold((l) => Get.showSnackbar(Snackbars.errorSnackbar(l.message)),
        (r) {
      Get.back();
      Get.showSnackbar(Snackbars.productAdditionSnackbar(r.message));
    });
  }

  //Add products to the merchant inventory
  addProducts() async {
    // StoreController storeController = Get.find<StoreController>();

    //set the catalogue for every item
    // items.value =
    //     items.map((i) => i..catalogue = storeController.catalogues).toList();

    showProgress.value = true;
    Either<Failure, AddProductsResponse> response =
        await getIt.get<OrderRepository>().addProduct(items);
    showProgress.value = false;
    response.fold((l) => print, (r) => onProductAdded(r));
  }

  void onProductAdded(AddProductsResponse r) {
    items.clear();
    Get.back();
    Get.showSnackbar(Snackbars.productAdditionSnackbar("${r.message}"));
    //items has been successfully added, so the "Last" should be false
    //to load new items
    isLast = false;
  }

  //item validation
  String validateItem(Item item) {
    if (item != null) {
      if (item.itemName == null) {
        return "Product Name should be valid";
      } else if (item.price == null) {
        return "Item price should be valid";
      } else if (item.quantityInStock == null) {
        return "Item stock should be valid";
      } else if (item.category == null || item.category.isEmpty) {
        return "Should be at-least one category selected";
      } else {
        return null;
      }
    } else {
      return "Item is not valid";
    }
  }

  //get the list of the inventory products
  getProducts() async {
    // is last is the pagination parameter getting from the API
    if (!isLast) {
      showProgress.value = true;
      Either<Failure, GetProductResponse> response =
          await getIt.get<OrderRepository>().getProducts(page, 12);
      showProgress.value = false;
      response.fold((l) => print, (r) {
        if (page == 0) {
          inventoryItems.clear();
        }
        inventoryItems.value.addAll(r.content);
        isLast = r.last;
        page++;
      });
    }
  }
}
