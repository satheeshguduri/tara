/*
*  main.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/
import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:tara_app/common/widgets/custom_button.dart';
import 'package:tara_app/common/widgets/rounded_button.dart';
import 'package:tara_app/screens/Agent/AgentHomeScreen.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/utils/locale/app_localization.dart';
import 'common/constants/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded((){
      runApp(TaraApp());

    }, Crashlytics.instance.recordError);
  });
  enableLogging();
}

void enableLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((onData) {
    print('${onData.time} : ${onData.level.name}: ${onData.message}');
  });
}
class TaraApp extends StatefulWidget {
  @override
  _TaraAppState createState() => _TaraAppState();
}

class _TaraAppState extends State<TaraApp> {

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarColor: AppColors.appBarColor,
//        statusBarIconBrightness:Brightness.dark
//    ));
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
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('id', ''), // Spanish, no country code
          ],
            home: AgenttHomeScreen(),
            title: "Tara",
            theme: themeData
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  TestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Demo of components"),
              RoundedButton(),
              ImageButton(icon: Image.asset('assets/images/icon-2.png'),title: "Add Account",)
            ],
          ),
        ),
      ),
    );
  }
}
