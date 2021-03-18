import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';

//this is valid for only one line
class UnderlineText extends StatelessWidget {
  final Text text;
  final VoidCallback onTap;

  const UnderlineText({@required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}