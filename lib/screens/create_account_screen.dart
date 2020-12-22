
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/sign_in_flow_bg.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/signin_screen.dart';


import 'base/base_state.dart';

class CreateAccountScreen extends StatefulWidget{

  final bool isFromMobileVerification;
  final bool isFromCreateAccount;
  final bool isFromCreatePassword;
  final bool isSingInClicked;
  final bool isFromCompleteProfile;
  final String mobileNumber;

  const CreateAccountScreen(
      {Key key, this.isFromMobileVerification = false, this.isFromCreateAccount = false, this.isFromCreatePassword = false,this.isSingInClicked=false,this.isFromCompleteProfile=false,this.mobileNumber })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateAccountScreenState();
  }
}

class _CreateAccountScreenState extends BaseState<CreateAccountScreen>{

  AuthController controller = Get.find();
  PhoneNumber number = PhoneNumber(isoCode: 'ID');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:getRootContainer(),
    );
  }

  Widget getRootContainer(){
    return Obx(()=>
        SafeArea(child: SignInFlowBg(child: getTotalWidget())).withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  Widget getTotalWidget()
  {
    return Container(
        height: 520,
        child:Stack(
          children: [
            Positioned(
              top: 420,
              right: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  margin: EdgeInsets.only(left: 16,),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                    boxShadow: Shadows.shadows_list_2 ,
                    color: Color(0xfff7f7fa),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 8,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            getTranslation(Strings.already_have_account),
                            style: BaseStyles.alreadyHaveAccountTextStyle,
                            textAlign: TextAlign.right
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 8,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      getTranslation(Strings.SIGN_IN),
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
                          ).onTap(onPressed: (){
                            push(SignInScreen());
                          }),
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
                      boxShadow: Shadows.shadows_list,
                      color: AppColors.primaryBackground),
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*InkWell(
                            onTap: pop,
                            child: Container(
                              width: 32,
                              height: 24,
                              margin: EdgeInsets.only(bottom: 8,top: 8),
                              child: Image.asset(
                                "assets/images/icon-5.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),*/
                          Container(
                            width: 62,
                            height: 24,
                            margin: EdgeInsets.only(bottom: 8,top: 8),
                            child: Image.asset(
                              "assets/images/combined-shape-5.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ],
                      ),
                      TextWithBottomOverlay(titleStr: Strings.CREATE_ACCOUNT,),
                      Container(
                        color: Colors.grey[200],
                        height: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                            getTranslation(Strings.HELLO),
                            style: BaseStyles.backAccountHeaderTextStyle
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                            getTranslation(Strings.PLEASE_ENTER_MOBILE),
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
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            controller.errorMessage.value = "";
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
                      controller.errorMessage.value.isEmpty
                          ? Container()
                          : Container(margin:EdgeInsets.all(8),child: Text(
                        getTranslation(controller.errorMessage.value),
                        style: BaseStyles.error_text_style,
                      ),),
                      getContinueWidget()
                    ],
                  ),
                ),
              ),
            )
            // Container
          ],
        ));
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
      controller.getOtp();
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

}
