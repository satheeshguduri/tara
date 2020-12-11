import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/create_account_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  CompleteProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends BaseState<CompleteProfileScreen> {

  AuthController controller = Get.find();

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
            pushAndRemoveUntil(CreateAccountScreen());
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
        personalDetailsTitleWidget(),
        textFormFieldContainer(
          getTranslation(Strings.name),
          getTranslation(Strings.enter_full_name),
          TextInputType.text,
          controller.nameTextEditController,
        ),
        textFormFieldContainer(
            getTranslation(Strings.phone_number_2),
            controller.mobileNumber.value,
            TextInputType.phone,
            controller.mobileNumberTextEditController,
            enableInteractiveSelection: false,
            placeHolderStyle: BaseStyles.amountTextStyle),
        textFormFieldContainer(
          getTranslation(Strings.email_address),
          getTranslation(Strings.enter_email_address),
          TextInputType.emailAddress,
          controller.emailTextEditController,
        ),
        textFormFieldContainer(
            getTranslation(Strings.password),
            getTranslation(Strings.enter_password),
            TextInputType.text,
            controller.passwordTextEditController,
            isSecureText: true),
        textFormFieldContainer(
            getTranslation(Strings.confirm_password),
            getTranslation(Strings.enter_confirm_password),
            TextInputType.text,
            controller.confirmPasswordTextEditController,
            isSecureText: true),
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

  Widget personalDetailsTitleWidget() {
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
                getTranslation(Strings.personal_details),
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
    if (textEditingController == controller.nameTextEditController) {
      controller.fullName.value = textEditingController.text;
    } else if (textEditingController == controller.emailTextEditController) {
      controller.email.value = textEditingController.text;
    } else if (textEditingController == controller.passwordTextEditController) {
      controller.password.value = textEditingController.text;
    } else if (textEditingController ==
        controller.confirmPasswordTextEditController) {
      controller.confirmPwd.value = textEditingController.text;
    }
    controller.isEnterAllTheFieldsInCompleteProfile();
  }

  Widget textFormFieldContainer(
    String headerTitle,
    String hint,
    TextInputType inputType,
    TextEditingController textEditingController, {
    bool isSecureText = false,
    bool enableInteractiveSelection = false,
    placeHolderStyle: BaseStyles.subHeaderTextStyle,
  }) {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: textEditingController !=
                      controller.mobileNumberTextEditController
                  ? Colors.grey
                  : Colors.transparent,
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
                      child: TextFieldWidget(
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
          color: controller.isEnterAllTheFields.value
              ? Color(0xffb2f7e2)
              : Color(0xffe9ecef)),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.save_and_continue),
        textAlign: TextAlign.center,
        style: controller.isEnterAllTheFields.value
            ? BaseStyles.chatItemDepositSuccessMoneyTextStyle
            : BaseStyles.verifyTextStyle,
      ),
    ).onTap(onPressed: () {
      if(controller.isEnterAllTheFields.value)
      {
        controller.signUp();
      }
    });
  }
}
