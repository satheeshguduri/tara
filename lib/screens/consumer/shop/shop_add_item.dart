import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/shop/make_an_order.dart';
import 'package:tara_app/utils/locale/utils.dart';

class ShopAddItem extends StatefulWidget {

  final Function saveItem;

  ShopAddItem({Key key,this.saveItem}) : super(key: key);

  @override
  _ShopAddItemState createState() => _ShopAddItemState();
}

class _ShopAddItemState extends BaseState<ShopAddItem> {

  TextEditingController amountTextController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();

  FocusNode amountFocusNode = new FocusNode();

  String pcs;
  List<String> arrPcs = ["1","2","3","4","5","6","7","8","9","10"];

  @override
  BuildContext getContext() {
    return context;
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
            child:Container(
              width: MediaQuery.of(context).size.width*0.90,
              child: Container(
                padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
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
                      margin: EdgeInsets.only(top: 4,bottom: 16),
                      alignment: Alignment.center,
                        child: Container(width: 53,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)
                                ),
                                color: AppColors.light_grey_bg_color
                            )),
                    ),
                    Text(
                        "Add item",
                        style: TextStyles.headline6222
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 7,
                          child:textFormFieldContainer("Item Name","Enter item name",TextInputType.text,amountTextController,amountFocusNode),
                        ),
                        Expanded(
                          flex: 3,
                          child:textFormFieldContainer("Quantity","100",TextInputType.number,messageTextController,null),
                        ),
                      ],
                    ),
                    _getConfirmWidget()
                  ],
                ),
              ),
            )
        )
    );
  }

  _getDropDownList() {
    return Container(
      child: DropdownButton(
        value: pcs,
        isExpanded: true,
        icon: Image.asset(Assets.ic_dropdown),
        hint: Text("Pcs"),
        underline: Container(),
        onChanged: (val) {
          setState(() {
            pcs = val;
          });
        },
        items: _getDropdownItems(),
      ),
    );
  }
  _getDropdownItems() {
    return arrPcs
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyles.subtitle1222),],
          ),
        ),
        value: value,
      );
    }).toList();
  }

  _getConfirmWidget() {
    return InkWell(
      onTap: () {
        var shopItem = ShopItem();
        shopItem.title = "Nanas";
        shopItem.qty = "10";
        widget.saveItem(shopItem);
        Navigator.of(context).pop();
      },
      child:  Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 36,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: (amountTextController.text.toString().isNotEmpty&&messageTextController.text.toString().isNotEmpty)?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.save_item),
          textAlign: TextAlign.center,
          style: (amountTextController.text.toString().isNotEmpty&&messageTextController.text.toString().isNotEmpty)?BaseStyles.chatItemDepositSuccessMoneyTextStyle:BaseStyles.verifyTextStyle,
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    addListenersToRequiredTextField();
  }

  addListenersToRequiredTextField() {
    amountFocusNode.addListener(() {
      bool hasFocus = amountFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController,FocusNode focusNode)
  {
    return Container(
        margin: EdgeInsets.only(top:8,right: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide( //                   <--- left side
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
                margin: EdgeInsets.only(top: 4,bottom: 4),
                child: Text(
                    headerTitle,
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){
                        setState(() {

                        });
                      }),
                    ),
                    headerTitle == "Quantity" ?
                    Expanded(
                      flex: 6,
                      child: _getDropDownList(),
                    ) : Container()
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}