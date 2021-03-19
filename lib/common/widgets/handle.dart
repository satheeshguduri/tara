import 'package:flutter/material.dart';

class Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:4,
      width: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.shade300,
      ),
    );
  }
}
