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
  Divider getDivider() {
    return Divider(
      color: AppColors.primaryElement,
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

  Widget getSvgImage({String imagePath,Color color, width = 24.0, height= 24.0}) {
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.none,
      width: width,
      height: height,
      semanticsLabel: 'svg',
      color: color,
    );


  }

}
