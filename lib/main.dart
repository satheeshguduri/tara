/*
*  main.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/
import 'dart:async';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/widgets/custom_button.dart';
import 'package:tara_app/common/widgets/rounded_button.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/base/base_state_less_widget.dart';
import 'utils/locale/app_localization.dart';
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

class _TaraAppState extends BaseState<TaraApp> {

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
      ],
      child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: Locale(window.locale.languageCode, ''),
                supportedLocales: [
                  const Locale('en', ''),
                  const Locale('id', ''),
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocaleLanguage in supportedLocales) {
                    if (supportedLocaleLanguage.languageCode == locale.languageCode &&
                        supportedLocaleLanguage.countryCode == locale.countryCode) {
                      return supportedLocaleLanguage;
                    }
                  }
                  // If device not support with locale to get language code then default get first on from the list
                  return supportedLocales.first;
                },
                home: TestWidget(),
                title: "Tara",//AppLocalizations.of(context).translate(Strings.APP_TITLE),//getTranslation(context,Strings.APP_TITLE),
                theme: themeData
            )
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }
}

class TestWidget extends BaseStateLessWidget  {
  TestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(window.locale.languageCode.toString()),
              Text(
                getTranslatedString(context,Strings.SEND),
                textAlign: TextAlign.center,
              ),
              RoundedButton(),
              CustomButton(title:'Test'),
              ImageButton(icon: Image.asset('assets/images/icon-2.png'),title: "Add Account",)

            ],
          ),
        ),
      ),
    );
  }
}
