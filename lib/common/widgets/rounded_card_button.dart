import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import '../../common/constants/values.dart';


class RoundedCardButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final String imageURL;
  final VoidCallback onPressed;
  final int imageIndex;

  const RoundedCardButton({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.imageURL,
    this.onPressed,
    this.imageIndex
  }) : super(key: key);

  @override
  _RoundedCardButtonState createState() => _RoundedCardButtonState();
}

class _RoundedCardButtonState extends State<RoundedCardButton> {

  var prePaidIconsArray = [Assets.MOBILE_ICON,Assets.INTERNET_ICON, Assets.PLN_ICON, Assets.BJPS_ICON,Assets.PULSA_ICON];

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                boxShadow: [
                  Shadows.primaryShadow,
                ],
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 33,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageURL,
                    placeholder: (context,url)=> BaseWidgets.getIndicator,
                    errorWidget: (context,url,error)=> Image.asset(prePaidIconsArray[widget.imageIndex]),
                  ),




                  // Image.asset(
                  //   widget.image,
                  //   fit: BoxFit.none,
                  //  ),
                 // child:  Image.network(imageUrlValidation(widget.image))
                ),
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only( top: 4),
              child: Text(
                widget.buttonText,
                textAlign: TextAlign.center,
                style: BaseStyles.sendTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ).onTap(onPressed: (){
        widget.onPressed();
    });

  }

  String imageUrlValidation(String imageUrl) {  /// TODO
    if(imageUrl!=null && imageUrl.isNotEmpty){
          return imageUrl;
    }else{
          return "https://picsum.photos/250?image=9";
    }


  }
}