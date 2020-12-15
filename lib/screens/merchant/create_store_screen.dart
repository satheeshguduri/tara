import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/create_store_and_owner_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';


class CreateStoreScreen extends StatefulWidget {
  CreateStoreScreen({Key key}) : super(key: key);

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getRootContainer();
  }

  Widget getRootContainer(){
    return Obx(()=>
        SafeArea(child: getTotalWidget())).withProgressIndicator(showIndicator: controller.showProgress.value);
  }

  Widget getTotalWidget()
  {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4,bottom: 8),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 209, 212, 215),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    getTranslation(Strings.create_store),
                    style:BaseStyles.bottomSheetTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                textFormFieldContainer(getTranslation(Strings.store_name),getTranslation(Strings.enter_store_name),TextInputType.text,controller.storeNameTextController),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                      getTranslation(Strings.address),
                      style: BaseStyles.bottomSheetSubTitleStyle
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(left: 8,bottom: 8,top: 8,right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)
                      ),
                      border: Border.all(
                          color: Color(0xffe9ecef),
                          width: 1
                      ),
                      color: Color(0xffffffff)
                  ),
                  child:Container(
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
                                  margin: EdgeInsets.only(left: 8,right: 8),
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
                              padding: EdgeInsets.only(top: 8,bottom: 8),
                              child: Column(
                                children: [
                                  Text(
                                      getTranslation(Strings.CHANGE),
                                      style: BaseStyles.bottomSheetLocationChangeTextStyle,
                                      textAlign: TextAlign.center
                                  ),
                                  Container(
                                    height:2 ,
                                    margin: EdgeInsets.only(top: 4,left: 8,right: 8),
                                    decoration: BoxDecoration(
                                      gradient: Gradients.primaryGradient,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.errorMessage.value.isEmpty
                    ? Container()
                    : Container(margin:EdgeInsets.all(8),child: Text(
                  getTranslation(controller.errorMessage.value),
                  style: BaseStyles.error_text_style,
                ),),
                submitWidget()
              ])
      ),
    );
  }

  void onChanged(TextEditingController textEditingController) {
    controller.errorMessage.value = "";
    controller.storeName.value = textEditingController.text;
    controller.isEnterAllTheFieldsInCreateStore();
  }

  Widget textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController)
  {
    return Container(
        margin: EdgeInsets.only(top:8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide( //                   <--- left side
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
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child:TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,onChanged:(value){
                              onChanged(textEditingController);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget submitWidget()
  {
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
        getTranslation(Strings.submit),
        textAlign: TextAlign.center,
        style: controller.isEnterTheFieldsInCreateStore.value
            ? BaseStyles.chatItemDepositSuccessMoneyTextStyle
            : BaseStyles.verifyTextStyle,
      ),
    ).onTap(onPressed: (){
      if (controller.isEnterTheFieldsInCreateStore.value){
        controller.createStore();
      }
    });
  }

}
