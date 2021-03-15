import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';


class ShopAddItem extends StatefulWidget {

  final Function saveItem;
  final OrderItems editItem;

  ShopAddItem({Key key,this.saveItem, this.editItem}) : super(key: key);

  @override
  _ShopAddItemState createState() => _ShopAddItemState();
}

class _ShopAddItemState extends BaseState<ShopAddItem> {
  // TextEditingController nameTextController = TextEditingController();
  TextEditingController qntyTextController = TextEditingController();
  FocusNode amountFocusNode = new FocusNode();

  String pcs;
  List<String> arrUnits = ["Kgs","Grms","Pcs","Ltrs"];

  OrderController controller = Get.find();

  @override
  BuildContext getContext() {
    return context;
  }
  @override
  void init() {
    // TODO: implement init
    super.init();
    if (widget.editItem != null) {
      controller.nameTextController.value.text = widget.editItem.name;
      qntyTextController.text = widget.editItem.quantity.toString();
      pcs = widget.editItem.metric;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Color(0x99123456),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x1f000000),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: 0),
                      BoxShadow(
                          color: const Color(0x14000000),
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 0)
                    ],
                    color: AppColors.primaryBackground),
                child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 4, bottom: 16),
                      alignment: Alignment.center,
                      child: Container(
                          width: 53,
                          height: 4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: AppColors.light_grey_bg_color)),
                    ),
                    Text("Add item", style: TextStyles.headline6222),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 6,
                          child: textFormFieldContainer(
                              headerTitle: "Item Name",
                              hint: "Enter item name",
                              inputType: TextInputType.text,
                              textEditingController:
                                  controller.nameTextController.value,
                              focusNode: null),
                        ),
                        Expanded(
                          flex: 4,
                          child: textFormFieldContainer(
                              headerTitle: "Quantity",
                              hint: "100",
                              inputType: TextInputType.number,
                              textEditingController: qntyTextController,
                              focusNode: amountFocusNode),
                        ),
                      ],
                    ),
                    _getConfirmWidget()
                  ],
                ),
              ),
            )));
  }

  Widget _getDropDownList() {
    return Container(
      child: DropdownButton(
        value: pcs,
        isExpanded: true,
        icon: getSvgImage(
            imagePath: Assets.assets_icon_a_arrow_down,
            width: 24.0,
            height: 24.0),
        hint: Text("units"),
        underline: Container(),
        onChanged: (String val) {
          setState(() {
            pcs = val;
          });
        },
        items: _getDropdownItems(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    return arrUnits.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyles.subtitle1222),
            ],
          ),
        ),
        value: value,
      );
    }).toList();
  }

  Widget _getConfirmWidget() {
    return Obx(() => Container(
          height: 48,
          margin: EdgeInsets.only(
            bottom: 16,
            top: 36,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: controller.nameTextController.value.text.isEmpty
                  ? Color(0xffe9ecef)
                  : Color(0xffb2f7e2)),
          //(
          // nameTextController.text.toString().isNotEmpty&&qntyTextController.text.toString().isNotEmpty && pcs != null)
          // ?Color(0xffb2f7e2):Color(0xffe9ecef)
          // ),
          alignment: Alignment.center,
          child: Text(getTranslation(Strings.save_item),
              textAlign: TextAlign.center,
              style: BaseStyles.chatItemDepositSuccessMoneyTextStyle
              // (nameTextController.text.toString().isNotEmpty&&qntyTextController.text.toString().isNotEmpty && pcs != null)?BaseStyles.chatItemDepositSuccessMoneyTextStyle:BaseStyles.verifyTextStyle,
              ),
        ).onTap(onPressed: () {
          if (controller.nameTextController.value.text.isNotEmpty) {
            print("on tap working");
            //  if (nameTextController.text.toString().isNotEmpty&&qntyTextController.text.toString().isNotEmpty && pcs != null){
            if (widget.editItem != null) {
              print("first condition");
              // update item
              var item = controller.items
                  .where((element) => element.name == widget.editItem.name)
                  .first;
              item.name = controller.nameTextController.value.text;
              item.quantity = int.parse(qntyTextController.text);
              item.metric = pcs;
            } else {
              print("second condition");
              var item = OrderItems();
              item.name = controller.nameTextController.value.text;
              // item.quantity = int.parse(qntyTextController.text);
              item.quantity = 100;
              item.metric = pcs;
              controller.items.add(item);
            }
            widget.saveItem();
            Get.back();
          } else {}
          // }
        }));
  }

  @override
  void initState() {
    super.initState();
    addListenersToRequiredTextField();
  }

  void addListenersToRequiredTextField() {
    amountFocusNode.addListener(() {
      bool hasFocus = amountFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  Widget textFormFieldContainer(
      {String headerTitle,
      String hint,
      TextInputType inputType,
      TextEditingController textEditingController,
      FocusNode focusNode}) {
    return Container(
        margin: EdgeInsets.only(top: 8, right: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              //                   <--- left side
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4, bottom: 4),
                child: Text(headerTitle,
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFieldWidget(
                        hint: hint,
                        hintColor: Colors.blue,
                        inputType: inputType,
                        textController: textEditingController,
                        isIcon: false,
                        focusNode: focusNode,
                        onChanged: (value) {
                          controller.nameTextController.refresh();
                        },
                        onFieldSubmitted: (value) {
                          amountFocusNode.requestFocus();
                        },
                      ),
                    ),
                    headerTitle == "Quantity"
                        ? Expanded(
                            flex: 7,
                            child: _getDropDownList(),
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
