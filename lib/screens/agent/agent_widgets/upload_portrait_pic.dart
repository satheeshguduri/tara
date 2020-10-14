import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';

class UploadPortraitPic extends StatefulWidget {
  const UploadPortraitPic({
    Key key,
  }) : super(key: key);

  @override
  _UploadPortraitPicState createState() => _UploadPortraitPicState();
}

class _UploadPortraitPicState extends BaseState<UploadPortraitPic> {
  
  bool isPicUploaded = false;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            child: Container(
              padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
              child: Wrap(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 8,top: 16),
                    child:Text(
                        "1 of 2",
                        style: BaseStyles.chatItemResendOtpButtonTextStyle
                    ),
                  ),
                  TextWithBottomOverlay(titleStr: Strings.upload_your_portrait,),
                  Container(
                    margin: EdgeInsets.only(top: 8,),
                    child:Text(
                        getTranslation(Strings.portrait_pic_text),
                        style: BaseStyles.subHeaderTextStyle
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        portraitPicWidget(),
                        takePictureWidget(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _getNextWidget(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false,
      // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.upload_documents),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }
  
  _getNextWidget() {
    return InkWell(
      onTap: () {
       
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 36,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: isPicUploaded?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.next),
          textAlign: TextAlign.center,
          style: isPicUploaded?BaseStyles.chatItemDepositSuccessMoneyTextStyle:BaseStyles.verifyTextStyle,
        ),
      ),
    );
  }

  takePictureWidget()
  {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 45,
          width: 150,
        margin: EdgeInsets.only(bottom: 16,top: 8,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            border: Border.all(
                color: AppColors.uncheck_color,
                width: 1
            ),
            color: Colors.white
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.ic_camera, fit: BoxFit.fill),
            Container(
              margin: EdgeInsets.only(left: 2),
              child: Text(
                getTranslation(Strings.take_picture),
                textAlign: TextAlign.center,
                style: BaseStyles.addNewBankAccount,
              ),
            )
          ],
        ),
      ),
    );
  }

  portraitPicWidget()
  {
    return Container(
      height: 240,
      width: 240,
        color: Color(0xfff5fafa),
      margin: EdgeInsets.only(top: 16,bottom: 8),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Colors.grey[300],
        strokeWidth:1.5,
        radius: Radius.circular(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child:Container(
            color: Color(0xfff5fafa),
            margin: EdgeInsets.all(50),
            child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xffe9ecef),
                  shape: BoxShape.circle,
                ),
              child: Container(
                  margin: EdgeInsets.all(30),
                  width: 68,
                  height: 75,
                  child: Image.asset(Assets.ic_portrait_person_pic, fit: BoxFit.cover,color: Color(0xff889aac),),
              ),
            ),
          ) ,
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
  }

}
