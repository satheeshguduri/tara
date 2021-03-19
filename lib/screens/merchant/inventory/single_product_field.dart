import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/controller/inventory_controller.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/services/util/image_picker_helper.dart';

import 'choose_category_sheet.dart';

///TODO left single item validation

class SingleProductField extends StatefulWidget {
  // final int index;
  final Item tempItem;
  final bool editingItem;

  const SingleProductField({Key key, this.tempItem, this.editingItem})
      : super(key: key);
  @override
  _SingleProductFieldState createState() => _SingleProductFieldState();
}

class _SingleProductFieldState extends BaseState<SingleProductField> {
  InventoryController _controller = Get.find();
  // ProductController _productController;

  @override
  void initState() {
    super.initState();
    // _productController = Get.put(ProductController(widget.tempItem),tag: widget.tempItem.hashCode.toString());
    //set the controller if the product is in edit mode
    var item = widget.tempItem;
    nameController.text = item.itemName ?? "";
    priceController.text = (item.price ?? "").toString();
    stockController.text = (item.quantityInStock ?? "").toString();
    selectedCategory.value = item.category ?? [];
    categoryController.text =
        item?.category?.map((e) => e.name)?.join(", ") ?? "";
  }

  var isImageSelected = false;
  var filePath = "";

  var selectedCategory = [].cast<Category>().obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDeleteButton(),
          SizedBox(
            height: 5,
          ),
          _buildUploadImgContainer(),
          SizedBox(
            height: 17,
          ),
          _buildField("Product Name", "Enter Product Name",
              controller: nameController, onChanged: (s) {
            widget.tempItem.itemName = s;
          }),
          SizedBox(
            height: 17,
          ),
          Row(
            children: [
              Expanded(
                  child: _buildField("Price", "Enter Price",
                      inputType: TextInputType.number,
                      controller: priceController, onChanged: (s) {
                widget.tempItem.price = double.tryParse(s);
              })),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: _buildField("Stock", "Enter Stock",
                      inputType: TextInputType.number,
                      controller: stockController, onChanged: (s) {
                widget.tempItem.quantityInStock = int.tryParse(s);
              })),
            ],
          ),
          SizedBox(
            height: 17,
          ),
          _buildField(
            "Category",
            "Select Category",
            suffixIcon: getSvgImage(
              imagePath: Assets.assets_icon_a_arrow_down,
            ),
            controller: categoryController,
            focusNode: new AlwaysDisabledFocusNode(),
            onTap: () => chooseCategory(),
          )
        ],
      ),
    );
  }

  _buildUploadImgContainer() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.light_grey_bg_color, width: 1)),
        padding: EdgeInsets.only(bottom: 12, left: 8, right: 8, top: 6),
        child: Row(
          children: [
            Container(
                width: 112,
                height: 114,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: isImageSelected
                          ? _buildImageView()
                          : _buildEmptyImageView(),
                    ),
                    if (isImageSelected) buildCrossIcon()
                  ],
                )),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload product photo",
                  style: TextStyles.subtitle1222,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 156),
                  child: Text(
                    "Minimum photo size is 120 x 120 px",
                    style: BaseStyles.sentOtpTimeTextStyle
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),

    );
  }

  Positioned buildCrossIcon() {
    return Positioned(
      right: 0,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onRemoveImage(),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: getSvgImage(imagePath: Assets.close_icon),
            ),
          ),
        ),
      ),
    );
  }

  _buildEmptyImageView() {
    return InkWell(
      onTap: () => uploadImage(),
      child: DottedBorder(
        radius: Radius.circular(56),
        dashPattern: [3, 1],
        // color: Colors.red,
        // strokeCap: StrokeCap.round,
        color: AppColors.light_grey_blue,
        padding: EdgeInsets.zero,
        child: Container(
          height: 104,
          width: 104,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(8),
            color: AppColors.light_grey_bg_color,
          ),
          child: CircleAvatar(
            radius: 28,
            child: getSvgImage(
                imagePath: Assets.assets_icon_p_product_photo,
                width: 36.0,
                height: 36.0),
          ),
        ),
      ),
    );
  }

  Container _buildImageView() {
    return Container(
      height: 104,
      width: 104,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.light_grey_blue)),
      child: Image.file(File(filePath)),
    );
  }

  Align _buildDeleteButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          highlightColor: Colors.pink.withOpacity(0.1),
          splashColor: Colors.pink.withOpacity(0.2),
          onTap: () => widget.editingItem
              ? _controller.removeItem([widget.tempItem])
              : _controller.deleteEmptyItem(widget.tempItem),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getSvgImage(
                    imagePath: Assets.assets_icon_t_trash,
                    color: Colors.pink,
                    height: 16.0,
                    width: 16.0),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "DELETE",
                  style: TextStyles.bUTTONSmallRed2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }

  _buildField(String text, String hint,
      {TextInputType inputType,
      VoidCallback onTap,
      bool enabled,
      TextEditingController controller,
      Widget suffixIcon,
      FocusNode focusNode,
      onChanged(String s)}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$text",
          style: TextStyles.bUTTONSmallBlack222,
        ),
        TextField(
          keyboardType: inputType ?? TextInputType.text,
          onTap: onTap,
          controller: controller,
          enabled: enabled ?? true,
          focusNode: focusNode,
          onChanged: onChanged,
          decoration: InputDecoration(hintText: "$hint", suffix: suffixIcon),
        ),
      ],
    );
  }

  //TODO Search in categories
  // for showing the choose category sheet and return the list of the selected categories
  void chooseCategory() async {
    List<Category> lc = await Get.bottomSheet(
      ChooseCategorySheet(
        // previously selected category if exist
        previouslySelected: selectedCategory.value,
      ),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
    if (lc != null)
      categoryController.text = lc.map((e) => e.name).toList().join(', ');
  }

  uploadImage() {
    // method for taking image from the camera and returns the path
    ImagePickerHelper.takeImageFromCamera().then((value) {
      if (value != null) {
        isImageSelected = true;
        filePath = value;
        setState(() {});
      }
    });
  }

  onRemoveImage() {
    isImageSelected = false;
    filePath = "";
    setState(() {});
  }
}

///Disabling the focus on text field, but still make the onTap function work
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
