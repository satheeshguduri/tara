/*
*  base_button.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import '../constants/values.dart';

abstract class BaseButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final Widget icon;

  BaseButton(
      {this.title = "Button",
      this.onPressed,
      this.icon,
      this.child,
      this.color = AppColors.secondaryElement,
      this.textColor = AppColors.primaryText});

  @override
  Widget build(BuildContext context) {
    return getDefaultButton();
  }

  @protected
  Widget getDefaultButton() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
      child: FlatButton(
          onPressed: () => onPressed(),
          color: color, //AppColors.accentElement,//default
          shape: RoundedRectangleBorder(
            borderRadius: Radii.k8pxRadius,
          ),
          textColor: textColor, //AppColors.textColor,//default
          padding: EdgeInsets.all(0),
          child: child ?? getBaseView() //if child null put a default title
          ),
    );
  }

  @protected
  Widget getBaseView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: icon != null,
          child: icon ?? Image.asset("assets/images/bitmap-9.png"),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @protected
  Text getTitle(String title, Color textColor) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
