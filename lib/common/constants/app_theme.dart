/*
*  app_theme.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/borders.dart';
import 'package:tara_app/common/constants/color_const.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'colors.dart';
import 'font_family.dart';
import 'fonts.dart';
import 'radii.dart';
final ThemeData themeData = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    fontFamily: FontFamily.scto,
    brightness: Brightness.light,
    //primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.primaryBackground,
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.accentElement,
    accentColorBrightness: Brightness.light
);
/*final ThemeData themeData = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    fontFamily: FontFamily.scto,
    brightness: Brightness.light,
    //primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.primaryBackground,
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.accentElement,
    accentColorBrightness: Brightness.light,
    appBarTheme: AppBarTheme(
        color: AppColors.secondaryBackground,
        elevation:0.5,
        iconTheme: IconThemeData(
          color: AppColors.secondaryElement,
        )
    ),
    textTheme: TextTheme(
      bodyText1: BaseTextStyles.body12,
      bodyText2: BaseTextStyles.body1222,
      button: BaseTextStyles.bUTTONBlack2,
      caption: BaseTextStyles.caption2,
      subtitle1: BaseTextStyles.subtitle12, // <-- that's the one
      subtitle2: BaseTextStyles.subtitle22,
      headline1: BaseTextStyles.headline12,
      headline2: BaseTextStyles.headline22,
      headline3: BaseTextStyles.headline32,
      headline4: BaseTextStyles.headline42,
      headline5: BaseTextStyles.headline52,
      headline6: BaseTextStyles.headline62,
    ),
    buttonTheme: ButtonThemeData(
        height: 48,
        disabledColor: ColorConst.grey2,
        buttonColor: ColorConst.color_mint_100_2_2_2,
        shape: RoundedRectangleBorder(
          borderRadius: Radii.k8pxRadius,
        ),

        textTheme: ButtonTextTheme.primary
    ),

    inputDecorationTheme: InputDecorationTheme(
        // contentPadding: EdgeInsets.only(top:2,left:12,bottom: 2),
        // fillColor: AppColors.secondaryElement,
        // filled: true,
        border: Borders.textInputBorder,
        disabledBorder: Borders.textInputBorder,
        errorBorder:Borders.textInputBorder,
        focusedBorder: Borders.textInputBorder,
        enabledBorder: Borders.textInputBorder,
        hintStyle: TextStyles.inputFieldOff222,
        labelStyle: TextStyles.caption222

    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black,
      labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(fontSize: 13),
      unselectedLabelStyle: TextStyle(fontSize: 13),
    ),
);*/

