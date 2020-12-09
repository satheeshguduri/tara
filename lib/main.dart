/*
*  main.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/tara_app.dart';


void main() async{
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

void enableLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((onData) {
    print('${onData.time} : ${onData.level.name}: ${onData.message}');
  });
}
// class TestWidget extends StatelessWidget {
//   TestWidget({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(40),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text("Demo of components"),
//               RoundedButton(),
//               ImageButton(icon: Image.asset('assets/images/icon-2.png'),title: "Add Account",)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
