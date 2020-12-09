import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tara_app/common/widgets/input_done_view.dart';
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

  String getStringFromDate(DateTime date, String format)
  {
//    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(format); //'yyyy-MM-dd'
    final String formatted = formatter.format(date);
    return formatted;
  }
}
