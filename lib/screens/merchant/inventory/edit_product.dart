import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/primary_button.dart';
import 'package:tara_app/controller/inventory_controller.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:get/get.dart';
import 'package:tara_app/screens/merchant/inventory/single_product_field.dart';
import '../../../common/widgets/extensions.dart';

class EditProduct extends StatefulWidget {
  final Item item;

  const EditProduct({Key key, this.item}) : super(key: key);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends BaseState<EditProduct> {
  InventoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _buildAppBar(context),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 80,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    isPrimary: false,
                    text: "Cancel",
                    onTap: () => Get.back(),
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: PrimaryButton(
                    text: "Save Changes",
                    onTap: () => controller.editItems([widget.item]),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            SingleProductField(
              tempItem: widget.item,
              editingItem: true,
            )
          ],
        ),
      ).withProgressIndicator(showIndicator: controller.showProgress.value),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
          ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Edit Product",
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
