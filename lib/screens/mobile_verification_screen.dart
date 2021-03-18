import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/circle_shape.dart';
import 'package:tara_app/common/widgets/otp_text_field_widget.dart';
import 'package:tara_app/common/widgets/sign_in_flow_bg.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/common/constants/values.dart';

class MobileVerificationScreen extends StatefulWidget {
  final bool isFromFogotPassword;

  const MobileVerificationScreen({
    Key key,
    this.isFromFogotPassword = false,
  }) : super(key: key);

  @override
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState
    extends BaseState<MobileVerificationScreen> {
  bool isOtpEntered = false;

  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  ).onTap(onPressed: (){
                      controller.errorMessage.value = "";
                      Navigator.pop(context, false); //Navigator.pop(context, false),
                  }),
                ],
              ),
              TextWithBottomOverlay(
                titleStr: Strings.mobile_verification,
              ),
              Container(
                color: Colors.grey[200],
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: CircleShape(
                  width: 88,
                  height: 88,
                  bgColor: Color(0xffd8d8d8),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        style: BaseStyles.mobileSubTextStyle,
                        text: getTranslation(
                            Strings.mobile_verification_subtext)),
                    TextSpan(
                        style: BaseStyles.mobileNoTextStyle,
                        text: controller.mobileNumber.value)
                  ]))),
              Column(
                children: [
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(
                      top: 24,
                    ),
                    child: OTPTextFieldWidget(
                      width: MediaQuery.of(context).size.width,
                      length: 6,
                      fieldWidth: 40,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldStyle: FieldStyle.underline,
                      obscureText: false,
                      style: BaseStyles.otpTextStyle,
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        setState(() {
                          controller.otp.value = pin;
                          isOtpEntered = true;
                        });
                      },
                      onChanged: (pin) {
                        print("Completed: " + pin);
                        setState(() {
                          if (pin.trim().length < 6) {
                            controller.errorMessage.value = "";
                            isOtpEntered = false;
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 10,
                    margin: EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getBorderContainer(),
                        getBorderContainer(),
                        getBorderContainer(),
                        getBorderContainer(),
                        getBorderContainer(),
                        getBorderContainer(),
                      ],
                    ),
                  ),
                ],
              ),
              controller.errorMessage.value.isEmpty
                  ? Container()
                  : Container(margin:EdgeInsets.all(8),child: Text(
                getTranslation(controller.errorMessage.value),
                style: BaseStyles.error_text_style,
              ),),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6.5.toInt(),
                      child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                style: BaseStyles.sentOtpTextStyle,
                                text: getTranslation(Strings.sent_otp_text)),
                            TextSpan(
                                style: BaseStyles.sentOtpTimeTextStyle,
                                text: controller.countDownTimeString.value)
                          ]))),
                    ),
                    Expanded(
                      flex: 3.5.toInt(),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          child: Column(
                            children: [
                              Text(getTranslation(Strings.resend_otp),
                                  style: (controller.countDownTimeString.value == "00:00"&&controller.seconds.value == 0)?BaseStyles
                                      .bottomSheetLocationChangeTextStyle:BaseStyles
                                      .resendDefaultTextStyle,
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
                          )).onTap(onPressed: () {
                        if (controller.mobileNumber.value.isNotEmpty && controller.countDownTimeString.value == "00:00") {
                          controller.startTimer();
                          controller.getOtp(isFromResendOtp:true);
                        }
                      }),
                    ),
                  ],
                ),
              ),
              getVerifyWidget()
            ],
          ),
        ),
      ),
    ));
  }

  Widget getBorderContainer() {
    return Container(
      height: 3,
      width: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              //                   <--- left side
              color: controller.errorMessage.value.isNotEmpty
                  ? Colors.pink
                  : isOtpEntered ? Color(0xffb2f7e2) : Color(0xffb0b4c1),
              width: 2.0,
              style: BorderStyle.solid),
        ),
        color: Colors.transparent,
      ),
    );
  }

  Widget getVerifyWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(
        bottom: 16,
        top: 36,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: isOtpEntered ? Color(0xffb2f7e2) : Color(0xffe9ecef)),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.verify),
        textAlign: TextAlign.center,
        style: isOtpEntered
            ? BaseStyles.chatItemDepositSuccessMoneyTextStyle
            : BaseStyles.verifyTextStyle,
      ),
    ).onTap(onPressed: () {
      if (isOtpEntered) {
        controller.validateOtp(
            isFromForgotPassword: widget.isFromFogotPassword);
      }
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    controller.startTimer();
  }
}
