/*
*  custom_button.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import '../../common/constants/values.dart';

import 'base_button.dart';

///Simple basic button with the [title]
class CustomButton extends BaseButton {
  CustomButton({String title, Function onPressed})
      : super(title: title, onPressed: onPressed);
}

/// Image Button
/// Sample Usage
/// ImageButton(title:"Google Sign Up",
///        color: AppColors.buttonSecondaryBackground,
///        textColor: AppColors.buttonSecondaryTextColor,
///        icon: Image.asset("assets/images/bitmap-9.png"))
class ImageButton extends BaseButton {
  ImageButton(
      {String title,
      Widget icon,
      Color color = AppColors.accentElement,
      Color textColor = AppColors.primaryText,
      Function onPressed})
      : super(
            title: title,
            icon: icon,
            onPressed: onPressed,
            color: color,
            textColor: textColor); //Image.asset("assets/images/bitmap-9.png",)
}
