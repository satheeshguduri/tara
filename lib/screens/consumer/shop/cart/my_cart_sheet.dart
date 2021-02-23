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

  final isDelivery = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          child: ListTile(
            leading: CartButton(),
            title: Text(
              "Price Estimation",
              style: TextStyle(
                  fontSize: 12, color: AppColors.input_field_line_off_2_2_2),
            ),
            subtitle: Text(
              "Rp 13.200",
              style: TextStyles.subtitle1222,
            ),
            trailing: SizedBox(
              width: Get.width * 0.5,
              child: PrimaryButton(
                onTap: () {},
                iconAffinity: IconAffinity.trailing,
                text: "Place Order",
                icon: Icons.arrow_forward,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUpperPart(),
              SizedBox(
                height: 12,
                width: double.maxFinite,
                child: ColoredBox(
                  color: Colors.grey.shade200,
                ),
              ),
              buildProductsList(),
              SizedBox(
                height: 12,
                width: double.maxFinite,
                child: ColoredBox(
                  color: Colors.grey.shade200,
                ),
              ),
              buildSimilarItems(),
            ],
          ),
        ),
      ),
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

  ListView buildProductsList() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16),
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return ProductItemH();
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 8,
      ),
      itemCount: 2,
    );
  }

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

        ///TODO create a tab here for delivery and pickup
        Row(
          children: [
            Text("Pickup"),
            ValueBuilder(
              initialValue: true,
              onUpdate: (v) => isDelivery.value = v,
              builder: (data, updateFn) {
                return Switch(value: data, onChanged: updateFn);
              },
            ),
            Text("Delivery"),
          ],
        ),
        Obx(
          () {
            if (isDelivery.value)
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: Icon(
                    Icons.location_on_rounded,
                    color: AppColors.color_black_100_2_2_2,
                  ),
                  title: Text(
                    "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …",
                    style: TextStyles.body2222,
                    maxLines: 2,
                  ),
                  trailing: Text(
                    "Change".toUpperCase(),
                    style: TextStyles.bUTTONBlack222,
                  ),
                ),
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
}
