import 'package:flutter/material.dart';
import 'flavors.dart';
import 'dart:async';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:tara_app/main.dart';

void main() async{
  F.appFlavor = Flavor.AGENT;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded((){
      runApp(TaraApp());

    }, (obj,trace){});//Crashlytics.instance.recordError);
  });
  enableLogging();
}
