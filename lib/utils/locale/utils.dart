import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/utils/locale/app_localization.dart';

class Utils {
  static final Utils _instance = Utils._();
  static bool introStatus;
  static SharedPreferences preferences;
  OverlayEntry overlayEntry;
  Utils._();

  factory Utils() {
    return _instance;
  }

  String getTranslation(String key) => AppLocalizations.of(getContext()).translate(key);

  BuildContext getContext() {
    return this.getContext();
  }
}
