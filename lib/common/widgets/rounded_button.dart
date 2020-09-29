import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/styles.dart';

class RoundedButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final String image;
  final VoidCallback onPressed;

  const RoundedButton({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (widget.onPressed!=null)
          {
            widget.onPressed();
          }
      },
      child: Container(
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 53, 86),
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
      ),
    );
  }
}