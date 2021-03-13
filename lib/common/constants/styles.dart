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
      fontSize: 14.0
  );

  static TextStyle transactionItemDateTextStyle =  TextStyle(
      color:  Color(0xffb0b4c1),
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0
  );

  static TextStyle transactionItemMoneyTextStyle =  TextStyle(
  color: Colors.grey[500],
  fontWeight: FontWeight.w500,
  fontSize: 14,
  );

  static TextStyle homeScreenHeadersStyle =   TextStyle(
  color: AppColors.primaryText,
  fontWeight: FontWeight.w700,
  fontSize: 20,
  );

  static TextStyle bottomSheetTitleStyle = TextStyle(
  color: AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
//  fontFamily: "",
  
  fontSize: 16.0
  );

  static TextStyle bottomSheetSubTitleStyle = TextStyle(
  color:  Color(0xff123456),
  fontWeight: FontWeight.w500,
//  fontFamily: "",
  
  fontSize: 12.0
  );

  static TextStyle bottomSheetLocationStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w400,
//  fontFamily: "",
  
  fontSize: 14.0
  );

  static TextStyle bottomSheetLocationChangeTextStyle =  TextStyle(
      color: AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
//      fontFamily: "",
      
      fontSize: 14.0
  );
  static TextStyle errorInfoSubtitleTextStyle = const TextStyle(
      color:  AppColors.color_black_100_2_2_2,
      fontSize: 16.0
  );
  static TextStyle modelTitleTextStyle = const TextStyle(
  color:  AppColors.color_black_100_2_2_2,
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  );
  static TextStyle resendDefaultTextStyle =  TextStyle(
      color: AppColors.color_black_100_2_2_2,
      fontWeight: FontWeight.w700,
//      fontFamily: "",
      
      fontSize: 14.0
  );



  static TextStyle additionContactTextTextStyle =  TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
//  fontFamily: "",
  
  fontSize: 14.0
  );

  static TextStyle textFormFieldHeaderTitleTextStyle =  TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
//  fontFamily: "",
  
  fontSize: 12.0
  );

  static TextStyle requestNowTextStyle =  TextStyle(
  color:  const Color(0xff889aac),
  fontWeight: FontWeight.w700,
//  fontFamily: "",
  
  fontSize: 14.0
  );

  static TextStyle contactsHeaderTextStyle =  TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w600,
//      fontFamily: "",
  
  fontSize: 10.0
  );
  static TextStyle nominalTextView =   TextStyle(
      color:  AppColors.secondaryElement,
      fontWeight: FontWeight.w700,
      
      fontSize: 16.0
  );
  static TextStyle contactsTextStyle =   TextStyle(
  color:  Color(0xffffffff),
  fontWeight: FontWeight.w700,
//  fontFamily: "",
  
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
      
      fontSize: 14.0
  );

  static TextStyle bankAccountHeaderTitleStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 24.0
  );

  static TextStyle backAccountHeaderTextStyle = const TextStyle(
      color: AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 16.0
  );

  static TextStyle topBarTextStyle = const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 20.0
  );

  static const addNewBankAccount = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );

  static const disableButtonStyle = const TextStyle(
      color:  Color(0xff889aac),
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );

  static const bankNameTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );

  static const placeholderStyle = const TextStyle(
      color:  AppColors.light_grey_blue,
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );

  static const orderTotalStyle = const TextStyle(
      color:  AppColors.light_grey_blue,
      fontWeight: FontWeight.w700,
      
      fontSize: 16.0
  );



  static const saveToMyContactTextStyle =const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  
  fontSize: 14.0
  );

  static const accountNumberInMPINTextStyle = const TextStyle(
  color:  Colors.white,
  fontWeight: FontWeight.w700,
  
  fontSize: 24.0
  );

  static const accountNameInMPINTextStyle = const TextStyle(
  color:  Colors.white,
  fontWeight: FontWeight.w500,
  
  fontSize: 14.0
  );

  static const enterMPINTextStyle = const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 12.0
  );

  static const MPINTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 40.0
  );

  static const amountTextStyle =const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w400,
  
  fontSize: 16.0
  );

  static const transactionSuccessTextStyle = const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 24.0
  );

  static const cannotFindTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 16.0
  );

  static const dateAndTimeTextStyle =  const TextStyle(
  color:  AppColors.uncheck_color,
  fontWeight: FontWeight.w400,
  
  fontSize: 14.0
  );

  static const transaction_account_name_textStytle =   const TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  
  fontSize: 16.0
  );
  static const error_text_style =   const TextStyle(
      color:  AppColors.badge_color,
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0
  );

  static const chatItemHeaderTextStyle = TextStyle(
  color:  const Color(0xffffffff),
  fontWeight: FontWeight.w700,
  
  fontSize: 14.0
  );

  static const chatItemSubTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w400,
  
  fontSize: 14.0
  );

  static const chatItemButtonTextStyle = TextStyle(
  color: AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 14.0
  );

  static const declineButtonTextStyle = TextStyle(
      color: Color(0xfff95074),
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );



  static const chatItemResendOtpButtonTextStyle = TextStyle(
      color: Color(0xff889aac),
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );

  static const chatItemDepositSuccessTextStyle = TextStyle(
      color: AppColors.header_top_bar_color,
      fontWeight: FontWeight.w400,
      
      fontSize: 14.0
  );

  static const chatItemDepositSuccessMoneyTextStyle = TextStyle(
      color: AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );

  static const agentConfirmedTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  
  fontSize: 10.0
  );

  static const agentUIN_OTP_CODE_TextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 20.0
  );

  static const cancel_request_text_style = TextStyle(
      color:  const Color(0xfff95074),
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );

  static const subHeaderTextStyle =  TextStyle(
      color:  Color(0xff697683),
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );

  static const alreadyHaveAccountTextStyle = TextStyle(
  color:  Color(0xff889aac),
  fontWeight: FontWeight.w400,
  
  fontSize: 14.0
  );

  static const deleteAccountStyle = TextStyle(
      color:  Colors.pink,
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );

  static const sentOtpTextStyle = TextStyle(
  color:  Color(0xff697683),
  fontWeight: FontWeight.w400,
  fontSize: 12.0
  );

  static const sentOtpTimeTextStyle = TextStyle(
  color:  Color(0xff697683),
  fontWeight: FontWeight.w700,
  fontSize: 12.0
  );

  static const verifyTextStyle = TextStyle(
  color:  Color(0xff889aac),
  fontWeight: FontWeight.w700,
  
  fontSize: 14.0
  );

  static const otpTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 24.0
  );

  static const mobileNoTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 16.0
  );

  static const mobileSubTextStyle = TextStyle(
  color:  Color(0xff697683),
  fontWeight: FontWeight.w400,
  
  fontSize: 16.0,
      height: 1.5
  );

  static const errorTextStyle = TextStyle(
  color:  Colors.pink,
  fontWeight: FontWeight.w500,
  
  fontSize: 14.0
  );

  static const accountSuccessTextStyle =  TextStyle(
  color:  Color(0xff697683),
  fontWeight: FontWeight.w400,
  
  fontSize: 16.0,
      height: 1.5
  );

  static const overLayTextStyle_grey = TextStyle(
      color:  AppColors.light_grey_blue,
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0,
      decoration: TextDecoration.none
  );
  static const overLayTextStyle_satisfy = TextStyle(
      color:  AppColors.fareColor,
      fontWeight: FontWeight.w500,
      
      fontSize: 16.0,
      decoration: TextDecoration.none
  );
  static const overLayTextStyle_heading = TextStyle(
      color:  AppColors.fareColor,
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0,
      decoration: TextDecoration.none
  );
  static const itemOrderQuantityTextStyle = TextStyle(
  color:  const Color(0xff889aac),
  fontWeight: FontWeight.w500,
  
  fontSize: 12.0
  );

  static const itemOrderTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w400,
  
  fontSize: 14.0
  );

  static const itemOrderHeaderTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  
  fontSize: 12.0
  );

  static const itemOrderCostTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w400,
  
  fontSize: 14.0
  );

  static const reviewAndConfirmHeaderTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 16.0
  );

  static const orderDetailsHeaderTextStyle = TextStyle(
      color:  const Color(0xffb0b4c1),
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0
  );

  static const orderDetailTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w500,
      
      fontSize: 10.0
  );

  static const enterOTPTextStyle = TextStyle(
      color:  const Color(0xff8899aa),
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );

  static const uploadKtpTextStyle = TextStyle(
  color:  Color(0xff697683),
  fontWeight: FontWeight.w500,
  
  fontSize: 14.0
  );

  static const ktpTitleTextStyle = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w700,
  
  fontSize: 20.0
  );

  static const ktpSubTitleTextStyle = TextStyle(
      color:  Color(0xff697683),
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0,
      height: 1.5
  );

  static const saveAndContinueDisableTextStyle = TextStyle(
  color:  Color(0xff889aac),
  fontWeight: FontWeight.w700,
  
  fontSize: 16.0
  );

  static const chatInboxTabSelectedTextColor = TextStyle(
  color:  AppColors.header_top_bar_color,
  fontWeight: FontWeight.w500,
  
  fontSize: 14.0
  );

  static const chatInboxTabUnSelectedTextColor = TextStyle(
  color:  Color(0xff889aac),
  fontWeight: FontWeight.w500,
  
  fontSize: 14.0
  );

  static const chatTitleTextStyle = const TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );
  static const purchaseLabelTextStyle = const TextStyle(
      color:  Color(0xffb0b4c1),
      fontWeight: FontWeight.w400,
      
      fontSize: 14.0
  );
  static const chatSubTitleTextStyle = const TextStyle(
  color:  Color(0xff697683),
  fontWeight: FontWeight.w400,
  
  fontSize: 14.0
  );
  static const shopPreviousOrderAgain = TextStyle(
      color:  AppColors.header_top_bar_color,
      fontWeight: FontWeight.w700,
      
      fontSize: 12.0
  );

  static const logoutTextStyle = const TextStyle(
      color:  Colors.pink,
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );
  static const otpWithSMSTextStyle = const TextStyle(
      color:  AppColors.yourPurchaseBillsDetailsText,
      fontWeight: FontWeight.w500,
      
      fontSize: 14.0
  );
  static const otpWithSMSCodeTextStyle = const TextStyle(
      color:  AppColors.yourPurchaseBillsDetailsText,
      fontWeight: FontWeight.w700,
      
      fontSize: 14.0
  );

}



class TextStyles {
  static const headline6222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 20.0
  );
  static const subtitle1222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,
      
      fontSize: 16.0
  );
  static const inputFieldOn222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );
  static const inputFieldOff222 = const TextStyle(
      color:  Color(0xffb0b4c1),
      fontWeight: FontWeight.w400,
      
      fontSize: 16.0
  );
  static const body1222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w400,

      
      fontSize: 16.0
  );
  static const subtitle3222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONWhite222 = const TextStyle(
      color:  Colors.white,
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONRed222 = const TextStyle(
      color:  Colors.pink,
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONGrey3222 = const TextStyle(
      color:  Color(0xff889aac),
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONBlack222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const subtitle2222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,
      
      fontSize: 14.0
  );
  static const body2222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w400,
      fontSize: 14.0
  );
  static const bUTTONSmallWhite222 = const TextStyle(
      color:  Colors.white,
      fontWeight: FontWeight.w700,

      
      fontSize: 12.0
  );
  static const bUTTONSmallBlack222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 12.0
  );
  static const caption2222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0
  );
  static const caption222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0
  );
  static const oVERLINE222 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,

      
      fontSize: 10.0
  );
  static const headline12 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 96.0
  );
  static const headline22 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 59.0
  );
  static const headline32 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 47.0
  );
  static const headline42 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 33.0
  );
  static const headline52 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 24.0
  );
  static const headline62 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 20.0
  );
  static const subtitle12 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 16.0
  );
  static const inputFieldOn2 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w400,

      
      fontSize: 16.0
  );
  static const inputFieldOff2 = const TextStyle(
      color:  Color(0xffb0b4c1),
      fontWeight: FontWeight.w400,

      
      fontSize: 16.0
  );
  static const body12 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w400,

      
      fontSize: 16.0
  );
  static const bUTTONWhite2 = const TextStyle(
      color:  Colors.white,
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONRed2 = const TextStyle(
      color:  Colors.pink,
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONGrey32 = const TextStyle(
      color:  Color(0xff889aac),
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const bUTTONBlack2 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 14.0
  );
  static const subtitle22 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,

      
      fontSize: 14.0
  );
  static const body22 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w400,

      
      fontSize: 14.0
  );
  static const bUTTONSmallGrey32 = const TextStyle(
      color:  Color(0xff889aac),
      fontWeight: FontWeight.w800,
      
      fontSize: 12.0
  );
  static const bUTTONSmallWhite2 = const TextStyle(
      color:  Colors.white,
      fontWeight: FontWeight.w700,

      
      fontSize: 12.0
  );
  static const bUTTONSmallRed2 = const TextStyle(
      color:  Colors.pink,
      fontWeight: FontWeight.w700,

      
      fontSize: 12.0
  );
  static const bUTTONSmallBlack2 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w700,

      
      fontSize: 12.0
  );
  static const caption2 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,

      
      fontSize: 12.0
  );
  static const oVERLINE2 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,

      
      fontSize: 10.0
  );

  static const payoutMinusTextTtyle =  TextStyle(
  color:  Colors.pink,
  fontWeight: FontWeight.w700,
  
  fontSize: 16.0
  );
  static const productsListDescTextStyle =  TextStyle(
      color:  Colors.black12,
      fontWeight: FontWeight.w400,
      
      
      fontSize: 14.0
  );
  static const yourPurchaseBillsDetailsTextStyle =  TextStyle(
      color:  AppColors.yourPurchaseBillsDetailsText,
      fontWeight: FontWeight.w400,
      
      
      fontSize: 14.0
  );
  static const yourPurchaseBillsTotalTextStyle =  TextStyle(
      color:  AppColors.yourPurchaseBillsDetailsText,
      fontWeight: FontWeight.w700,
      
      
      fontSize: 16.0
  );
  static const plnTokenContainerTextStyle =  TextStyle(
      color:  AppColors.accentText,
      fontWeight: FontWeight.w500,
      
      fontSize: 14.0
  );
  static const myAccountsDefaultTextStyle =   TextStyle(
      color: AppColors.yourPurchaseBillsDetailsText,
      fontWeight: FontWeight.w500,
      
      fontSize: 10.0
  );
  static const bottomSheetCardTextStyle =  TextStyle(
      color:  AppColors.fareColor,
      fontWeight: FontWeight.w400,
      
      fontSize: 14.0
  );
  static const myAccountsCardTextStyle =  TextStyle(
          color:  AppColors.fareColor,
          fontWeight: FontWeight.w700,
          
          fontSize: 20.0
  );
  static const caption222WithHeight2 = const TextStyle(
      color:  Color(0xff123456),
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0,
      height:2.0
  );

  static const serviceFeeTextStyle = const TextStyle(
      color:  AppColors.color_black_80_2_2_2,
      fontWeight: FontWeight.w500,
      fontSize: 12.0
  );
  static const serviceFeeAmountTextStyle = const TextStyle(
      color:  AppColors.color_black_80_2_2_2,
      fontWeight: FontWeight.w500,
      
      fontSize: 12.0

  );

  static const caption222TextStyle = const TextStyle(
      color:  AppColors.color_black_100_2_2_2,
      fontWeight: FontWeight.w500,
      
      
      fontSize: 12.0
  );

  static const verifyCodeTextStyle = const TextStyle(
      color:  AppColors.black90,
      fontWeight: FontWeight.w400,
      fontSize: 16.0
  );

  static const otpRecieverMobileTextStyle = const TextStyle(
      color:  AppColors.color_black_100_2_2_2,
      fontWeight: FontWeight.w700,
      fontSize: 16.0
  );
  static const otpWithSMSTextStyle = const TextStyle(
      color:  AppColors.color_black_100_2_2_2,
      fontWeight: FontWeight.w500,
      fontSize: 14.0
  );

  static const challengeCodeTextStyle = const TextStyle(
      color:  AppColors.color_black_100_2_2_2,
      fontWeight: FontWeight.w700,
      fontSize: 14.0
  );

  static const transferDetailsHeadingTextStyle =  const TextStyle(
      color: AppColors.fareColor,
      fontWeight: FontWeight.w700,
      fontSize: 16.0
  );

  static const cardAmountTextStyle =  const TextStyle(
      color:  AppColors.elevation_off_2_2_2,
      fontWeight: FontWeight.w700,
      fontSize: 20.0
  );

  static const cardNumberTextStyle =   const TextStyle(
      color:  AppColors.elevation_off_2_2_2,
      fontWeight: FontWeight.w500,
      fontSize: 14.0
  );

  static const pulsaUnSelectedTextStyle =    const TextStyle(
      color:  AppColors.color_black_80_2_2_2,
      fontWeight: FontWeight.w500,
      fontSize: 14.0
  );


  static const labelSelectedTextStyle =    const  TextStyle(
          //color:  AppColors.color_black_100_2_2_2,
          fontWeight: FontWeight.w700,
          fontSize: 12.0
  );

  static const labelUnSelectedTextStyle =    const   TextStyle(
     // color:  AppColors.color_black_80_2_2_2,
      fontWeight: FontWeight.w400,
      fontSize: 12.0
  );







}