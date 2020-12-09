import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flavors.dart';
import 'main.dart';
import 'tara_app.dart';

void main() async{
  F.appFlavor = Flavor.CONSUMER;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded((){
      runApp(TaraApp());

    },(obj,trace){}); //Crashlytics.instance.recordError);
  });
  enableLogging();
}
