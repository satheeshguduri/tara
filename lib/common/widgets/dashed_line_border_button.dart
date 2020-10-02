import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:dotted_border/dotted_border.dart';

class DashedLineBorderButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final String image;
  final VoidCallback onPressed;

  const DashedLineBorderButton( {
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  _DashedLineBorderButtonState createState() => _DashedLineBorderButtonState();
}

class _DashedLineBorderButtonState extends State<DashedLineBorderButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onPressed();
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.only(left: 16,right: 16,),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.grey[400],
          strokeWidth:1.5,
          radius: Radius.circular(8),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              padding: EdgeInsets.only(top: 8,bottom: 8),
              color: widget.buttonColor,
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset(
                      "assets/images/icon-2.png",
                      fit: BoxFit.none,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 12,left: 4),
                    child: Text(
                      widget.buttonText,
                      textAlign: TextAlign.left,
                      style: BaseStyles.myAccountItemTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}