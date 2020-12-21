import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/chat/payment_success.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/firebase_remote_service.dart';
import 'package:tara_app/models/auth/auth_response.dart';

import '../injector.dart';

class ChatTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthResponse user = Get.find<AuthController>().user.value;
    return new Scaffold(
      appBar: new AppBar(title: new Text("Firebase test"),),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
                query: getIt.get<FirebaseRemoteService>().getDataStream(path:FirebasePath.getPath(user.customerProfile.firebaseId,"MID-485bafe8600846e2966c88cbce3e0f40")),
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int x) {
                  return new ListTile(
                    subtitle: new Text(snapshot.value.toString()),
                  );
                }
            ),
          ),
          Container(
            height: 100,
            width: 400,
            color: Colors.red,
            child: Text("Submit").onTap(onPressed: (){
              var data = PaymentSuccess(amount: 400,
                payerId: "CID-7231947ee8f5436fb193ec63721759fa",
                payeeId: "MID-485bafe8600846e2966c88cbce3e0f40",status: "SUCCESS",timestamp: DateTime.now());
              getIt.get<FirebaseRemoteService>().setData(
                  path: FirebasePath.getPath("CID-7231947ee8f5436fb193ec63721759fa","MID-485bafe8600846e2966c88cbce3e0f40"),
                  data: data.toJson());
            }),
          )
          
        ],
      ),
    );
  }
}
