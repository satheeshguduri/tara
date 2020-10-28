import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/shop/shop_add_item.dart';

class MakeAnOrder extends StatefulWidget {
  @override
  _MakeAnOrderState createState() => _MakeAnOrderState();
}

class _MakeAnOrderState extends BaseState<MakeAnOrder> {
  List<DeliveryType> arrDeliveryType = List<DeliveryType>();
  DeliveryType deliveryType;
  List<ShopItem> arrShopItem = List<ShopItem>();

  bool isEdit = false;
  int selectedSegmentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arrDeliveryType.add(DeliveryType(
        "In-house Delivery", "Delivery fee might vary from each merchant."));
    arrDeliveryType.add(DeliveryType(
        "Others (Gojek/Grab)", "Pay the delivery once the order arrived."));
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff7f7fa),
      appBar: _buildAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getDeliveryOption(),
              _getItemList(),
              _getSaveAsShoppingList()
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: Visibility(
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.make_an_order),
          style: TextStyles.headline6222,
        ),
      ),
    );
  }

  _getDeliveryOption() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 16, bottom: 16),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getTranslation(Strings.delivery_option), style: TextStyles.subtitle1222),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 48,
            decoration: BoxDecoration(
                borderRadius: Radii.border(24), color: const Color(0xfff7f7f7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 160,
                  decoration: selectedSegmentIndex == 0 ? _getShadow() : null,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.ic_van),
                        Text(getTranslation(Strings.delivery),
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        selectedSegmentIndex = 0;
                      });
                    },
                  ),
                ),
                Container(
                  height: 40,
                  width: 160,
                  decoration: selectedSegmentIndex == 1 ? _getShadow() : null,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.ic_bag,
                          width: 24,
                        ),
                        Text(getTranslation(Strings.pickup),
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        selectedSegmentIndex = 1;
                      });
                    },
                  ),


                )
              ],
            ),
          ),
          Text(getTranslation(Strings.delivery_to), style: TextStyles.caption222),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 16),
            padding: EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
            decoration: BoxDecoration(
                borderRadius: Radii.border(8),
                border:
                    Border.all(color: AppColors.light_grey_bg_color, width: 1),
                color: Colors.white),
            child: Row(
              children: <Widget>[
                Image.asset(Assets.ic_location),
                Expanded(
                  flex: 7,
                  child: Text(
                      "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …",
                      style: TextStyles.body2222),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(getTranslation(Strings.CHANGE),
                          style: TextStyles.bUTTONBlack222,
                          textAlign: TextAlign.center),
                      Container(
                          width: 63,
                          height: 2,
                          decoration:
                              BoxDecoration(color: AppColors.pale_turquoise))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            getTranslation(Strings.prefered_delivery),
            style: TextStyles.caption222,
          ),
          _getDropDownList(),
//          Container(
//              margin: EdgeInsets.only(top: 4,bottom: 16),
//              height: 1,
//              decoration: BoxDecoration(color: Color(0xffb0b4c1)))
        ],
      ),
    );
  }

  _getDropDownList() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 16),
      child: DropdownButton(
        value: deliveryType,
        isExpanded: true,
        icon: Container(),
        underline: Container(),
//      itemHeight: 60,
        onChanged: (val) {
          setState(() {
            deliveryType = val;
          });
        },
        items: _getDropdownItems(),
      ),
    );
  }

  _getItemList() {
    if (arrShopItem != null && arrShopItem.length > 0) {
      return _getShopItemList();
    }
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        bottom: 16,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(getTranslation(Strings.item_list), style: TextStyles.subtitle1222),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 16, top: 16),
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                      borderRadius: Radii.border(44),
                      color: AppColors.light_grey_blue)),
              Text(getTranslation(Strings.start_item_list),
                  style: const TextStyle(
                      color: AppColors.fareColor,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.center),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16, top: 16),
                    height: 32,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: Radii.border(8),
                        border: Border.all(
                            color: AppColors.light_grey_blue, width: 1),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.ic_plus),
                        Text(
                          getTranslation(Strings.add_item),
                          style: TextStyles.bUTTONBlack222,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    // show bottom sheet
                    _showAddItemBottomSheet();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getDropdownItems() {
    return arrDeliveryType
        .map<DropdownMenuItem<DeliveryType>>((DeliveryType value) {
      return DropdownMenuItem(
        child: Container(
//          margin: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value.title, style: TextStyles.subtitle1222),
              Text(value.subTitle, style: BaseStyles.saveToMyContactTextStyle),
              Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4),
                  height: 1,
                  decoration: BoxDecoration(color: Color(0xffb0b4c1)))
            ],
          ),
        ),
        value: value,
      );
    }).toList();
  }

  _getSaveAsShoppingList() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
        child: Column(children: [
          Row(
            children: [
              Image.asset(Assets.ic_check_quare),
              Container(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(getTranslation(Strings.save_as_shoping_list), style: TextStyles.subtitle1222),
                  Container(
                    height: 4,
                  ),
                  Text(getTranslation(Strings.save_for_re_order),
                      style: BaseStyles.saveToMyContactTextStyle)
                ],
              ),
            ],
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 16, bottom: 8),
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: Radii.border(8),
                  color: arrShopItem.length > 0 ? AppColors.pale_turquoise : AppColors.light_grey_bg_color),
              child: Text(
                getTranslation(Strings.place_order),
                style: arrShopItem.length > 0 ? TextStyles.bUTTONBlack222 : TextStyles.bUTTONGrey3222,
              ),
            ),
            onTap: (){
             if (arrShopItem.length > 0 ){
               pop();
             }
            },
          )
        ]));
  }

  _getShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
        color: Colors.white);
  }

  _showAddItemBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ShopAddItem(
            saveItem: (item) {
              setState(() {
                arrShopItem.add(item);
              });
            },
          );
        });
  }

  _getShopItemList() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8, bottom: 16),
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
//                  flex: 8,
                  child: Text(getTranslation(Strings.item_list), style: TextStyles.subtitle1222),
                ),
                Container(
//                  flex: 2,
                  child: InkWell(
                    child: Column(
                      children: [
                        Text(isEdit ?getTranslation(Strings.Done).toUpperCase() : getTranslation(Strings.edit),
                            style: TextStyles.subtitle1222),
                        Container(
                            width: 29,
                            height: 2,
                            decoration:
                                BoxDecoration(color: AppColors.pale_turquoise))
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        if (isEdit) {
                          isEdit = false;
                        } else {
                          isEdit = true;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: arrShopItem.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(arrShopItem[index].title,
                                    style: TextStyles.body2222),
                                Text(arrShopItem[index].qty,
                                    style: BaseStyles.sentOtpTextStyle)
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              height: 1,
                              color: AppColors.light_grey_bg_color,
                            )
                          ],
                        ),
                      ),
                      isEdit
                          ? Container(
                              width: 96,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppColors.fareColor,
                                    ),
                                    onPressed: () {
                                      _showAddItemBottomSheet();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.badge_color,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        arrShopItem.removeAt(index);
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              }),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.only(bottom: 16, top: 16),
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: Radii.border(8),
                    border:
                        Border.all(color: AppColors.light_grey_blue, width: 1),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.ic_plus),
                    Text(
                      getTranslation(Strings.add_item),
                      style: TextStyles.bUTTONBlack222,
                    )
                  ],
                ),
              ),
              onTap: () {
                // show bottom sheet
                _showAddItemBottomSheet();
              },
            ),
          )
        ],
      ),
    );
  }
}

class DeliveryType {
  final String title;
  final String subTitle;

  DeliveryType(this.title, this.subTitle);
}

class ShopItem {
  String title;
  String qty;
}