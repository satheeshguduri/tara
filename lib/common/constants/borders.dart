/*
*  borders.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'color_const.dart';


class Borders {
  static const BorderSide primaryBorder = BorderSide(
    color: Color.fromARGB(255, 151, 151, 151),
    width: 1,
    style: BorderStyle.solid,
  );
  static const BorderSide secondaryBorder = BorderSide(
    color: Color.fromARGB(255, 176, 180, 194),
    width: 1,
    style: BorderStyle.solid,
  );

  static const textInputBorder = const UnderlineInputBorder(borderSide: const BorderSide(color: ColorConst.input_field_line_off_2_2_2));
  static const errorTextInputBorder = const UnderlineInputBorder(borderSide: const BorderSide(color: Colors.red));
}