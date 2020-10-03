import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flavors.dart';
import 'main.dart';

void main() async{
  F.appFlavor = Flavor.CONSUMER;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded((){
      runApp(TaraApp());

    }, Crashlytics.instance.recordError);
  });
  enableLogging();
}
