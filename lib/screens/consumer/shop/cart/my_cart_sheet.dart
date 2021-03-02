import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/cart_icon.dart';
import 'package:tara_app/common/widgets/handle.dart';
import 'package:tara_app/common/widgets/primary_button.dart';
import 'package:tara_app/common/widgets/underline_text.dart';
import 'package:tara_app/controller/cart_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/cart/cart_model.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:get/get.dart';
import 'package:tara_app/screens/consumer/shop/product_item_h.dart';

import '../product_item_h_p.dart';

class MyCartSheet extends StatefulWidget {
  @override
  _MyCartSheetState createState() => _MyCartSheetState();
}

class _MyCartSheetState extends BaseState<MyCartSheet> {
  int selectedSegmentIndex = 0;
  bool isTapOnIndex1 = true;
  bool isTapOnIndex2 = false;

  CartController controller;
  @override
  void initState() {
    super.initState();
    controller = getIt.get<CartController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Expanded(
              child: DraggableScrollableSheet(
                minChildSize: 0.5,
                initialChildSize: 0.8,
                maxChildSize: 1,
                builder: (_, __) => Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    controller: __,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildUpperPart(),
                        if (controller.cart.isNotEmpty)
                          SizedBox(
                            height: 12,
                            width: double.maxFinite,
                            child: ColoredBox(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        if (controller.cart.isNotEmpty)
                          SizedBox(
                            height: 8,
                          ),
                        // this maybe hard to understand
                        if (controller.cart.isNotEmpty)
                          ...controller.cart.keys.map(
                            (e) => Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: ProductItemH(
                                controller.cart[e].item,
                                initialCounter: controller.cart[e].quantity,
                              ),
                            ),
                          ),
                        if (controller.cart.isNotEmpty)
                          SizedBox(
                            height: 8,
                          ),

                        SizedBox(
                          height: 12,
                          width: double.maxFinite,
                          child: ColoredBox(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        buildSimilarItems(),
                        SizedBox(
                          height: 12,
                          width: double.maxFinite,
                          child: ColoredBox(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: SafeArea(
                child: ListTile(
                  leading: CartButton(),
                  title: Text(
                    "Price Estimation",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.input_field_line_off_2_2_2),
                  ),
                  subtitle: Obx(
                    () => Text(
                      "Rp ${controller.price}",
                      style: TextStyles.subtitle1222,
                    ),
                  ),
                  trailing: SizedBox(
                    width: Get.width * 0.4,
                    child: PrimaryButton(
                      onTap: () {
                        controller.createOrder();
                      },
                      alignment: MainAxisAlignment.spaceBetween,
                      iconAffinity: IconAffinity.trailing,
                      text: "Place Order",
                      icon: Icons.arrow_forward,
                    ),
                  ),
                ),
              ),
            )
          ],
          // ),
        ),
      ).withProgressIndicator(showIndicator: controller.loading.value),
    );
  }

  Widget buildSimilarItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "You may also like",
          style: TextStyles.subtitle1222,
        ),
        SizedBox(
          height: 92,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                return SizedBox(
                  child: Card(
                    child: ProductItemHP(),
                  ),
                  width: Get.width * 0.6,
                );
              },
              separatorBuilder: (_, __) => SizedBox(
                    width: 8,
                  ),
              itemCount: 8),
        ),
      ],
    ).paddingAll(16);
  }

  // Widget buildProductsList() {
  //   return ListView.separated(
  //     physics: ClampingScrollPhysics(),
  //     padding: EdgeInsets.symmetric(vertical: 16),
  //     shrinkWrap: true,
  //     itemBuilder: (_, i) {
  //       return ;
  //     },
  //     separatorBuilder: (BuildContext context, int index) => SizedBox(
  //       height: 16,
  //     ),
  //     itemCount: controller.cart.keys.length,
  //   );
  // }

  @override
  BuildContext getContext() {
    return context;
  }

  buildUpperPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Handle(),
          alignment: Alignment.center,
        ),
        Text(
          "My Cart",
          style: TextStyles.headline6222,
        ),
        Obx(
          () => Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 48,
            decoration: BoxDecoration(
                borderRadius: Radii.border(24), color: const Color(0xfff7f7f7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration:
                        controller.isDelivery.value ? _getShadow() : null,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.ic_van),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTranslation(Strings.delivery),
                              style: const TextStyle(
                                  color: AppColors.fareColor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      onTap: () => controller.isDelivery.value = true,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration:
                        !controller.isDelivery.value ? _getShadow() : null,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.ic_bag,
                            width: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTranslation(Strings.pickup),
                              style: const TextStyle(
                                  color: AppColors.fareColor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      onTap: () => controller.isDelivery.value = false,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(
          () {
            if (controller.isDelivery.value)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deliver to",
                    style: TextStyles.caption222.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Image.asset(Assets.ic_location),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …",
                            style: TextStyles.body2222,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        UnderlineText(
                          text: Text(
                            "Change".toUpperCase(),
                            style: TextStyles.bUTTONBlack222,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            else
              return Container();
          },
        ),
      ],
    ).paddingAll(16);
  }

  BoxDecoration roundedBoxDecoration() {
    return BoxDecoration(
        borderRadius: Radii.border(20),
        boxShadow: Shadows.shadows_list,
        color: AppColors.primaryBackground);
  }

  _getShadow() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
            color: const Color(0x1f000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0),
        BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 0)
      ],
      color: Colors.white,
    );
  }
}
