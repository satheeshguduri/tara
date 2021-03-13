
import 'package:get/get.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';




class CartController extends GetxController {


  var cartItems = List<Item>().obs;
  var selectedItems = List<Item>().obs;

  var favouriteIcon = Assets.assets_icon_f_favorite.obs;
  var iconColor = AppColors.color_black_100_2_2_2.obs;

  List<T> mapT<T>(List list,Function handler){
    List<T> result = [];
    for(var i=0;i<list.length;i++){
      result.add(handler(i,list[i]));
    }
    return result;
  }

String getCartItemsTotalAmount() {
  double totalAmount=0;
  for(int i=0;i<cartItems.length;i++){
    totalAmount = totalAmount+cartItems[i].orderQuantity*cartItems[i].price??0;
  }
  return totalAmount.toString();
}

  String getCartItemsCount() {
    num totalCount=0;
    for(int i=0;i<cartItems.length;i++){
      totalCount = totalCount+cartItems[i].orderQuantity??0;
    }
    return totalCount.toString();
  }


}