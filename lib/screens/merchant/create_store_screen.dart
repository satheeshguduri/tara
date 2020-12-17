import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/create_store_and_owner_controller.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/utils/locale/utils.dart';

class CreateStoreScreen extends StatefulWidget {
  CreateStoreScreen({
    Key key,
  }) : super(key: key);

  @override
  _CreateStoreScreenState createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends BaseState<CreateStoreScreen> {

  CreateStoreAndOwnerController controller = Get.find();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void init() {
    super.init();
    controller.createOwner();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: getRootContainer(),
    );
  }

  Widget getRootContainer() {
    return Obx(() => SafeArea(
        child: SingleChildScrollView(
          child: getAllWidgets(),
        )).withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.6,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            controller.errorMessage.value = "";
            pushAndRemoveUntil(Utils().getLandingScreen());
          }
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.complete_profile),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  Widget getAllWidgets() {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8,top: 16,left:16),
          child:Text(
              "4 of 4",
              style: BaseStyles.chatItemResendOtpButtonTextStyle
          ),
        ),
        shopDetailsTitleWidget(),
        textFormFieldContainer(
          getTranslation(Strings.shop_name),
          getTranslation(Strings.enter_full_name),
          controller.storeNameTextController,
          inputType:TextInputType.text,
        ),
        textFormFieldContainer(getTranslation(Strings.shop_category),"",null,inputType:TextInputType.text),
        textFormFieldContainer(getTranslation(Strings.shop_address),getTranslation(Strings.enter_address),controller.addressTextController,maxLines: 3,
            inputType:TextInputType.multiline),
        Container(
          margin: EdgeInsets.only(top: 16,left:16,right: 16),
          padding: EdgeInsets.only(left: 8, bottom: 8, top: 8, right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Color(0xffe9ecef), width: 1),
              color: Color(0xffffffff)),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7.5.toInt(),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          Assets.ic_location,
                          fit: BoxFit.none,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            controller.addressStr.value,
                            style: BaseStyles.bottomSheetLocationStyle,
                            maxLines: 3,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2.5.toInt(),
                  child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        children: [
                          Text(getTranslation(Strings.CHANGE),
                              style: BaseStyles
                                  .bottomSheetLocationChangeTextStyle,
                              textAlign: TextAlign.center),
                          Container(
                            height: 2,
                            margin:
                            EdgeInsets.only(top: 4, left: 8, right: 8),
                            decoration: BoxDecoration(
                              gradient: Gradients.primaryGradient,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        controller.errorMessage.value.isEmpty
            ? Container()
            : Container(margin:EdgeInsets.only(top: 16,left: 16),child: Text(
          getTranslation(controller.errorMessage.value),
          style: BaseStyles.error_text_style,
        ),),
        saveAndContinueWidget()
      ],
    );
  }

  Widget getStoreTypes()
  {
    return FutureBuilder<List<StoreTypeModel>>(
        future: controller.getAllStoreTypes(),
        builder: buildShopCategories);
  }

  Widget buildShopCategories(
      BuildContext context, AsyncSnapshot<List<StoreTypeModel>> snapshot) {
    Text text = const Text('Select Category');
    if (snapshot.hasData) {
      return getDropDownList();
    }
    return Container(margin: EdgeInsets.only(top: 16, bottom: 16), child: text);
  }

  Widget getDropDownList() {
    return DropdownButton<StoreTypeModel>(
      icon: Image.asset(Assets.ic_dropdown,width: 18,),
      value: controller.selectedStoreType.value,
      style: BaseStyles.subHeaderTextStyle,
      underline: Container(),
      onChanged: (val) {
        controller.selectedStoreType.value = val;
      },
      items: controller.storeTypes
          .map<DropdownMenuItem<StoreTypeModel>>((StoreTypeModel storeTypeModel) {
        return DropdownMenuItem<StoreTypeModel>(
          child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  Text(
                    storeTypeModel.type,
                    style: BaseStyles.subHeaderTextStyle,
                    textAlign: TextAlign.left,
                  )
                ],
              )),
          value: storeTypeModel,
        );
      }).toList(),
    );
  }

  Widget shopDetailsTitleWidget() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      height: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            child: Container(
              height: 16,
              width: 85,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: AppColors.bottom_border_color,
              ),
              child: Container(),
            ),
          ),
          Positioned(
            top: 0.0,
            child: Container(
              child: Text(
                getTranslation(Strings.shop_details),
                textAlign: TextAlign.left,
                style: BaseStyles.bankAccountHeaderTitleStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onChanged(TextEditingController textEditingController) {
    controller.errorMessage.value = "";
    controller.isEnterAllTheFieldsInCreateStore();
  }

  Widget textFormFieldContainer(
      String headerTitle,
      String hint,
      TextEditingController textEditingController, {
        bool isSecureText = false,
        bool enableInteractiveSelection = false,
        placeHolderStyle: BaseStyles.subHeaderTextStyle,
        int maxLines = 1,
        TextInputType inputType = TextInputType.text,
      }) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 16,right: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          color: Colors.transparent,
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
                      flex: 1,
                      child: textEditingController==null?(!GetUtils.isNullOrBlank(controller.selectedStoreType.value.type))?
                      getDropDownList():getStoreTypes():TextFieldWidget(
                          placeHolderStyle: placeHolderStyle,
                          enableInteractiveSelection:
                          enableInteractiveSelection,
                          isObscure: isSecureText,
                          hint: hint,
                          inputType: inputType,
                          textController: textEditingController,
                          isIcon: false,
                          onChanged: (value) {
                            onChanged(textEditingController);
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }



  Widget saveAndContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16, top: 36, left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: controller.isEnterTheFieldsInCreateStore.value
              ? Color(0xffb2f7e2)
              : Color(0xffe9ecef)),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.save_and_continue),
        textAlign: TextAlign.center,
        style: controller.isEnterTheFieldsInCreateStore.value
            ? BaseStyles.chatItemDepositSuccessMoneyTextStyle
            : BaseStyles.verifyTextStyle,
      ),
    ).onTap(onPressed: () {
      if(controller.isEnterTheFieldsInCreateStore.value)
      {
        controller.createStore();
      }
    });
  }


}
