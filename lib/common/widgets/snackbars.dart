import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';

class Snackbars {
  static Widget productAdditionSnackbar(String message) {
    return GetBar(
      margin: EdgeInsets.all(16),
      backgroundColor: AppColors.mint100,
      borderRadius: 8,
      messageText: Container(
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(
                Icons.done,
                color: AppColors.black100,
                size: 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black100),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                    color: AppColors.black100, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 200),
    );
  }

  static Widget errorSnackbar(String message) {
    return GetBar(
      margin: EdgeInsets.all(16),
      backgroundColor: Colors.redAccent,
      borderRadius: 8,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 200),
    );
  }
}