// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:tara_app/screens/consumer/shop/product_item.dart';
//
// import '../../../common/constants/assets.dart';
// import '../../../common/constants/assets.dart';
// import '../../../common/constants/colors.dart';
// import '../../../common/constants/colors.dart';
// import '../../../common/constants/radii.dart';
// import '../../../common/constants/styles.dart';
// import '../../../common/widgets/custom_appbar_widget.dart';
// import '../../base/base_state.dart';
// import 'shop_add_item.dart';
//
// class ProductsByCategory extends StatefulWidget {
//   final String screenTitle;
//
//   const ProductsByCategory({Key key, this.screenTitle}) : super(key: key);
//   @override
//   _ProductsByCategoryState createState() => _ProductsByCategoryState();
// }
//
// class _ProductsByCategoryState extends BaseState<ProductsByCategory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBarWidget(
//         title: "${widget.screenTitle}",
//         addNewWidgetShow: false,
//         actions: [
//           IconButton(
//             icon: SvgPicture.asset(
//               Assets.assets_icon_s_search,
//               color: AppColors.header_top_bar_color,
//             ),
//             onPressed: () {},
//           ),
//           Container(
//             child: Stack(
//               alignment: Alignment.centerRight,
//               children: [
//                 IconButton(
//                     //   icon: Icon(Icons.shopping_cart),
//                     icon: getSvgImage(
//                         imagePath: Assets.assets_icon_c_cart,
//                         width: 24.0,
//                         height: 24.0,
//                         color: AppColors.header_top_bar_color),
//                     onPressed: () => {}),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     width: 14,
//                     height: 14,
//                     decoration: BoxDecoration(
//                       color: AppColors.badge_color,
//                       borderRadius: Radii.border(7),
//                     ),
//                     child: Text(
//                       "3",
//                       textAlign: TextAlign.center,
//                       style: BaseStyles.notificationBadgeTextStyle,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//       body: GridView.count(
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//         childAspectRatio: Get.width * 0.5 / 296,
//         padding: EdgeInsets.all(16),
//         crossAxisCount: 2,
//         children: List.generate(100, (index) => ProductItem()),
//       ),
//     );
//   }
//
//   @override
//   BuildContext getContext() {
//     return context;
//   }
// }
