import 'package:flutter/material.dart';

import 'colors.dart';

class BaseStyles {
  static TextStyle hintTextStyle = TextStyle(
    color: AppColors.secondaryText,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.28571,
  );
  static TextStyle baseTextStyle = TextStyle(
    color: AppColors.primaryText,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.28571,
  );

  static TextStyle titleTextStyle = TextStyle(
    color: AppColors.primaryText,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.33333,
  );
}
