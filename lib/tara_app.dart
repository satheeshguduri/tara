/*
*  tara_app.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tara_app/main.dart';
import 'package:tara_app/main_bindings.dart';
import 'package:tara_app/screens/splash/splash_screen.dart';
import 'package:tara_app/utils/locale/app_localization.dart';

import 'common/constants/app_theme.dart';
import 'flavors.dart';

class TaraApp extends StatefulWidget {
  @override
  _TaraAppState createState() => _TaraAppState();
}

class _TaraAppState extends State<TaraApp> {

  @override
  Widget build(BuildContext context) {
    final analytics = FirebaseAnalytics();
    final observer = FirebaseAnalyticsObserver(analytics: analytics);
    // MultiProvider for top-level services
    // that don't depend on any runtime values (e.g. uid)
    return MultiProvider(
      providers: [
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
//        Provider<GlobalStore>(create: (context)=> GlobalStore())
      ],
      child: GetMaterialApp(
        initialBinding: MainBindings(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
//            locale: Locale(window.),
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('id', ''), // Spanish, no country code
          ],
          home: SplashScreen(),
          title: "Tara",
          theme: themeData
      ),
    );
  }


}