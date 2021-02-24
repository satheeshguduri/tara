import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tara_app/screens/consumer/shop/cart/my_cart_sheet.dart';

import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/radii.dart';
import '../constants/styles.dart';

class CartButton extends StatelessWidget {
  final Color iconColor;
  final bool isClickable;

  const CartButton({Key key, this.iconColor, this.isClickable = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          IconButton(
            icon: SvgPicture.asset(Assets.assets_icon_c_cart,
                width: 24.0,
                height: 24.0,
                color: iconColor ?? AppColors.header_top_bar_color),
            onPressed: () => {
              isClickable
                  ? Get.bottomSheet(
                      Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: MyCartSheet(),
                        // color: Colors.red,
                      ),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                    )
                  : null
            },
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.badge_color,
                borderRadius: Radii.border(7),
              ),
              child: Text(
                "3",
                textAlign: TextAlign.center,
                style: BaseStyles.notificationBadgeTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
