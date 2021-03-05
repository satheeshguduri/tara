import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_button.dart';
import 'package:flutter_svg/svg.dart';


class ErrorStateInfoWidget extends StatelessWidget {
  final Widget image;
  final String title;
  final String desc;
  final String buttonText;
  final Function onTap;
  final bool isDefault;

  ErrorStateInfoWidget({this.image,this.title="Something went wrong", this.desc,this.buttonText,this.onTap,this.isDefault = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryBackground,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            this.image??SvgPicture.asset(
                Assets.illustration_transfer_to_my_account,
                fit: BoxFit.fitHeight,
                width: 100,
                height: 100,),

            Text(
               title??"",
                style: BaseStyles.modelTitleTextStyle,
                textAlign: TextAlign.center
            ).withPad(padding: EdgeInsets.only(top:16)),
            Text(
                desc??"",
                style: BaseStyles.errorInfoSubtitleTextStyle,
                textAlign: TextAlign.center
            ).withPad(padding: EdgeInsets.only(top:16)),
            Visibility(visible:isDefault,child: CustomButton(title:buttonText??"OK",onPressed: onTap??Get.back).withPad(padding: EdgeInsets.only(top:16))),
            //Visibility(visible:buttonText?.isNotEmpty??false,child:CustomButton(title:buttonText??"OK",onPressed: onTap).withPad(padding: EdgeInsets.only(top:16)))

          ],
        ),
      ).withPad(padding: EdgeInsets.all(16)),
    );
  }


}
