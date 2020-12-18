

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/signin_screen.dart';
import 'package:tara_app/utils/locale/utils.dart';
import '../../injector.dart';

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
    if(data?.securityToken?.token!=null){
      Get.put(data);
      isLoggedIn = true;
    }
    Timer(Duration(seconds: 5),() async{
      if(!isLoggedIn)
        Get.off(SignInScreen());
      else
        Get.off(Utils().getLandingScreen());
    });
    // get the Storetype

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
