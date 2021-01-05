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
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/tara_app.dart';

import 'common/constants/fonts.dart';


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
class TestWidget extends StatelessWidget {
  TestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Demo of components"),
          TextField(
            decoration: const InputDecoration(
              hintText: 'What do people call you?',
              hintStyle: TextStyle(height:5, fontWeight: FontWeight.bold,color: Colors.red),
              labelText: 'Name *',
              labelStyle: TextStyle(height:5, fontWeight: FontWeight.bold,color:Colors.grey),
            )),

            TextField(textAlignVertical:TextAlignVertical.bottom,decoration: InputDecoration(
              hintText: "Test",
              labelText: "Phone Number",
              floatingLabelBehavior: FloatingLabelBehavior.always,

              // floatingLabelBehavior: FloatingLabelBehavior.always,
            )),
              // Spacer(),
              OutlineButton.icon(onPressed: (){}, icon: Image.asset(Assets.ic_chat,width: 24,height: 24), label: Text("Submit Button")),
              FlatButton(onPressed: (){}, child: Text("Submit")),
              RaisedButton(onPressed: (){},child: Text("Raised Button"))
            ],
          ),
        ),
      ),
    );
  }
}
