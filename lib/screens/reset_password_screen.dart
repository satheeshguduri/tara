import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/circle_shape.dart';
import 'package:tara_app/common/widgets/otp_text_field_widget.dart';
import 'package:tara_app/common/widgets/sign_in_flow_bg.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/common/constants/values.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key key,
  }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends BaseState<ResetPasswordScreen> {
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getRootContainer(),
    );
  }

  Widget getRootContainer() {
    return Obx(() => SafeArea(child: SignInFlowBg(child: getOtpWidget()))
        .withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  Widget getOtpWidget() {
    return Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  boxShadow: Shadows.shadows_list_2,
                  color: AppColors.primaryBackground),
              child: Wrap(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 24,
                        margin: EdgeInsets.only(top: 8),
                        child: Image.asset(
                          "assets/images/icon-5.png",
                          fit: BoxFit.none,
                        ),
                      ).onTap(onPressed: () {
                        controller.errorMessage.value = "";
                        Navigator.pop(
                            context, false); //Navigator.pop(context, false),
                      }),
                    ],
                  ),
                  TextWithBottomOverlay(
                    titleStr: "Reset Password",
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            style: BaseStyles.mobileSubTextStyle,
                            text: "Enter your new password"),
                        // TextSpan(
                        //     style: BaseStyles.mobileNoTextStyle,
                        //     text: " ${controller.mobileNumber.value}")
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    cursorColor: AppColors.primaryText,
                    obscureText: true,
                    controller: controller.passwordTextEditController,
                    decoration: InputDecoration(
                      hintText: "********",
                      labelText: "New Password",
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.color_black_100_2_2_2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 66,
                  ),
                  TextFormField(
                    cursorColor: AppColors.primaryText,
                    obscureText: true,
                    controller: controller.confirmPasswordTextEditController,
                    decoration: InputDecoration(
                      hintText: "********",
                      labelText: "Confirm New Password",
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.color_black_100_2_2_2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border(
                  //     bottom: BorderSide(
                  //       color: AppColors.light_grey_blue,
                  //       width: 1.0,
                  //     ),
                  //   )),
                  //   child: textFormFieldContainer(
                  //     getTranslation(Strings.confirm_password),
                  //     TextInputType.text,
                  //     controller.confirmPasswordTextEditController,
                  //     null,
                  //     isObscure: true,
                  //     placeHolderStyle: BaseStyles.subHeaderTextStyle,
                  //   ),
                  // ),
                  controller.errorMessage.value.isEmpty
                      ? Container()
                      : Container(
                    margin: EdgeInsets.all(8),
                    child: Text(
                      getTranslation(controller.errorMessage.value),
                      style: BaseStyles.error_text_style,
                    ),
                  ),
                  getContinueWidget()
                ],
              ),
            ),
          ),
        ));
  }

  Widget getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(
        bottom: 16,
        top: 24,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.CONTINUE),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: () {
      FocusManager.instance.primaryFocus.unfocus();
      controller.resetPassword();
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  textFormFieldContainer(
      String hint,
      TextInputType inputType,
      TextEditingController textEditingController,
      FocusNode focusNode, {
        bool isObscure = false,
        placeHolderStyle: BaseStyles.bankNameTextStyle,
      }) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        child: Container(
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    child: TextFieldWidget(
                        isObscure: isObscure,
                        placeHolderStyle: BaseStyles.subHeaderTextStyle,
                        hint: hint,
                        inputType: inputType,
                        textController: textEditingController,
                        isIcon: false,
                        focusNode: focusNode,
                        onChanged: (value) {
                          controller.errorMessage.value = "";
                          controller.confirmPwd.value =
                              textEditingController.text;
                        }),
                  )),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    controller.startTimer();
  }
}