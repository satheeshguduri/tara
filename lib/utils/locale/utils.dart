import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/common/widgets/input_done_view.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/screens/Merchant/create_store_screen.dart';
import 'package:tara_app/screens/agent/agent_home_screen.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/screens/merchant/merchant_home_screen.dart';
import 'package:tara_app/screens/signin_screen.dart';
import 'package:tara_app/utils/locale/app_localization.dart';

import '../../flavors.dart';

class Utils {
  static final Utils _instance = Utils._();
  static bool introStatus;
  static SharedPreferences preferences;
  OverlayEntry overlayEntry;
  Utils._();

  factory Utils() {
    return _instance;
  }

  String getTranslation(String key,context) => AppLocalizations.of(context).translate(key);

  void showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView());
    });
    overlayState.insert(overlayEntry);
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  /*used to hide key board*/
  void hideKeyBoard(BuildContext mContext) {
    FocusScope.of(mContext).requestFocus(FocusNode());
  }
  String getDefaultFormattedDate(DateTime date)
  {
    return getStringFromDate(date,"EEE, MMM dd yyyy - HH:mm");
//    final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat(format); //'yyyy-MM-dd'
//     final String formatted = formatter.format(date);
//     return formatted;
  }
  String getStringFromDate(DateTime date, String format)
  {
//    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(format); //'yyyy-MM-dd'
    final String formatted = formatter.format(date);
    return formatted;
  }
  String getMaskedAccountNumber(String fullString) {
    if(fullString?.isEmpty??false) return "*****";
    List<String> list = fullString?.split('#')?.toList();
    if(list?.isEmpty??false)
      return "*****";
    else return "******"+ list[0].substring(list[0].length - 4);

  }
  Widget getIntoCreateStoreScreen(){
    switch(F.appFlavor){
      case Flavor.CONSUMER:
        return HomeCustomerScreen();
        break;
      case Flavor.MERCHANT:
        return CreateStoreScreen();
        break;
      case Flavor.AGENT:
        return AgentHomeScreen();
        break;
      default:
        return SignInScreen();
    }
  }


  CustomerProfile getCustomerProfile(){
    return CustomerProfile(firebaseId:"MID-7272c9fa010b40398210e937b76b1e9a",customerType:"MERCHANT",mobileNumber:"+918886778633",id:60,firstName: "Yakub Merchant new");
  }
  Widget getLandingScreen(){
    switch(F.appFlavor){
      case Flavor.CONSUMER:
        return HomeCustomerScreen();
        break;
      case Flavor.MERCHANT:
        return MerchantHomeScreen();
        break;
      case Flavor.AGENT:
        return AgentHomeScreen();
        break;
      default:
        return SignInScreen();
    }

  }
  String getCustomerType(){
    switch(F.appFlavor){
      case Flavor.CONSUMER:
          return "Consumer";
          break;
      case Flavor.MERCHANT:
        return "Merchant";
        break;
      case Flavor.AGENT:
        return "Agent";
        break;
      default:
        return "Consumer";
    }

  }

  void savePrefStringValue(String prefsKey, String value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(prefsKey, value);
  }

  Future<String> getPrefStringValue(String prefsKey) async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(prefsKey) != null
        ? preferences.getString(prefsKey)
        : "";
  }

  void savePrefBoolValue(String prefsKey, bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(prefsKey, value);
  }

  Future<bool> getPrefBoolValue(String prefsKey) async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(prefsKey) != null
        ? preferences.getBool(prefsKey)
        : false;
  }
}
