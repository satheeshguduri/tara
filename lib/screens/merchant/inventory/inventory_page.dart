import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/underline_text.dart';
import 'package:tara_app/controller/inventory_controller.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/merchant/inventory/add_new_product.dart';
import 'package:tara_app/screens/merchant/inventory/edit_product.dart';
import '../../../common/widgets/extensions.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends BaseState<InventoryPage> {
  StoreController storeController = Get.put(StoreController());
  InventoryController controller = Get.find();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    storeController.getCategories();
    storeController.getCatalogue();
    controller.getProducts();

    // pagination
    paginate();
  }

  void paginate() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) controller.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product List",
                  style: TextStyles.headline6222,
                ),
                InkWell(
                  onTap: () => Get.to(AddNewProduct()),
                  child: UnderlineText(
                    text: Text(
                      "+ ADD PRODUCT",
                      style: TextStyles.subtitle3222,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: buildProductList())
        ],
      ),
    );
  }

  buildProductList() {
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (_, i) {
          return buildInventoryItem(controller.inventoryItems[i]);
        },
        itemCount: controller.inventoryItems.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          thickness: 1,
          height: 1,
          color: AppColors.light_grey_bg_color,
        ),
      ).withProgressIndicator(showIndicator: controller.showProgress.value);
    });
  }

  Padding buildInventoryItem(
    Item item,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Placeholder(),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  "${item.itemName}",
                  style: TextStyles.bUTTONSmallBlack222,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "${item.category.length > 0 ? item.category[0].name: "-NA-"}",
                  style: TextStyles.caption222,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Stock : ${item.quantityInStock}",
                  style: TextStyles.bUTTONSmallBlack222
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Text(
            "Rp ${item.price}",
            style: TextStyles.subtitle3222,
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () => Get.to(EditProduct(
              item: item,
            )),
            borderRadius: BorderRadius.circular(2),
            splashColor: AppColors.primaryText.withOpacity(0.2),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: getSvgImage(
                  imagePath: Assets.assets_icon_e_edit,
                  height: 16.0,
                  width: 16.0),
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.color_black_80_2)),
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
                          decoration: InputDecoration.collapsed(
                              hintText: "Search items",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
        preferredSize: Size.fromHeight(55),
      ), // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
          ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Inventory",
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
