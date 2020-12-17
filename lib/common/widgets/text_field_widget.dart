import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/styles.dart';

class TextFieldWidget extends StatefulWidget {
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
  final TextStyle placeHolderStyle;
  final int maxLines;
  final int height;
  final TextAlign alignment;
  final bool enableInteractiveSelection;
  final bool enable;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.inputType,
  @required this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.placeHolderStyle = BaseStyles.bankNameTextStyle,
    this.maxLines=1,
    this.height = 48,
    this.alignment = TextAlign.left,
    this.enableInteractiveSelection = true,
    this.enable=true,

  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}
class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.toDouble(),
      child: Padding(
        padding: widget.padding,
        child: TextFormField(
          enabled: widget.enable,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          controller: widget.textController,
          focusNode: widget.focusNode!=null?widget.focusNode:null,
          onFieldSubmitted: widget.onFieldSubmitted!=null?widget.onFieldSubmitted:null,
          onChanged: widget.onChanged!=null?widget.onChanged:null,
          autofocus: widget.autoFocus!=null?widget.autoFocus:null,
          textInputAction: widget.inputAction!=null?widget.inputAction:null,
          obscureText: widget.isObscure!=null?widget.isObscure:null,
          maxLength: getMaxLength(),
          minLines: 1,
          maxLines: widget.maxLines,
          keyboardType: widget.inputType!=null?widget.inputType:null,
          style: BaseStyles.bankNameTextStyle,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.hint!=null?widget.hint:"",
              hintStyle: widget.placeHolderStyle,
              errorText: widget.errorText!=null?widget.errorText:"",
              counterText: '',
              icon: widget.isIcon ? Icon(widget.icon, color: widget.iconColor) : null),
        ),
      ),
    );
  }

  int getMaxLength()
  {
    if (widget.inputType!=null)
    {
      if (widget.inputType==TextInputType.number){
        return 19;
      }
      else if (widget.inputType==TextInputType.phone){
        return 10;
      }
      else{
        return 150;
      }
    }
    return 150;
  }
}
