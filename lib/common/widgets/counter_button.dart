import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/primary_button.dart';
import 'package:tara_app/controller/cart_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/item/item.dart';

import '../../screens/base/base_state.dart';
import '../constants/color_const.dart';
import '../../common/widgets/extensions.dart';
import '../constants/color_const.dart';

class Counter extends StatefulWidget {
  final String title;
  final Function onChange;
  final initialCount;
  final int maxCount;
  final String errorMessage;
  final Item item;

  const Counter(this.item,
      {Key key,
      this.onChange,
      this.title,
      this.initialCount,
      this.maxCount = 99,
      this.errorMessage})
      : super(key: key);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends BaseState<Counter> {
  int _count = 0;

  CartController controller;
  @override
  void initState() {
    super.initState();
    _count = widget.initialCount ?? 0;
    controller = getIt.get<CartController>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      switchInCurve: Curves.bounceInOut,
      child: _count == 0
          ? PrimaryButton(
              text: widget.title ?? "Add",
              onTap: () => addToCart(),
            )
          : Container(
              height: 42,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => _decrement(),
                    child: Container(
                      height: 42,
                      width: 42,
                      color: ColorConst.mint100,
                      child: Icon(
                        Icons.remove,
                        size: 24,
                        color: ColorConst.black100,
                      ),
                    ).borderRadiusAll(6),
                  ),
                  Expanded(
                    child: Container(
                      height: 42,
                      constraints: BoxConstraints(minWidth: 36),
                      alignment: Alignment.center,
                      child: Text(
                        '$_count',
                        key: ValueKey<int>(_count),
                        style: TextStyles.bUTTONBlack222,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _increment(),
                    child: Container(
                      height: 42,
                      width: 42,
                      color: ColorConst.mint100,
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: ColorConst.black100,
                      ),
                    ).borderRadiusAll(6),
                  ),
                ],
              ),
            ),
    );
  }

  void addToCart() {
    setState(() {
      controller.addToCart(widget.item);
      _count++;
    });
  }

  _increment() {
    setState(() {
      ++_count;
      widget.onChange(_count);
      if (_count > 1) {
        controller.updateCart(widget.item, _count);
      }
    });
  }

  _decrement() {
    setState(() {
      --_count;
      widget.onChange(_count);
      if (_count == 0) {
        controller.removeFromCart(widget.item);
      } else {
        controller.updateCart(widget.item, _count);
      }
    });
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
