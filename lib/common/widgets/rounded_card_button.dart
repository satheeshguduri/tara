import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/styles.dart';
import '../../common/constants/values.dart';


class RoundedCardButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final String image;
  final VoidCallback onPressed;

  const RoundedCardButton({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  _RoundedCardButtonState createState() => _RoundedCardButtonState();
}

class _RoundedCardButtonState extends State<RoundedCardButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                boxShadow: [
                  Shadows.primaryShadow,
                ],
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 33,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only( top: 4),
              child: Text(
                widget.buttonText,
                textAlign: TextAlign.center,
                style: BaseStyles.sendTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ).onTap(onPressed: (){
        widget.onPressed();
    });

  }
}