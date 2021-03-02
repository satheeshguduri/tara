import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/counter_button.dart';
import 'package:tara_app/controller/cart_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/screens/consumer/shop/product_details_page.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/values.dart';
import '../../../common/widgets/extensions.dart';
import 'package:get/get.dart';
import 'package:tara_app/models/order_management/item/item.dart';

class ProductItem extends StatelessWidget {
  final Item p;

  const ProductItem(this.p);

  @override
  Widget build(BuildContext context) {
    var controller = getIt.get<CartController>();
    return Card(
      // elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Get.to(ProductDetailsPage(p)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 96,
              width: double.maxFinite,
              child: Stack(
                children: [
                  // temp image
                  Image.network(
                    "https://picsum.photos/200/300",
                    fit: BoxFit.fill,
                    width: double.maxFinite,
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: ValueBuilder<bool>(
                        initialValue: p.favouriteItem ?? false,
                        onUpdate: (value) => print("Value updated: $value"),
                        onDispose: () => print("Widget unmounted"),
                        builder: (value, updateFn) {
                          return Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(24),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                onTap: () => updateFn(!value),
                                child: Icon(
                                  value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 18,
                                  color: AppColors.black100,
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${p.itemName}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.body2222,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "${p.description}",
              style: TextStyle(
                  fontSize: 12, color: AppColors.input_field_line_off_2_2_2),
            ),
            Text(
              "Rp ${p.price}",
              style: TextStyles.subtitle3222,
            ),
            Spacer(),
            SizedBox(
              height: 36,
              child: Obx(
                () => Counter(
                  p,
                  title: "+ Add",
                  maxCount: p.quantityInStock,
                  errorMessage: "Limited Stock",
                  initialCount: controller.cart[p.id]?.quantity ?? 0,
                  onChange: (count) {},
                ),
              ),
            )
          ],
        ).all(12),
      ),
    );
  }
}
