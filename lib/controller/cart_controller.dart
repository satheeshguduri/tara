import 'package:get/get.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';


class CartController extends GetxController {


  var cartItems = List<Item>().obs;
  var selectedItems = List<Item>().obs;

  var favouriteIcon = Assets.assets_icon_f_favorite.obs;
  var iconColor = AppColors.color_black_100_2_2_2.obs;

  var cartDB = GetStorage();


  List<T> mapT<T>(List list,Function handler){
    List<T> result = [];
    for(var i=0;i<list.length;i++){
      result.add(handler(i,list[i]));
    }
    return result;
  }

double getCartItemsTotalAmount() {
  double totalAmount=0;
  for(int i=0;i<cartItems.length;i++){
    totalAmount = totalAmount+cartItems[i].orderQuantity*cartItems[i].price??0;
  }
  return totalAmount;
}



  void loadCartFromDB(){
    List<dynamic> items = jsonDecode(jsonEncode(cartDB.read('items')));
    cartItems.value = items.map((e) => Item.fromJson(e)).toList();
  }

String getCartItemsCount() {
  num totalCount=0;
  for(int i=0;i<cartItems.length;i++){
         totalCount = totalCount+cartItems[i].orderQuantity??0;
   }
   return totalCount.toString();
}


}