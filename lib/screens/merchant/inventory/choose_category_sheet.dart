import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/handle.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/widgets/primary_button.dart';
import 'package:tara_app/controller/category_sheet_controller.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';
import 'package:tara_app/screens/base/base_state.dart';

class ChooseCategorySheet extends StatefulWidget {
  final List<Category> previouslySelected;

  const ChooseCategorySheet({Key key, this.previouslySelected})
      : super(key: key);
  @override
  _ChooseCategorySheetState createState() => _ChooseCategorySheetState();
}

class _ChooseCategorySheetState extends BaseState<ChooseCategorySheet> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: CategorySheetController(widget.previouslySelected),
        builder: (CategorySheetController controller) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: Colors.white,
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    Align(
                      child: Handle(),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Choose Category",
                      style: TextStyles.headline6222,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    createSearchBar(controller),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.light_grey_bg_color,
                    ),
                    createCategories(controller),
                    // buildCategories(controller),
                    Divider(
                      height: 1,
                      color: AppColors.light_grey_blue,
                    ),
                    Container(
                      height: 80,
                      child: PrimaryButton(
                        text: "Save",
                        onTap: () => controller.save(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Container createSearchBar(CategorySheetController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.color_black_80_2),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.color_black_80_2,
            // size: 12,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Theme(
              data: ThemeData(),
              child: TextField(
                cursorColor: AppColors.black90,
                onChanged: controller.filter,
                decoration: InputDecoration.collapsed(
                    hintText: "Search Category", border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  createCategories(CategorySheetController controller) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (_, i) {
          Category c = controller.duplicateMap.keys.toList()[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: InkWell(
              onTap: () => controller.negativeCategory(c),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.name,
                    style: TextStyles.subtitle1222.copyWith(
                      fontWeight: controller.selectedCategories[c]
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  if (controller.selectedCategories[c])
                    Container(
                      width: 36,
                      child: getSvgImage(
                          imagePath: Assets.assets_icon_c_check_outline),
                    )
                ],
              ),
            ),
          );
        },
        itemCount: controller.duplicateMap.keys.length,
      ),
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
