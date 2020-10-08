
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/utils/locale/utils.dart';


class CustomCard extends StatefulWidget {
  final String image;
  final String bankIcon;
  final String accountNumber;
  final String accountName;
  final bool isMyAccountCard;
  final String rightIcon;

  const CustomCard( {
    Key key,
    this.image,
    this.bankIcon,
    this.accountNumber,
    this.accountName,
    this.isMyAccountCard = false,
    this.rightIcon
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          (widget.image!=null&&widget.image!="")?Image.asset(widget.image, fit: BoxFit.cover):Container(),
          Positioned(
            top: 16,
            left: 16,
            child: (widget.bankIcon!=null&&widget.bankIcon!="")
                ?Container( decoration: BoxDecoration(
              color: widget.isMyAccountCard ? Colors.transparent : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),padding:EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
              child: Image.asset(widget.bankIcon,
                  fit: BoxFit.fill,
                width: widget.isMyAccountCard ? 44 : null,
              ),):
            Container(),
          ),
          Positioned(
            bottom: 40,
            left: 16,
            child: (widget.accountNumber!=null&&widget.accountNumber!="")
                ?Container(padding:EdgeInsets.only(top: 8,),child: Container(
              child: Text(
                  Utils().getTranslation(Strings.MPIN_ACCOUNT_NUMBER,context),
                  style: widget.isMyAccountCard ? BaseStyles.transactionSuccessTextStyle : BaseStyles.accountNumberInMPINTextStyle,
                  textAlign: TextAlign.left
              ),),):
            Container(),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: (widget.accountName!=null&&widget.accountName!="")
                ?Container(padding:EdgeInsets.only(top: 8,),child: Container(
              child: Text(
                  widget.accountName,
                  style: widget.isMyAccountCard ? BaseStyles.additionContactTextTextStyle :  BaseStyles.accountNameInMPINTextStyle,
                  textAlign: TextAlign.left
              ),),):
            Container(),
          ),
          Positioned(
            top: 11,
            right: 11,
            child: (widget.rightIcon!=null&&widget.rightIcon!="")
                ?Container( decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
              child: SvgPicture.asset(Assets.ic_right)
             ,):
            Container(),
          )

        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
