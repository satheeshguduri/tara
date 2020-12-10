

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/screens/agent/agent_home_screen.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/screens/create_account_screen.dart';
import 'package:tara_app/screens/merchant/merchant_home_screen.dart';

import '../../flavors.dart';
import '../../tara_app.dart';

class SplashScreen extends StatefulWidget{
  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends BaseState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),() async{
     // var database = await Hive.openBox('DNC');
     //  var data = database.get("LoginResponse") as LoginResponse;
     //  var data  = DataBaseHelper().getLoginInfo();
     // if(data!=null){
     //   Get.off(HomeScreen());
     //    //Get.off(HomeScreen(),arguments: data);
     //  }else{
     //    Get.off(LoginScreen());
     //  }
     //  log("saved data "+data.toString());



      getLandingScreen();



    });


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Container(

           child: Image.asset(Assets.splashlogo,fit: BoxFit.none),



        ),
      ),
    );

  }


  Widget getLandingScreen(){
    if(Flavor.CONSUMER == F.appFlavor){
      return HomeCustomerScreen();
    }else if(Flavor.MERCHANT == F.appFlavor){
      return MerchantHomeScreen();
    }else if(Flavor.AGENT == F.appFlavor){
      return AgentHomeScreen();
    }

    return HomeCustomerScreen();
  }



  @override
  BuildContext getContext() =>context;
}
