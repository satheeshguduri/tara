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
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:tara_app/models/transfer/device_info.dart' as device;


class OTPVerificationScreen extends StatefulWidget {
 final String txnId;
 final FetchOtpResponse fetchOtpResponse;
 final RetrieveKeyResponse retrieveKeyResponse;
 final device.DeviceInfoBean deviceInfoBean;
 final String bic;
 const OTPVerificationScreen({this.txnId,this.fetchOtpResponse,this.retrieveKeyResponse,this.deviceInfoBean,this.bic});

  @override
  OTPVerificationScreenState createState() =>  OTPVerificationScreenState();

}

class OTPVerificationScreenState extends BaseState<OTPVerificationScreen> {
  bool isOtpEntered = false;

  TransactionController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: buildAppBar(context),
      body: getRootContainer(),
    );
  }


  Widget getRootContainer() {
    return Obx(() => SafeArea(
            child: SingleChildScrollView(
               child: getOtpWidget())
              .withProgressIndicator(showIndicator: controller.showProgress.value),
         )
    );

  }

  Widget getOtpWidget() {
    return Container(
      height: Get.height,
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Column(
         children: [
           Flexible(flex:4,child:otpIconWidget()),
           Flexible(flex:5,child:otpEntryWidget()),
           Flexible(flex:1,child:otpConfirmWidget()),
         ],
      ),
    );
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

  Widget otpConfirmWidget() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: isOtpEntered ? Color(0xffb2f7e2) : Color(0xffe9ecef)),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.CONFIRM_TRANSFER),
        textAlign: TextAlign.center,
        style: isOtpEntered
            ? BaseStyles.chatItemDepositSuccessMoneyTextStyle
            : BaseStyles.verifyTextStyle,
      ),
    ).onTap(onPressed: () {
      if (isOtpEntered) {
        ((widget.fetchOtpResponse.otpChallengeCode)!=null)?
        controller.validateOtpAndTrack(widget.txnId,widget.fetchOtpResponse,widget.retrieveKeyResponse,widget.deviceInfoBean,widget.bic):
        controller.validateOtpForTransfer();
        // pop();
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

  buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false,
      // hides leading widget
      leading: IconButton(
        //  icon: Icon(Icons.arrow_back),
          icon: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
              width: 24.0,
              height: 24.0),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(getTranslation(Strings.inputOTP),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }



 Widget otpIconWidget() {
    return Container(
      alignment: Alignment.center,
      child:  getSvgImage(imagePath: Assets.group,
          width: 123.0,
          height: 135.0),

    );
 }

  Widget otpEntryWidget() {
    
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 40,right: 40),
            margin: EdgeInsets.only(top: 1),
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      style: BaseStyles.mobileSubTextStyle,
                      text: getTranslation(Strings.mobile_verification_subtext)+" "),
                  TextSpan(
                      style: BaseStyles.mobileNoTextStyle,
                      text: controller.userMobileNumber)
                ]))),
        Container(
            padding: EdgeInsets.only(left: 40,right: 40),
            margin: EdgeInsets.only(top: 10),
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      style: BaseStyles.otpWithSMSTextStyle,
                      text: "Enter the OTP code from the SMS with Challenge Code:"),
                  TextSpan(
                      style: BaseStyles.otpWithSMSCodeTextStyle,
                      text:widget?.fetchOtpResponse?.otpChallengeCode??"000000")
                ]))),

        Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(
                top: 20,
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
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6.5.toInt(),
                child: Container(

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

                    padding: EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Text(getTranslation(Strings.resend_otp),
                            style: (controller.countDownTimeString.value == "00:00"&&controller.seconds.value == 0)?BaseStyles
                                .bottomSheetLocationChangeTextStyle:BaseStyles
                                .resendDefaultTextStyle,
                            textAlign: TextAlign.center),
                        Container(
                          height: 2,
                          margin: EdgeInsets.only(top: 4, left: 8),
                          decoration: BoxDecoration(
                            gradient: Gradients.primaryGradient,
                          ),
                        ),
                      ],
                    )).onTap(onPressed: () {
                  if (controller.userMobileNumber.isNotEmpty && controller.countDownTimeString.value == "00:00") {
                    controller.startTimer();
                    ((widget.fetchOtpResponse.otpChallengeCode)!=null)?
                     controller.validateOtpAndTrack(widget.txnId,widget.fetchOtpResponse,widget.retrieveKeyResponse,widget.deviceInfoBean,widget.bic):
                     controller.getOtpForTransfer(isFromResendOtp:true);
                  }
                }),
              ),
            ],
          ),
        ),

      ],
    );

  }



}
