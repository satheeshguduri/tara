import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/sign_in_flow_bg.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key key,
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen> {

  FocusNode mobileNorFocusNode = FocusNode();
  bool isFailedValidation = false;

  AuthController controller = Get.find();
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:getRootContainer(),
    );
  }

  Widget getRootContainer(){
    return Obx(()=>
        SafeArea(child: SignInFlowBg(child: getSignInWidget())).withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  Widget getSignInWidget()
  {
    return Container(
        height: 520,
        child:Stack(
          children: [
            Positioned(
              top: 440,
              right: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  margin: EdgeInsets.only(left: 16,),
                  padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                    boxShadow: [BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0,6),
                        blurRadius: 14,
                        spreadRadius: 0
                    ), BoxShadow(
                        color: const Color(0x1a000000),
                        offset: Offset(0,0),
                        blurRadius: 4,
                        spreadRadius: 0
                    )] ,
                    color: Color(0xfff7f7fa),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 8,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            getTranslation(Strings.dont_have_account),
                            style: BaseStyles.alreadyHaveAccountTextStyle,
                            textAlign: TextAlign.right
                        ),
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                pop();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 8,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          getTranslation(Strings.SIGN_UP),
                                          style: BaseStyles.bottomSheetLocationChangeTextStyle,
                                          textAlign: TextAlign.left
                                      ),
                                      Container(
                                        height:3,
                                        width: 55,
                                        margin: EdgeInsets.only(top: 4,),
                                        decoration: BoxDecoration(
                                          gradient: Gradients.primaryGradient,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width*0.90,
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x1f000000),
                            offset: Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: 0),
                        BoxShadow(
                            color: const Color(0x14000000),
                            offset: Offset(0, 0),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ],
                      color: AppColors.primaryBackground),
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context, false);
                            },
                            child: Container(
                              width: 32,
                              height: 24,
                              margin: EdgeInsets.only(bottom: 8,top: 8),
                              child: Image.asset(
                                "assets/images/icon-5.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextWithBottomOverlay(titleStr: Strings.login,),
                      Container(
                        color: Colors.grey[200],
                        height: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                            getTranslation(Strings.enter_login_description),
                            style: BaseStyles.subHeaderTextStyle
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide( //                   <--- left side
                              color: Colors.grey[400],
                              width: 1.0,
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                        child: InternationalPhoneNumberInput(
//                          autoValidate:true,
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            controller.mobileNumber.value = number.phoneNumber;
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                          ),
                          ignoreBlank: false,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          initialValue: number,
                          textFieldController: controller.mobileNumberTextEditController,
                          inputBorder: InputBorder.none,
                          inputDecoration: InputDecoration(
                            border: InputBorder.none, hintText: getTranslation(Strings.phone_number_2),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isFailedValidation == false ? AppColors.light_grey_blue : AppColors.badge_color,
                                width: 1.0,
                              ),
                            )),
                        child: Row(
                            children: [
                              Container(
                                child:  Image.asset(Assets.ic_lock,color:AppColors.light_grey_blue),
                                height: 24,
                                width: 24,
                                margin: EdgeInsets.only(right: 8),
                              ),
                              Expanded(
                                child: textFormFieldContainer(getTranslation(Strings.confirm_password),TextInputType.text,controller.confirmPasswordTextEditController,null,isObscure:true,
                                  placeHolderStyle: BaseStyles.subHeaderTextStyle,),
                              )
                            ]),
                      ),
                      isFailedValidation == false ? Container() :
                      Text("Password didn’t match. Please try again.", style: BaseStyles.error_text_style,),
                      getContinueWidget()
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }


  textFormFieldContainer(String hint,TextInputType inputType, TextEditingController textEditingController,FocusNode focusNode,
      {bool isObscure=false, placeHolderStyle: BaseStyles.bankNameTextStyle,})
  {
    return Container(
        margin: EdgeInsets.only(top:8),
        child: Container(
          child:Row(
            children: [
              Expanded(
                  flex:1,
                  child:Container(
                    child:TextFieldWidget(isObscure:isObscure,placeHolderStyle: BaseStyles.subHeaderTextStyle,hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){
                      controller.confirmPwd.value = textEditingController.text;
                    }),
                  )
              ),
            ],
          ),
        )
    );
  }


 Widget getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16, top: 24,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.CONTINUE),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: (){
      if(controller.mobileNumberTextEditController.text.isNotEmpty&&
          controller.confirmPasswordTextEditController.text.isNotEmpty){
        controller.login();
      }else{
        //set error
      }
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

}
