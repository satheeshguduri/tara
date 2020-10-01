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
  fontWeight: FontWeight.w400,
  fontSize: 12,
  height: 1.5,
  );

  static TextStyle searchBarTextStyle =  TextStyle(
  color: AppColors.secondaryText,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  );

  static TextStyle nameTextStyle =  TextStyle(
  color: Color.fromARGB(255, 18, 52, 86),
  fontWeight: FontWeight.w700,
  fontSize: 14,
  height: 1.42857,
  );

  static TextStyle notificationBadgeTextStyle =  TextStyle(
  color: Color.fromARGB(255, 255, 255, 255),
  fontWeight: FontWeight.w500,
  fontSize: 9,
  );

  static TextStyle sendTextStyle =  TextStyle(
  color: Color.fromARGB(255, 19, 53, 86),
  fontWeight: FontWeight.w500,
  fontSize: 13,
  );

  static TextStyle seeAllTextStyle = TextStyle(
  color: AppColors.primaryText,
  fontWeight: FontWeight.w700,
  fontSize: 14,
  );

  static TextStyle transferToItemTextStyle =  TextStyle(
  color: AppColors.primaryText,
//  fontFamily: "",
  fontWeight: FontWeight.w600,
  fontSize: 13,
  );

  static TextStyle transactionItemPersonNameTextStyle =  TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      fontStyle:  FontStyle.normal,
      fontSize: 14.0
  );

  static TextStyle transactionItemDateTextStyle =  TextStyle(
      color:  Colors.black54,
      fontWeight: FontWeight.w500,
      fontStyle:  FontStyle.normal,
      fontSize: 12.0
  );

  static TextStyle transactionItemMoneyTextStyle =  TextStyle(
  color: Colors.grey[500],
  fontWeight: FontWeight.w500,
  fontSize: 14,
  );

  static TextStyle homeScreenHeadersStyle =   TextStyle(
  color: AppColors.primaryText,
  fontWeight: FontWeight.w600,
  fontSize: 17,
  );

  static TextStyle bottomSheetTitleStyle = TextStyle(
  color: Color(0xff123456),
  fontWeight: FontWeight.w700,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 20.0
  );

  static TextStyle bottomSheetSubTitleStyle = TextStyle(
  color:  Color(0xff123456),
  fontWeight: FontWeight.w500,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 12.0
  );

  static TextStyle bottomSheetLocationStyle = TextStyle(
  color:  Color(0xff123456),
  fontWeight: FontWeight.w400,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 14.0
  );

  static TextStyle bottomSheetLocationChangeTextStyle =  TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,
//      fontFamily: "",
      fontStyle:  FontStyle.normal,
      fontSize: 14.0
  );

  static TextStyle additionContactTextTextStyle =  TextStyle(
  color:  const Color(0xff123456),
  fontWeight: FontWeight.w500,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 14.0
  );

  static TextStyle textFormFieldHeaderTitleTextStyle =  TextStyle(
  color:  const Color(0xff123456),
  fontWeight: FontWeight.w500,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 12.0
  );

  static TextStyle requestNowTextStyle =  TextStyle(
  color:  const Color(0xff889aac),
  fontWeight: FontWeight.w700,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 14.0
  );

  static TextStyle contactsHeaderTextStyle =  TextStyle(
  color:  Color(0xff123456),
  fontWeight: FontWeight.w600,
//      fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 10.0
  );

  static TextStyle contactsTextStyle =   TextStyle(
  color:  Color(0xffffffff),
  fontWeight: FontWeight.w700,
//  fontFamily: "",
  fontStyle:  FontStyle.normal,
  fontSize: 16.0
  );

  static TextStyle taraWalletTextStyle =   TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w400,
  fontSize: 8.89043,
  height: 1.33333,
  );

  static TextStyle myAccountItemTextStyle = TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w400,
      fontStyle:  FontStyle.normal,
      fontSize: 14.0
  );

  static TextStyle bankAccountHeaderTitleStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      fontStyle:  FontStyle.normal,
      fontSize: 24.0
  );

  static TextStyle backAccountHeaderTextStyle = const TextStyle(
      color: AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      fontStyle:  FontStyle.normal,
      fontSize: 16.0
  );

  static TextStyle topBarTextStyle = const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  fontStyle:  FontStyle.normal,
  fontSize: 20.0
  );

  static const addNewBankAccount = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      fontStyle:  FontStyle.normal,
      fontSize: 14.0
  );

  static const bankNameTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w400,
      fontStyle:  FontStyle.normal,
      fontSize: 16.0
  );

  static const saveToMyContactTextStyle =const TextStyle(
  color:  Colors.black54,
  fontWeight: FontWeight.w400,
  fontStyle:  FontStyle.normal,
  fontSize: 14.0
  );

  static const accountNumberInMPINTextStyle = const TextStyle(
  color:  Colors.white,
  fontWeight: FontWeight.w700,
  fontStyle:  FontStyle.normal,
  fontSize: 24.0
  );

  static const accountNameInMPINTextStyle = const TextStyle(
  color:  Colors.white,
  fontWeight: FontWeight.w500,
  fontStyle:  FontStyle.normal,
  fontSize: 14.0
  );

  static const enterMPINTextStyle = const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  fontStyle:  FontStyle.normal,
  fontSize: 12.0
  );

  static const MPINTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      fontStyle:  FontStyle.normal,
      fontSize: 40.0
  );

  static const amountTextStyle =const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w400,
  fontStyle:  FontStyle.normal,
  fontSize: 16.0
  );

  static const transactionSuccessTextStyle = const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  fontStyle:  FontStyle.normal,
  fontSize: 24.0
  );

  static const dateAndTimeTextStyle =  const TextStyle(
  color:  AppColors.uncheck_color,
  fontWeight: FontWeight.w400,
  fontStyle:  FontStyle.normal,
  fontSize: 14.0
  );

  static const transaction_account_name_textStytle =   const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  fontStyle:  FontStyle.normal,
  fontSize: 16.0
  );
}
