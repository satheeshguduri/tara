/*
*  extensions.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';

import '../../services/error/network_exceptions.dart';

extension PaddedWidget on Widget {
  Widget withPad(
      {EdgeInsets padding = const EdgeInsets.only(top: 5.0, bottom: 5.0)}) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget horizontalPad(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget verticalPad(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  Widget all(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }
}

extension StyledText on String {
  Widget withStyle(TextStyle style) {
    return Text(this, style: style);
  }

  String bearer() {
    return "Bearer " + this;
  }
}

extension TappableWidget on Widget {
  Widget onTap({Function onPressed}) {
    return InkWell(
      child: this,
      onTap: onPressed,
    );
  }
}

extension ObservableWidget on Widget {
  Widget obX() => Obx(() => this);
}

extension ProgressIndicator on Widget {
  ModalProgressHUD withProgressIndicator(
      {Widget progressIndicator = BaseWidgets.getIndicator,
      bool showIndicator}) {
    return ModalProgressHUD(
        progressIndicator: progressIndicator,
        inAsyncCall: showIndicator,
        color: AppColors.primaryElement,
        child: this);
  }
}

extension RadiusExtensions on Widget {
  Widget borderRadiusAll(double radius) {
    return ClipRRect(
      child: this,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  Widget borderRadiusLeft(double radius) {
    return ClipRRect(
      child: this,
      borderRadius: BorderRadius.horizontal(left: Radius.circular(radius)),
    );
  }

  Widget borderRadiusRight(double radius) {
    return ClipRRect(
      child: this,
      borderRadius: BorderRadius.horizontal(right: Radius.circular(radius)),
    );
  }
}
