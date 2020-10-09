import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/utils/locale/utils.dart';


class CircleShape extends StatefulWidget {
  final double width;
  final double height;
  final Color bgColor;

  const CircleShape( {
    Key key,
    this.width,
    this.height,
    this.bgColor,
  }) : super(key: key);

  @override
  _CircleShapeState createState() => _CircleShapeState();
}

class _CircleShapeState extends State<CircleShape> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: (widget.width!=null)?widget.width:50,
        height: (widget.height!=null)?widget.height:50,
        decoration: new BoxDecoration(
          color: (widget.bgColor!=null)?widget.bgColor:Color(0xffd8d8d8),
          shape: BoxShape.circle,
        ),
        child:Container());
  }
}