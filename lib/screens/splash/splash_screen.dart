

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/signin_screen.dart';
import 'package:tara_app/utils/locale/utils.dart';
import '../../injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';

import '../../utils/locale/utils.dart';
import '../signin_screen.dart';

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
      Get.put<AuthResponse>(data);
      var controller = Get.find<AuthController>();
      controller.user.value = data;
      isLoggedIn = true;
    }
    Timer(Duration(seconds: 5),() async{
      if(!isLoggedIn)
        Get.off(Utils().getLandingScreen());
      else
        Get.off(Utils().getLandingScreen());
    });
    // get the Storetype

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
          width: double.infinity,
          decoration:BoxDecoration(
            gradient: Gradients.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(16.0),
              bottomRight: const Radius.circular(16.0),
            ),),
        child: Center(
            child: Container(
             child: Image.asset(Assets.tara_logo,fit: BoxFit.fitWidth,width: 200,).withPad(padding: EdgeInsets.all(40)),
          ),
        ),
      ),
    );
  }
  @override
  BuildContext getContext() =>context;
}
