import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/widgets/handle.dart';
import 'package:tara_app/screens/consumer/shop/products_by_categories.dart';

import '../../../common/constants/strings.dart';
import '../../../common/constants/styles.dart';
import '../../base/base_state.dart';
import '../../../common/widgets/extensions.dart';

///TODO hard coded text have to be changed with the localized language

class AllCategorySheet extends StatefulWidget {
  @override
  _AllCategorySheetState createState() => _AllCategorySheetState();
}

class _AllCategorySheetState extends BaseState<AllCategorySheet> {
  final List<String> categories = [
    "Fresh Veggie",
    "Fresh Fruits",
    "Meat & Seafood",
    "Organic",
    "Medicine"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Handle(),
            ).horizontalPad(16),
            Text("All Categories", style: TextStyles.headline62),
            GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: categories
                  .map((e) => InkWell(
                        onTap: () => pushReplacement(ProductsByCategory(
                          screenTitle: e,
                        )),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ).all(16),
      ),
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
