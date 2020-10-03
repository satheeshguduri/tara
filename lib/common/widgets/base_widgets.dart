import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../constants/values.dart';

mixin BaseWidgets {
  BuildContext modelContext;
  Image getTabImage(String iconName) {
    return Image.asset(iconName, fit: BoxFit.none);
  }

  Text getTabText(String text) {
    return Text(text, style: BaseStyles.navigationTextStyle);
  }

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
}
