import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DotsIndicator extends StatelessWidget {
  final int currentIndex;

  final int totalPages;
  final Function onChange;

  final Color color;

  // The base size of the dots
  static const double _kDotSize = 6.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 10.0;

  DotsIndicator(this.currentIndex, this.totalPages,
      {this.color, this.onChange});

  Widget _buildDot(int index) {
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color ?? Colors.white,
          type: MaterialType.circle,
          child: InkWell(
            onTap: () => onChange(index),
            child: new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  _kDotSize,
                ),
                color: currentIndex == index
                    ? AppColors.black100
                    : Colors.grey.shade300,
              ),
              width: _kDotSize,
              height: _kDotSize,
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(totalPages, _buildDot),
    );
  }
}
