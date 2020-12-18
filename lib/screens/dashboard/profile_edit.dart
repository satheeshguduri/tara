import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/screens/agent/agent_widgets/take_picture_screen.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/utils/locale/utils.dart';
import '../../common/constants/values.dart';
import 'dash_board.dart';

class ProfileEdit extends StatefulWidget {
  final bool isFromHomeTopBar;
  final AuthResponse user;
  ProfileEdit({Key key, this.isFromHomeTopBar = false,this.user}) : super(key: key);

  @override
  _ProfileEditState createState() => new _ProfileEditState();
}

class _ProfileEditState extends BaseState<ProfileEdit> {
  AuthResponse user = Get.find();
  AuthController controller = Get.find();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  FocusNode phoneNumberFocusNode = FocusNode();
  String imagePath = "";
  File imageFile;

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    // user = widget?.user;
  }

  void addListenersToRequiredTextField() {
    phoneNumberFocusNode.addListener(() {
      var hasFocus = phoneNumberFocusNode.hasFocus;
      if (hasFocus) {
        Utils().showOverlay(context);
      } else {
        Utils().removeOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
            child: Wrap(
          children: [
            Center(
              child: Container(
                width: 130,
                height: 130,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 16,
                      ),
                      child: (imageFile != null)
                          ? Container(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  child: Image.file(
                                    imageFile,
                                    fit: BoxFit.fill,
                                  )))
                          : imagePath.isNotEmpty
                              ? Container(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      child: Image.file(
                                        File(imagePath),
                                        fit: BoxFit.fill,
                                      )))
                              : Container(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      child: Image.asset(
                                        Assets.ic_avatar_default,
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                      ))),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: EdgeInsets.only(right: 12, bottom: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x24000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                  spreadRadius: 0),
                              BoxShadow(
                                  color: const Color(0x14000000),
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 0)
                            ],
                            color: Colors.white),
                        child: Center(
                          child: Container(
                            child: getTabImageWithSize(Assets.ic_edit, 20, 20),
                          ).onTap(
                            onPressed: () => _showSelectionDialog(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            textFormFieldContainer(
                getTranslation(Strings.name),
                user?.customerProfile?.firstName !=null?user?.customerProfile?.firstName.toString():getTranslation(Strings.enter_full_name),
                TextInputType.text,
                nameTextController,
                null,
                1,
                true),
            textFormFieldContainer(
                getTranslation(Strings.address),
                user?.customerProfile?.address!=null?user?.customerProfile?.address.toString():getTranslation(Strings.enter_address),
                TextInputType.multiline,
                addressTextController,
                null,
                3,
                true),
            textFormFieldContainer(
                getTranslation(Strings.email_address),
                user?.customerProfile?.email!=null?user?.customerProfile?.email.toString():getTranslation(Strings.enter_email_address),
                TextInputType.emailAddress,
                emailAddressController,
                null,
                1,
                true),
            textFormFieldContainer(
                getTranslation(Strings.phone_number_2),
                user?.customerProfile?.email!=null?user?.customerProfile?.mobileNumber.toString():"",
                TextInputType.phone,
                phoneNumberController,
                phoneNumberFocusNode,
                1,
                false),
          ],
        )),
        bottomNavigationBar: saveWidget(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context, false);
            if (widget.isFromHomeTopBar) {
              Get.offAll(Utils().getLandingScreen());
            } else {
              pop();
            }
          }),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.profile),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  textFormFieldContainer(
      String headerTitle,
      String hint,
      TextInputType inputType,
      TextEditingController textEditingController,
      FocusNode focusNode,
      int maxLines,
      bool trueOrFalse) {
    return Container(
        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          border: textEditingController != phoneNumberController
              ? Border(
                  bottom: BorderSide(
                    //                   <--- left side
                    color: Colors.grey,
                    width: 1.0,
                  ),
                )
              : Border(
                  bottom: BorderSide(
                    //                   <--- left side
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
          color: Colors.transparent,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4, bottom: 4),
                child: Text(headerTitle,
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left),
              ),
              textEditingController != addressTextController
                  ? Container(
                      child: TextFieldWidget(
                          hint: hint,
                          inputType: inputType,
                          textController: textEditingController,
                          isIcon: false,
                          maxLines: maxLines,
                          focusNode: focusNode,
                          enable: trueOrFalse,
                          onChanged: (value) {}),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 16, bottom: 12),
                      child: TextField(
                        style: BaseStyles.bankNameTextStyle,
                        controller: textEditingController,
                        enabled: trueOrFalse,
                        decoration: InputDecoration.collapsed(
                          hintText: hint,
                          hintStyle: BaseStyles.bankNameTextStyle,
                        ),
                        minLines: 1,
                        maxLines: maxLines,
                        keyboardType: inputType,
                      ),
                    )
            ],
          ),
        ));
  }

  saveWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16, top: 8, left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.save),
        textAlign: TextAlign.center,
        style: BaseStyles.mobileNoTextStyle,
      ),
    ).onTap(onPressed: () {
      Utils().hideKeyBoard(context);
      controller.updateProfile(nameTextController.text,
          addressTextController.text, emailAddressController.text, user);
    });
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                getTranslation(Strings.take_picture_dialog),
                style: BaseStyles.mobileNoTextStyle,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 4, bottom: 4),
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        getTranslation(Strings.gallery),
                        style: BaseStyles.itemOrderTextStyle,
                      ),
                    ).onTap(onPressed: () {
                      Navigator.of(context).pop();
                      _openGallery(context);
                    }),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        getTranslation(Strings.camera),
                        style: BaseStyles.itemOrderTextStyle,
                      ),
                    ).onTap(onPressed: () {
                      Navigator.of(context).pop();
                      // Get.off();
                      _showCamera();
                    }),
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

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    push(TakePictureScreen(
      camera: camera,
      imagePathCallback: (selectedImagePath) {
        setState(() {
          imagePath = selectedImagePath;
          imageFile = null;
        });
      },
    ));
  }
}
