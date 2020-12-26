/*
*  get_helper.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';

class GetHelper{
  GetHelper();

  getDialog({String title,Widget content}){
    Get.defaultDialog(title: title??"",content: content);
  }

}