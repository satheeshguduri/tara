import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/counter_button.dart';
import 'package:tara_app/screens/consumer/shop/product_details_page.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/values.dart';
import '../../../common/widgets/extensions.dart';
import 'package:get/get.dart';

class ProductItemH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: Placeholder(),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tomat Merah (100gr)",
                style: TextStyles.body2222.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Price / 100gr",
                style: TextStyle(
                    color: AppColors.input_field_line_off_2_2_2, fontSize: 12),
              ),
              SizedBox(
                height: 2,
              ),
              Text("Rp 5.300 - 6.600", style: TextStyles.subtitle3222),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
        SizedBox(
          height: 30,
          width: 124,
          child: Counter(
            initialCount: 1,
            onChange: (count) {},
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
