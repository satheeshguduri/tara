import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/primary_button.dart';
import 'package:tara_app/controller/inventory_controller.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:get/get.dart';
import 'package:tara_app/screens/merchant/inventory/single_product_field.dart';

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends BaseState<AddNewProduct> {
  InventoryController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.items.clear();
    controller.addItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryText,
        mini: true,
        onPressed: () => controller.addItem(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              SizedBox(
                width: 17,
              ),
              Expanded(
                child: PrimaryButton(
                  text: "Add Products",
                  onTap: () => controller.addProducts(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SingleProductField(
                tempItem: controller.items[i],
                editingItem: false,
              ),
            );
          },
          // itemCount: controller.productsController.length,
          itemCount: controller.items.length,
        ),
      ),
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
          "Add Product",
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
