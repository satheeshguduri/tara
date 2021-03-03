
import 'package:get/get.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';




class CartController extends GetxController {


  var cartItems = List<Item>().obs;
  var selectedItems = List<Item>().obs;

  var favouriteIcon = Assets.assets_icon_f_favorite.obs;
  var iconColor = AppColors.color_black_100_2_2_2.obs;


}