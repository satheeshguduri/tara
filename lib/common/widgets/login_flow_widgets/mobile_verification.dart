import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/circle_shape.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/account_confirmation.dart';
import 'package:tara_app/common/widgets/otp_text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/flavors.dart';
import 'package:tara_app/screens/agent/agent_widgets/upload_portrait_pic.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/create_account.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({
    Key key,
  }) : super(key: key);

  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends BaseState<MobileVerification> {

  String otpPin = "";
  String correctPin = "123456";
  String errorText = "";
  bool isOtpEntered = false;

  @override
  Widget build(BuildContext context) {

    return Container(
        child:Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width*0.90,
            child: Container(
              padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          width: 32,
                          height: 24,
                          margin: EdgeInsets.only(top: 8),
                          child: Image.asset(
                            "assets/images/icon-5.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextWithBottomOverlay(titleStr: Strings.mobile_verification,),
                  Container(
                    color: Colors.grey[200],
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: CircleShape(width: 88,height: 88,bgColor: Color(0xffd8d8d8),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child:RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  style: BaseStyles.mobileSubTextStyle,
                                  text: getTranslation(Strings.mobile_verification_subtext)),
                              TextSpan(
                                  style: BaseStyles.mobileNoTextStyle,
                                  text: " +62812*******29")
                            ]
                        )
                    )
                  ),
                  Column(
                    children: [
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 24,),
                        child: OTPTextFieldWidget(
                          width:  MediaQuery.of(context).size.width,
                          length: 6,
                          fieldWidth: 40,
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle:FieldStyle.underline,
                          obscureText: false,
                          style: BaseStyles.otpTextStyle,
                          correctPin:correctPin,
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            setState(() {
                              otpPin = pin;
                              isOtpEntered = true;
                            });
                          },
                          onChanged: (pin) {
                            print("Completed: " + pin);
                            setState(() {
                              if (pin.trim().length<6)
                              {
                                errorText = "";
                                isOtpEntered = false;
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 10,
                        margin: EdgeInsets.only(bottom: 16,),
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
                  errorText.isNotEmpty?Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8,),
                      child: Text(
                          errorText,
                          style: BaseStyles.errorTextStyle,
                          textAlign: TextAlign.center
                      ),
                    ),
                  ):Container(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6.5.toInt(),
                          child: Container(
                              margin: EdgeInsets.only(top: 8),
                              child:RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            style: BaseStyles.sentOtpTextStyle,
                                            text: getTranslation(Strings.sent_otp_text)),
                                        TextSpan(
                                            style: BaseStyles.sentOtpTimeTextStyle,
                                            text: " 00:56")
                                      ]
                                  )
                              )
                          ),
                        ),
                        Expanded(
                          flex: 3.5.toInt(),
                          child: Container(
                              padding: EdgeInsets.only(top: 8,),
                              child: Column(
                                children: [
                                  Text(
                                      getTranslation(Strings.resend_otp),
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
                  _getVerifyWidget()
                ],
              ),
            ),
          ),
        ));
  }

  getBorderContainer()
  {
    return Container(
      height: 3,
      width: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide( //                   <--- left side
            color: errorText.isNotEmpty?Colors.pink:isOtpEntered?Color(0xffb2f7e2):Color(0xffb0b4c1),
            width: 2.0,
            style: BorderStyle.solid
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }

  _getVerifyWidget() {
    return InkWell(
      onTap: () {
        if (isOtpEntered&&otpPin.isNotEmpty&&otpPin.length==6)
        {
          if (otpPin!=correctPin)
          {
            setState(() {
              errorText = getTranslation(Strings.invalid_pin);
            });
          }else{
            if(Flavor.CONSUMER == F.appFlavor){
              push(CreateAccount(isFromMobileVerification:true));
            }else if(Flavor.AGENT == F.appFlavor){
              push(UploadPortraitPic());
            }
          }
        }
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 36,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: isOtpEntered?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.verify),
          textAlign: TextAlign.center,
          style: isOtpEntered?BaseStyles.chatItemDepositSuccessMoneyTextStyle:BaseStyles.verifyTextStyle,
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
  }

}
