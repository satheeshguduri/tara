import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/counter_button.dart';
import 'package:tara_app/screens/consumer/shop/product_details_page.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/values.dart';
import '../../../common/widgets/extensions.dart';
import 'package:get/get.dart';

class ProductItemHP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 48,
          height: 48,
          child: Placeholder(),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tomat Merah (100gr)",
              style: TextStyles.body2222,
            ),
            Text(
              "Price / 100gr",
              style: TextStyle(
                  color: AppColors.input_field_line_off_2_2_2, fontSize: 12),
            ),
            Text("Rp 5.300 - 6.600", style: TextStyles.subtitle3222)
          ],
        )
      ],
    );
    return ListTile(
      leading: SizedBox(
        width: 48,
        height: 48,
        child: Placeholder(),
      ),
      title: Text(
        "Tomat Merah (100gr)",
        style: TextStyles.body2222,
      ),
      trailing: Container(
        width: 0,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price / 100gr",
            style: TextStyle(
                color: AppColors.input_field_line_off_2_2_2, fontSize: 12),
          ),
          Text("Rp 5.300 - 6.600", style: TextStyles.subtitle3222),
        ],
      ),
    );
    // return Card(
    // elevation: 2,
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    // child: InkWell(
    //   onTap: () => Get.to(ProductDetailsPage()),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 96,
    //         child: Stack(
    //           children: [
    //             Placeholder(),
    //             Positioned(
    //               right: 8,
    //               top: 8,
    //               child: ValueBuilder<bool>(
    //                   initialValue: false,
    //                   onUpdate: (value) => print("Value updated: $value"),
    //                   onDispose: () => print("Widget unmounted"),
    //                   builder: (value, updateFn) {
    //                     return Material(
    //                       elevation: 2,
    //                       borderRadius: BorderRadius.circular(24),
    //                       child: CircleAvatar(
    //                         radius: 16,
    //                         backgroundColor: Colors.white,
    //                         child: InkWell(
    //                           onTap: () => updateFn(!value),
    //                           child: Icon(value
    //                               ? Icons.favorite
    //                               : Icons.favorite_border),
    //                         ),
    //                       ),
    //                     );
    //                   }),
    //             )
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         height: 16,
    //       ),
    //       Text(
    //         "Short Plate Sliced Beef(250 gr)",
    //         maxLines: 2,
    //         overflow: TextOverflow.ellipsis,
    //         style: TextStyles.body2222,
    //       ),
    //       SizedBox(
    //         height: 12,
    //       ),
    //       Text(
    //         "Price / 250gr",
    //         style: TextStyle(
    //             fontSize: 12, color: AppColors.input_field_line_off_2_2_2),
    //       ),
    //       Text(
    //         "Rp 36.500-37.600",
    //         style: TextStyles.subtitle3222,
    //       ),
    //       Spacer(),
    //       SizedBox(
    //         height: 42,
    //         child: Counter(
    //           onChange: (count) {},
    //         ),
    //       )
    //     ],
    //   ).all(12),
    // ),
    // );
  }
}
