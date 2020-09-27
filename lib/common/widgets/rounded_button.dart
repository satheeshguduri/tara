import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton({Key key}) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: 70,
        height: 96,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 53, 86),
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 33,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      "assets/images/icon-35.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, bottom: 14),
              child: Text(
                "Send",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 19, 53, 86),
                  fontFamily: "",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}