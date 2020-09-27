/*
*  shadows.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/rendering.dart';


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
}