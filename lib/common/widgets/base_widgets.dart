import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/styles.dart';
import '../constants/values.dart';

mixin BaseWidgets {
  BuildContext modelContext;
  Image getTabImage(String iconName) {
    return Image.asset(iconName, fit: BoxFit.none);
  }

  Image getTabImageWithSize(String iconName,double width, double height) {
    return Image.asset(iconName, fit: BoxFit.fill,width:width,height: height,);
  }
  static Widget bigCircle(String name) {
    return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Color(0xff123456),
          shape: BoxShape.circle,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name.isNotEmpty ? name.substring(0, 1).toUpperCase() : "",
              style: BaseStyles.contactsTextStyle, textAlign: TextAlign.center),
        ));
  }
  Text getTabText(String text) {
    return Text(text, style: BaseStyles.navigationTextStyle);
  }
  static const Widget getIndicator = SpinKitDoubleBounce(
    color: AppColors.secondaryBackground,
    size: 50.0,
  );
  static const Widget getListIndicator = SpinKitFadingCircle(
    color: AppColors.secondaryBackground,
    size: 30.0,
  );
  Divider getDivider({Color color = AppColors.primaryElement}) {
    return Divider(
      color: color,
      thickness: 1,
    );
  }

  AppBar getEmptyAppBar() => null;

//ToDo: Change all the reference types and specify return type
  dynamic buildBottomSheet(BuildContext context, Widget widget) {
    modelContext = context;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            Padding(padding: Margins.baseMarginVertical, child: widget));
  }

  dynamic buildBottomSheetWithInsets(BuildContext context, Widget widget) {
    modelContext = context;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: Margins.baseMarginVertical,
              child: widget,
            ));
  }

  Widget getSvgImage({String imagePath, Color color, double width = 24.0, double height= 24.0}) {
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
