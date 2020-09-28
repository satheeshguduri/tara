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

  static TextStyle navigationTextStyle =  TextStyle(
  color: AppColors.secondaryText,
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 12,
  height: 1.5,
  );

  static TextStyle searchBarTextStyle =  TextStyle(
  color: AppColors.secondaryText,
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  );

  static TextStyle nameTextStyle =  TextStyle(
  color: Color.fromARGB(255, 18, 52, 86),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w700,
  fontSize: 14,
  height: 1.42857,
  );

  static TextStyle notificationBadgeTextStyle =  TextStyle(
  color: Color.fromARGB(255, 255, 255, 255),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w500,
  fontSize: 9,
  );

  static TextStyle sendTextStyle =  TextStyle(
  color: Color.fromARGB(255, 19, 53, 86),
  fontFamily: "",
  fontWeight: FontWeight.w500,
  fontSize: 13,
  );

  static TextStyle seeAllTextStyle = TextStyle(
  color: AppColors.primaryText,
  fontFamily: "",
  fontWeight: FontWeight.w700,
  fontSize: 14,
  );

  static TextStyle transferToItemTextStyle =  TextStyle(
  color: AppColors.primaryText,
  fontFamily: "Roboto",
  fontWeight: FontWeight.w600,
  fontSize: 13,
  );

  static TextStyle transactionItemPersonNameTextStyle =  TextStyle(
  color: AppColors.primaryText,
  fontFamily: "",
  fontWeight: FontWeight.w700,
  fontSize: 16,
  );

  static TextStyle transactionItemDateTextStyle =  TextStyle(
  color: AppColors.secondaryText,
  fontFamily: "",
  fontWeight: FontWeight.w500,
  fontSize: 10,
  letterSpacing: 1,
  );

  static TextStyle transactionItemMoneyTextStyle =  TextStyle(
  color: Color.fromARGB(255, 249, 80, 116),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w700,
  fontSize: 14,
  );
}
