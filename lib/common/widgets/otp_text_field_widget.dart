import 'package:flutter/material.dart';

enum FieldStyle {
  underline,
}

class OTPTextFieldWidget extends StatefulWidget {
  /// Number of the OTP Fields
  final int length;

  /// Total Width of the OTP Text Field
  final double width;

  /// Width of the single OTP Field
  final double fieldWidth;

  /// Manage the type of keyboard that shows up
  TextInputType keyboardType;

  /// The style to use for the text being edited.
  final TextStyle style;

  /// Text Field Alignment
  /// default: MainAxisAlignment.spaceBetween [MainAxisAlignment]
  final MainAxisAlignment textFieldAlignment;

  /// Obscure Text if data is sensitive
  final bool obscureText;

  /// Text Field Style for field shape.
  /// default FieldStyle.underline [FieldStyle]
  final FieldStyle fieldStyle;

  /// Callback function, called when a change is detected to the pin.
  final ValueChanged<String> onChanged;

  /// Callback function, called when pin is completed.
  final ValueChanged<String> onCompleted;

  final String correctPin;

  OTPTextFieldWidget(
      {Key key,
        this.length = 4,
        this.width = 10,
        this.fieldWidth = 30,
        this.keyboardType = TextInputType.number,
        this.style = const TextStyle(),
        this.textFieldAlignment = MainAxisAlignment.spaceEvenly,
        this.obscureText = false,
        this.fieldStyle = FieldStyle.underline,
        this.onChanged,
        this.onCompleted,
        this.correctPin})
      : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextFieldWidget> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  List<Widget> _textFields;
  List<String> _pin;
  bool isOtpEntered = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData()
  {
    _focusNodes = List<FocusNode>(widget.length);
    _textControllers = List<TextEditingController>(widget.length);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
    _textFields = List.generate(widget.length, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void dispose() {
    _textControllers
        .forEach((TextEditingController controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields,
      ),
    );
  }

  /// This function Build and returns individual TextField item.
  ///
  /// * Requires a build context
  /// * Requires Int position of the field
  Widget buildTextField(BuildContext context, int i) {
      if (_focusNodes[i] == null) _focusNodes[i] = FocusNode();

      if (_textControllers[i] == null) {
        _textControllers[i] = TextEditingController();
      }

    return Container(
      width: widget.fieldWidth,
      child: TextField(
        cursorColor: Color(0xff123456),
        controller: _textControllers[i],
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: widget.style,
        focusNode: _focusNodes[i],
        obscureText: widget.obscureText,
          decoration: InputDecoration(
              counterText: "",
              focusedBorder : InputBorder.none,
              enabledBorder : InputBorder.none,
              errorBorder : InputBorder.none,
//            focusedBorder: UnderlineInputBorder(
//              borderSide: BorderSide(width: 2,color: Color(0xffb2f7e2)),
//            ),
//            enabledBorder: UnderlineInputBorder(
//              borderSide: BorderSide(width: 2,color: isOtpEntered?Color(0xffb2f7e2):Color(0xffb0b4c1)),
//            ),
//            errorBorder:UnderlineInputBorder(
//              borderSide: BorderSide(width: 2,color: Colors.pink),
//            ),
          ),
        onChanged: (String str) {
          // Check if the current value at this position is empty
          // If it is move focus to previous text field.
          if (str.isEmpty) {
            if (i == 0) return;
            _focusNodes[i].unfocus();
            _focusNodes[i - 1].requestFocus();
          }

          // Update the current pin
          setState(() {
            _pin[i] = str;
          });

          // Remove focus
          if (str.isNotEmpty) _focusNodes[i].unfocus();
          // Set focus to the next field if available
          if (i + 1 != widget.length && str.isNotEmpty) {
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          }

          var currentPin = "";
          _pin.forEach((String value) {
            currentPin += value;
          });

          // if there are no null values that means otp is completed
          // Call the `onCompleted` callback function provided
          if (!_pin.contains(null) &&
              !_pin.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted(currentPin);
            setState(() {
              isOtpEntered = true;
            });
          }else{
            setState(() {
              isOtpEntered = false;
            });
          }

          // Call the `onChanged` callback function
          widget.onChanged(currentPin);
        },
      ),
    );
  }
}