/*
*  app_theme.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'font_family.dart';

final ThemeData themeData = new ThemeData(
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
/*
get theme =>ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  }),
  primaryColor: Colors.green,//AppColors.primaryBackground,
  textTheme: GoogleFonts.senTextTheme(Theme.of(context).textTheme)
      .copyWith(
    headline1: GoogleFonts.sen(
        textStyle: Theme.of(context).textTheme.headline1),
  ),
);*/
