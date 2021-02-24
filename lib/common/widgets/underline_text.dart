import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';

class UnderlineText extends StatelessWidget {
  final Text text;

  const UnderlineText({this.text});
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          text,
          SizedBox(
            height: 2,
          ),
          Container(
            height: 2,
            color: AppColors.mint100,
          )
        ],
      ),
    );
  }
}
