import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/signin_screen.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:tara_app/common/widgets/extensions.dart';

class PasswordResetSuccess extends StatefulWidget {
  @override
  _PasswordResetSuccessState createState() => _PasswordResetSuccessState();
}

class _PasswordResetSuccessState extends State<PasswordResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return getConfirmationWidget();
  }

  Widget getConfirmationWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12)
        ),
        boxShadow: Shadows.shadows_list_3,
        color: AppColors.primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 39,),
          Container(
            decoration: BoxDecoration(
              color: AppColors.mint100.withOpacity(0.2),
              shape: BoxShape.circle
            ),
            child: getSvgImage(
                imagePath: Assets.assets_icon_password_reset_success,
                height:96.0,
                width: 96.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            width: Get.width*0.5,
            child: Center(
              child: Text("Password Reset Successful",
                  style: BaseStyles.agentUIN_OTP_CODE_TextStyle,
                  textAlign: TextAlign.center),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Center(
                child: Text(
              "You have successfully reset your password.",
              style: BaseStyles.accountSuccessTextStyle,
              textAlign: TextAlign.center,
            )),
          ),
          Center(
            child: backToLoginWidget(),
          ),
          SizedBox(height: 8,)
        ],
      ),
    );
  }

  Widget backToLoginWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(
        bottom: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color(0xffb2f7e2),
      ),
      alignment: Alignment.center,
      child: Text(
        "Back to Login",
        textAlign: TextAlign.center,
        style: BaseStyles.chatItemDepositSuccessMoneyTextStyle,
      ),
    ).onTap(onPressed: () {
      Get.offAll(SignInScreen());
      //pushAndRemoveUntil(HomeCustomerScreen());
    });
  }

  Widget getSvgImage(
      {String imagePath, Color color, width = 24.0, height = 24.0}) {
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.fitHeight,
      width: width,
      height: height,
      semanticsLabel: 'svg',
      color: color,
    );
  }
}
