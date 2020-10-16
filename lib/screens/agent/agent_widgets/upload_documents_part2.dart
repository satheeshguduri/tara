import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/agent/agent_home_screen.dart';
import 'package:tara_app/screens/agent/agent_widgets/take_picture_screen.dart';
import 'package:tara_app/screens/base/base_state.dart';

class UploadDocumentPartTwo extends StatefulWidget {
  const UploadDocumentPartTwo({
    Key key,
  }) : super(key: key);

  @override
  _UploadDocumentPartTwoState createState() => _UploadDocumentPartTwoState();
}

class _UploadDocumentPartTwoState extends BaseState<UploadDocumentPartTwo> {

  String imagePath = "";
  File imageFile;
  // ignore: non_constant_identifier_names
  String imagePath_utility_bill = "";
  // ignore: non_constant_identifier_names
  File imageFile_utility_bil;

  bool isKtpClicked = false;
  bool isUtilityClicked = false;

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
                  getKtpTotalWidget(),
                  getUtilityBillTotalWidget(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: _getBackWidget(),
              ),
              Expanded(
                flex: 5,
                child: _getSaveAndContinueWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  getKtpTotalWidget()
  {
    return Container(
            margin: EdgeInsets.only(bottom: 8,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4.5.toInt(),
                      child:InkWell(
                        onTap: (){
                          isKtpClicked = true;
                          isUtilityClicked = false;
                          _showSelectionDialog(context);
                        },
                        child:ktpWidget(context),),
                    ),
                    Expanded(
                      flex: 5.5.toInt(),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 4,left: 16),
                            child: Text(
                                getTranslation(Strings.ktp),
                                style: BaseStyles.ktpTitleTextStyle
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4,left: 16),
                            child: Text(
                              getTranslation(Strings.ktp_subtext),
                              style: BaseStyles.ktpSubTitleTextStyle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4.5.toInt(),
                      child: (imageFile!=null || imagePath.isNotEmpty)?takePictureForKtpWidget(context):Container(),
                    ),
                    Expanded(
                        flex: 5.5.toInt(),
                        child: Container()
                    )
                  ],
                )
              ],
            )
        );
  }

  getUtilityBillTotalWidget()
  {
    return Container(
          margin: EdgeInsets.only(bottom: 8,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4.5.toInt(),
                    child:InkWell(
                      onTap: (){
                        isKtpClicked = false;
                        isUtilityClicked = true;
                        _showSelectionDialog(context);
                      },
                      child:utilityBillWidget(context),),
                  ),
                  Expanded(
                    flex: 5.5.toInt(),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 4,left: 16),
                          child: Text(
                              getTranslation(Strings.utility_bill),
                              style: BaseStyles.ktpTitleTextStyle
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4,left: 16),
                          child: Text(
                            getTranslation(Strings.utility_bill_subtext),
                            style: BaseStyles.ktpSubTitleTextStyle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),)
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4.5.toInt(),
                    child: (imageFile_utility_bil!=null || imagePath_utility_bill.isNotEmpty)?takePictureForUtilityBillWidget(context):Container()
                  ),
                  Expanded(
                      flex: 5.5.toInt(),
                      child: Container()
                  )
                ],
              )

            ],
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
      title: Container(
        child: Row(
          children: [
            Expanded(
              flex: 7.5.toInt(),
              child:Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  getTranslation(Strings.upload_documents),
                  textAlign: TextAlign.left,
                  style: BaseStyles.topBarTextStyle,
                ),
              ),),
            Expanded(
              flex: 2.5.toInt(),
              child: InkWell(
                  onTap: (){
                    pushAndRemoveUntil(AgentHomeScreen());
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 8,bottom: 8),
                      child: Column(
                        children: [
                          Text(
                              getTranslation(Strings.skip),
                              style: BaseStyles.backAccountHeaderTextStyle,
                              textAlign: TextAlign.center
                          ),
                          Container(
                            height:2 ,
                            margin: EdgeInsets.only(top: 4,left: 8,right: 8),
                            decoration: BoxDecoration(
                              gradient: Gradients.primaryGradient,
                            ),
                          ),
                        ],
                      )
                  ),
              ),
            )
          ],
        ),
      )
    );
  }

  ktpWidget(BuildContext context)
  {
    return (imageFile!=null)?Container(
        width: 156,
        height: 104,
        margin: EdgeInsets.only(top: 16,bottom: 8),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:Image.file(imageFile,fit: BoxFit.fill,))):
    imagePath.isNotEmpty?
    Container(
        width: 156,
        height: 104,
        margin: EdgeInsets.only(top: 16,bottom: 8),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:Image.file(File(imagePath),fit: BoxFit.fill,))):
    Container(
      width: 156,
      height: 104,
      color: Color(0xfff5fafa),
      margin: EdgeInsets.only(top: 16,bottom: 8),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Colors.grey[300],
        strokeWidth:1.5,
        radius: Radius.circular(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child:Center(
            child: Container(
              color: Color(0xfff5fafa),
              margin: EdgeInsets.only(top: 16,bottom: 16),
              child: Column(
                children: [
                  Image.asset(Assets.ic_camera, fit: BoxFit.fill,width: 36,height: 36,),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                        getTranslation(Strings.upload_ktp),
                        style:BaseStyles.uploadKtpTextStyle,
                        textAlign: TextAlign.center
                    ),
                  )
                ],
              ),
            ),
          ) ,
        ),
      ),
    );
  }

  takePictureForKtpWidget(BuildContext context)
  {
    return InkWell(
      onTap: (){
        _showSelectionDialog(context);
      },
      child: Container(
        height: 40,
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

  utilityBillWidget(BuildContext context)
  {
    return (imageFile_utility_bil!=null)?Container(
        width: 156,
        height: 104,
        margin: EdgeInsets.only(top: 16,bottom: 8),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:Image.file(imageFile_utility_bil,fit: BoxFit.fill,))):
    imagePath_utility_bill.isNotEmpty?
    Container(
        width: 156,
        height: 104,
        margin: EdgeInsets.only(top: 16,bottom: 8),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:Image.file(File(imagePath_utility_bill),fit: BoxFit.fill,))):
    Container(
      width: 156,
      height: 104,
      color: Color(0xfff5fafa),
      margin: EdgeInsets.only(top: 16,bottom: 8),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Colors.grey[300],
        strokeWidth:1.5,
        radius: Radius.circular(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child:Center(
            child: Container(
              color: Color(0xfff5fafa),
              margin: EdgeInsets.only(top: 16,bottom: 16),
              child: Column(
                children: [
                  Image.asset(Assets.ic_camera, fit: BoxFit.fill,width: 36,height: 36,),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                        getTranslation(Strings.upload_utility_bill),
                        style:BaseStyles.uploadKtpTextStyle,
                        textAlign: TextAlign.center
                    ),
                  )
                ],
              ),
            ),
          ) ,
        ),
      ),
    );
  }

  takePictureForUtilityBillWidget(BuildContext context)
  {
    return InkWell(
      onTap: (){
        _showSelectionDialog(context);
      },
      child: Container(
        height: 40,
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
            (imagePath_utility_bill.isNotEmpty || (imageFile_utility_bil!=null))?Image.asset(Assets.ic_refresh, fit: BoxFit.fill):Image.asset(Assets.ic_camera, fit: BoxFit.fill),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                  (imagePath_utility_bill.isNotEmpty || (imageFile_utility_bil!=null))?getTranslation(Strings.replace_photo):getTranslation(Strings.take_picture),
                textAlign: TextAlign.center,
                style: BaseStyles.addNewBankAccount,
              ),
            )
          ],
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

  _getBackWidget() {
    return InkWell(
      onTap: () {
        Navigator.pop(context, false);
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                color: const Color(0xffb0b4c1),
                width: 1
            ),
            color: Colors.white),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            getTranslation(Strings.back),
            textAlign: TextAlign.center,
            style: BaseStyles.mobileNoTextStyle,
          ),
        ),
      ),
    );
  }

  _getSaveAndContinueWidget() {
    return InkWell(
      onTap: () {
        pushAndRemoveUntil(AgentHomeScreen());
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, left: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: ((imagePath.isNotEmpty || (imageFile!=null)) || (imageFile_utility_bil!=null || imagePath_utility_bill.isNotEmpty))?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.save_continue),
          textAlign: TextAlign.center,
          style: ((imagePath.isNotEmpty || (imageFile!=null)) || (imageFile_utility_bil!=null || imagePath_utility_bill.isNotEmpty))?BaseStyles.mobileNoTextStyle:BaseStyles.saveAndContinueDisableTextStyle,
        ),
      ),
    );
  }

  void _showCamera() async {

    final cameras = await availableCameras();
    final camera = cameras.first;

    push(TakePictureScreen(camera: camera,imagePathCallback: (selectedImagePath){
      if(isKtpClicked)
      {
        setState(() {
          imagePath = selectedImagePath;
          imageFile = null;
        });
      }else{
        setState(() {
          imagePath_utility_bill = selectedImagePath;
          imageFile_utility_bil = null;
        });
      }
    },));
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(isKtpClicked)
    {
      setState(() {
        imageFile = picture;
        imagePath = "";
      });
    }else{
      this.setState(() {
        imageFile_utility_bil = picture;
        imagePath_utility_bill = "";
      });
    }
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
