

import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/utils/locale/utils.dart';

// ignore: must_be_immutable
class TextWithBottomOverlay extends StatelessWidget {
  final  String titleStr;
  const TextWithBottomOverlay({
    Key key,
    this.titleStr
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 16,right: 16),
      height: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            child:Container(
              height:16,
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
                //Utils().getTranslation(titleStr,context),
                titleStr??"",
                textAlign: TextAlign.left,
                style: BaseStyles.bankAccountHeaderTitleStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}









