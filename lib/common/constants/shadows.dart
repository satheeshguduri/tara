/*
*  shadows.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/rendering.dart';
import 'package:tara_app/common/constants/colors.dart';


class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(31, 0, 0, 0),
    offset: Offset(0, 4),
    blurRadius: 6,
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color.fromARGB(26, 0, 0, 0),
    offset: Offset(0, 4),
    blurRadius: 8,
  );

  static const List<BoxShadow> shadows_list = [
    BoxShadow(
        color: AppColors.box_shadow_color_1,
        offset: Offset(0, 4),
        blurRadius: 6,
        spreadRadius: 0),
    BoxShadow(
        color: AppColors.box_shadow_color_2,
        offset: Offset(0, 0),
        blurRadius: 2,
        spreadRadius: 0)
  ];
}