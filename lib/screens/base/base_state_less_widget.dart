/*
*  base_state_less_widget.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:tara_app/screens/base/common_mixin.dart';
import 'package:tara_app/utils/locale/app_localization.dart';

abstract class BaseStateLessWidget extends StatelessWidget {


  BaseStateLessWidget({Key key}) : super(key: key);

  String getTranslatedString(BuildContext context,String key) => AppLocalizations.of(context).translate(key);

}