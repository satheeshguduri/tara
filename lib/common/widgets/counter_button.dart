import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tara_app/common/widgets/primary_button.dart';

import '../../screens/base/base_state.dart';
import '../constants/color_const.dart';
import '../../common/widgets/extensions.dart';
import '../constants/color_const.dart';

class Counter extends StatefulWidget {
  final String title;
  final Function onChange;
  final initialCount;

  const Counter({Key key, this.onChange, this.title, this.initialCount})
      : super(key: key);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends BaseState<Counter> {
  int _count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = widget.initialCount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      switchInCurve: Curves.bounceInOut,
      child: _count == 0
          ? PrimaryButton(
              text: widget.title ?? "Add",
              onTap: () {
                _increment();
              },
            )
          : Container(
              height: 42,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _decrement(),
                      child: Container(
                        height: 42,
                        color: ColorConst.mint100,
                        child: Icon(
                          Icons.remove,
                          size: 24,
                          color: ColorConst.black100,
                        ),
                      ).borderRadiusAll(8),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 42,
                      alignment: Alignment.center,
                      child: Text(
                        '$_count',
                        key: ValueKey<int>(_count),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _increment(),
                      child: Container(
                        height: 42,
                        color: ColorConst.mint100,
                        child: Icon(
                          Icons.add,
                          size: 24,
                          color: ColorConst.black100,
                        ),
                      ).borderRadiusAll(8),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _increment() {
    if (_count < 99) {
      setState(() {
        ++_count;
        widget.onChange(_count);
      });
    } else {
      showToast(message: "Can not add more than 99 items");
    }
  }

  _decrement() {
    if (_count > 0) {
      setState(() {
        --_count;
        widget.onChange(_count);
      });
    } else {
      //delete this item from the cart
    }
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
