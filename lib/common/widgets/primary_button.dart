import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';

enum IconAffinity { leading, trailing }

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final bool isLoading;
  final IconData icon;
  final bool isPrimary;
  final IconAffinity iconAffinity;
  final MainAxisAlignment alignment;

  const PrimaryButton(
      {Key key,
      this.onTap,
      @required this.text,
      this.isLoading = false,
      this.width,
      this.isPrimary = true,
      this.icon,
      this.iconAffinity = IconAffinity.leading,
      this.alignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    const kPrimaryColor = AppColors.mint100;
    final Widget iconM = Icon(
      icon,
      color: AppColors.color_black_100_2_2_2,
    );

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: FlatButton(
        onPressed: isLoading ? null : onTap,
        color: isPrimary ? kPrimaryColor : Colors.white,
        minWidth: width,
        splashColor: isPrimary ? AppColors.primaryText : Colors.grey,
        disabledColor: AppColors.light_grey_bg_color,
        disabledTextColor: AppColors.color_black_80_2.withOpacity(0.2),
        height: 42,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: isPrimary
                    ? onTap == null
                        ? AppColors.light_grey_bg_color
                        : kPrimaryColor
                    : AppColors.light_grey_blue)),
        textColor: isPrimary
            ? Colors.white
            : onTap == null
                ? AppColors.color_black_80_2
                : kPrimaryColor,
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              )
            : Row(
                mainAxisAlignment: alignment ?? MainAxisAlignment.center,
                children: [
                  if (icon != null && iconAffinity == IconAffinity.leading)
                    iconM,
                  if (icon != null)
                    SizedBox(
                      width: 8,
                    ),
                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyles.bUTTONBlack222,
                    ),
                  ),
                  if (icon != null && iconAffinity == IconAffinity.trailing)
                    iconM,
                ],
              ),
      ),
    );
  }
}
