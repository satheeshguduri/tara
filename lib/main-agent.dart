import 'package:flutter/material.dart';
import 'package:tara_app/tara_app.dart';
import 'flavors.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:tara_app/main.dart';

import 'injector.dart';

void main() async{
  F.appFlavor = Flavor.AGENT;
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded((){
      runApp(TaraApp());

    }, (obj,trace){});//Crashlytics.instance.recordError);
  });
  enableLogging();
}
