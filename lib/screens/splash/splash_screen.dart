

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/screens/agent/agent_home_screen.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/screens/merchant/merchant_home_screen.dart';
import 'package:tara_app/screens/signin_screen.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../../flavors.dart';
import '../../injector.dart';
import '../../tara_app.dart';

class SplashScreen extends StatefulWidget{
  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends BaseState<SplashScreen> {

  bool isLoggedIn = false;
  @override
  void init() async{
    var data = await getIt.get<UserLocalDataStore>().getUser();
    data.fold(
            (l) => print,
            (r) => {
              if(r?.securityToken?.token!=null){
                isLoggedIn = true
              }
            });
    Timer(Duration(seconds: 5),() async{
      if(!isLoggedIn)
        Get.off(SignInScreen());
      else
        Get.off(Utils().getLandingScreen());
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Container(
           child: Image.asset(Assets.tara_logo,fit: BoxFit.fitHeight).withPad(padding: EdgeInsets.all(40)),
        ),
      ),
    );
  }
  @override
  BuildContext getContext() =>context;
}
