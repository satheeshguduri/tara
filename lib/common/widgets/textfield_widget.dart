import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final ValueChanged onChanged;
  final bool autoFocus;
  final TextInputAction inputAction;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.inputType,
    this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: Padding(
        padding: padding,
        child: TextFormField(
          controller: textController,
          focusNode: focusNode!=null?focusNode:null,
          onFieldSubmitted: onFieldSubmitted!=null?onFieldSubmitted:null,
          onChanged: onChanged!=null?onChanged:null,
          autofocus: autoFocus!=null?autoFocus:null,
          textInputAction: inputAction!=null?inputAction:null,
          obscureText: this.isObscure!=null?this.isObscure:null,
          maxLength: 25,
          minLines: 1,
          maxLines: 1,
          keyboardType: this.inputType!=null?this.inputType:null,
          style: Theme.of(context).textTheme.body1,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: this.hint!=null?this.hint:"",
              hintStyle:
              Theme.of(context).textTheme.body1.copyWith(color: hintColor),
              errorText: errorText!=null?errorText:"",
              counterText: '',
              icon: this.isIcon ? Icon(this.icon, color: iconColor) : null),
        ),
      ),
    );
  }

}
