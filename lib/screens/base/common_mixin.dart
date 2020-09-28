/*
*  common_mixin.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:tara_app/utils/locale/app_localization.dart';
import 'package:toast/toast.dart';
////CommonMixin
/// @author Yakub Pasha.
///
///  Mixin which shares the common functionality with the BaseState
///  Few of its includes Toast, and Route Navigation,Logger and Firebase logging
mixin CommonMixin {
  BuildContext getContext();

  String getTranslation(String key) => AppLocalizations.of(getContext()).translate(key);
  ///logs firebase event with [data] provided
  void logEvent({@required String eventName, Map<String, dynamic> params}) {
    Provider.of<FirebaseAnalytics>(getContext(), listen: false)
        .logEvent(name: eventName, parameters: params);
  }

  Future<void> logUserId({@required String userId}) {
    return Provider.of<FirebaseAnalytics>(getContext()).setUserId(userId);
  }

  ///logs a [message] on the Log console
  void log(message) {
    Logger("tara").log(Level.INFO, message);
  }

  /// displays a toast with [message] provided with default [duration] short and [gravity] bottom.
  void showToast(
          {@required String message,
          int duration = 1,
          int gravity = 0,
          BuildContext context}) =>
      Toast.show(message, getContext(), duration: duration, gravity: gravity);

  /// Return the MaterialPageRoute Object with Screen Name set with the default Settings.
  MaterialPageRoute buildMaterialPageRoute(
          {@required Widget screen, settings}) =>
      MaterialPageRoute(
          maintainState: true,
          settings: RouteSettings(name: getScreenName(screen)),
          builder: (context) => screen);

  /// push the screen to navigation stack using navigator to the desired [screen]
  void push(Widget screen) =>
      Navigator.push(getContext(), buildMaterialPageRoute(screen: screen));

  ///Replace the existing screen on the navigation stack with [screen]
  void pushReplacement(Widget screen) => Navigator.pushReplacement(
      getContext(), buildMaterialPageRoute(screen: screen));

  /// Clear the navigation stack til [screen]
  void pushAndRemoveUntil(Widget screen) => Navigator.pushAndRemoveUntil(
      getContext(),
      buildMaterialPageRoute(screen: screen),
      (Route<dynamic> route) => false);

  ///Remove the latest screen in the navigation stack
  void pop() {
    Navigator.of(getContext()).pop();
  }

  /// Gets the screen name of [screen]
  @protected
  String getScreenName(Widget screen) {
    return screen.runtimeType.toString();
  }

  void hideKeyboard() {
    FocusScope.of(getContext()).unfocus();
  }
}
