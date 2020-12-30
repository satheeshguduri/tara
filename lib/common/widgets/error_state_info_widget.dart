import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_button.dart';

class ErrorStateInfoWidget extends StatelessWidget {
  final Widget image;
  final String title;
  final String desc;
  final String buttonText;
  final Function onTap;

  ErrorStateInfoWidget({this.image,this.title, this.desc,this.buttonText,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryBackground,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            this.image??Container(),
            Text(
               title,
                style: BaseStyles.bottomSheetTitleStyle,
                textAlign: TextAlign.center
            ).withPad(padding: EdgeInsets.only(top:16)),
            Text(
                desc??"",
                style: BaseStyles.errorInfoSubtitleTextStyle,
                textAlign: TextAlign.center
            ).withPad(padding: EdgeInsets.only(top:16)),
            Visibility(visible:buttonText?.isNotEmpty??false,child:CustomButton(title:buttonText??"OK",onPressed: onTap).withPad(padding: EdgeInsets.only(top:16)))

          ],
        ),
      ).withPad(padding: EdgeInsets.all(16)),
    );
  }


}
