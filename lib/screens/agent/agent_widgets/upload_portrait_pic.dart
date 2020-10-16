import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/agent/agent_widgets/take_picture_screen.dart';
import 'package:tara_app/screens/agent/agent_widgets/upload_documents_part2.dart';
import 'package:tara_app/screens/base/base_state.dart';

class UploadPortraitPic extends StatefulWidget {
  const UploadPortraitPic({
    Key key,
  }) : super(key: key);

  @override
  _UploadPortraitPicState createState() => _UploadPortraitPicState();
}

class _UploadPortraitPicState extends BaseState<UploadPortraitPic> {
  
  String imagePath = "";
  File imageFile;

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
                        portraitPicWidget(context),
                        takePictureWidget(context),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
          bottomNavigationBar:Container(padding: EdgeInsets.only(left: 16,right: 16),child:_getNextWidget())
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
       push(UploadDocumentPartTwo());
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 36,),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: (imagePath.isNotEmpty || (imageFile!=null))?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.next),
          textAlign: TextAlign.center,
          style: (imagePath.isNotEmpty || (imageFile!=null))?BaseStyles.mobileNoTextStyle:BaseStyles.saveAndContinueDisableTextStyle,
        ),
      ),
    );
  }

  takePictureWidget(BuildContext context)
  {
    return InkWell(
      onTap: (){
        _showSelectionDialog(context);
      },
      child: Container(
        height: 45,
          width: 160,
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
            (imagePath.isNotEmpty || (imageFile!=null))?Image.asset(Assets.ic_refresh, fit: BoxFit.fill):Image.asset(Assets.ic_camera, fit: BoxFit.fill),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                (imagePath.isNotEmpty || (imageFile!=null))?getTranslation(Strings.replace_photo):getTranslation(Strings.take_picture),
                textAlign: TextAlign.center,
                style: BaseStyles.addNewBankAccount,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showCamera() async {

    final cameras = await availableCameras();
    final camera = cameras.first;

    push(TakePictureScreen(camera: camera,imagePathCallback: (selectedImagePath){
      setState(() {
        imagePath = selectedImagePath;
        imageFile = null;
      });
    },));
  }

  portraitPicWidget(BuildContext context)
  {
    return (imageFile!=null)?Container(
        height: 240,
        width: 240,
        margin: EdgeInsets.only(top: 16,bottom: 16),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:Image.file(imageFile,fit: BoxFit.fill,))):
    imagePath.isNotEmpty?
    Container(
        height: 240,
        width: 240,
        margin: EdgeInsets.only(top: 16,bottom: 16),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:Image.file(File(imagePath),fit: BoxFit.fill,))):
    Container(
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


  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(getTranslation(Strings.take_picture_dialog),style: BaseStyles.mobileNoTextStyle,),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 4,bottom: 4),
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 8,bottom: 8),
                        child: Text(getTranslation(Strings.gallery),style: BaseStyles.itemOrderTextStyle,),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 8,bottom: 8),
                        child:Text(getTranslation(Strings.camera),style: BaseStyles.itemOrderTextStyle,),),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showCamera();
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture;
      imagePath = "";
    });
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

  @override
  void dispose() {
    super.dispose();
  }

}
