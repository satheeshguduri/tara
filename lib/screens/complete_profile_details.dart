import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/create_account.dart';

class CompleteProfile extends StatefulWidget {
  final String mobileNumber;

  CompleteProfile({Key key, this.mobileNumber}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends BaseState<CompleteProfile> {

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController createPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  bool isFailedValidation = false;

  bool isAllDetailsEntered = false;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(child: SingleChildScrollView(child:getAllWidgets(),)),
    );
  }

 AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.6,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.complete_profile),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

 Widget getAllWidgets()
 {
   return Wrap(
     children: [
       personalDetailsTitleWidget(),
       textFormFieldContainer(getTranslation(Strings.name),getTranslation(Strings.enter_full_name),TextInputType.text,nameTextController,),
       textFormFieldContainer(getTranslation(Strings.phone_number_2),widget?.mobileNumber!=null?widget.mobileNumber:"",TextInputType.phone,phoneNumberTextController,
           enableInteractiveSelection:false,placeHolderStyle: BaseStyles.amountTextStyle),
       textFormFieldContainer(getTranslation(Strings.email_address),getTranslation(Strings.enter_email_address),TextInputType.emailAddress,emailAddressController,),
       textFormFieldContainer(getTranslation(Strings.password),getTranslation(Strings.enter_password),TextInputType.text,createPass,isSecureText:true),
       textFormFieldContainer(getTranslation(Strings.confirm_password),getTranslation(Strings.enter_confirm_password),TextInputType.text,confirmPass,isSecureText:true),
       isFailedValidation == false ? Container() :
       Text("Password didn’t match. Please try again.", style: BaseStyles.error_text_style,),
       saveAndContinueWidget()
     ],
   );
 }

  Widget personalDetailsTitleWidget()
  {
    return Container(
      margin: EdgeInsets.only(top: 16,left: 16,right: 16),
      height: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            child:Container(
              height:16,
              width: 85,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: AppColors.bottom_border_color,
              ),
              child: Container(),
            ),
          ),
          Positioned(
            top: 0.0,
            child: Container(
              child: Text(
                getTranslation(Strings.personal_details),
                textAlign: TextAlign.left,
                style: BaseStyles.bankAccountHeaderTitleStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onChanged(TextEditingController textEditingController) {

  }

  Widget textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController,
      {bool isSecureText=false, bool enableInteractiveSelection=false, placeHolderStyle: BaseStyles.subHeaderTextStyle,})
  {
    return Container(
        margin: EdgeInsets.only(top:8,left: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide( //                   <--- left side
              color: textEditingController!=phoneNumberTextController?Colors.grey:Colors.transparent,
              width: 1.0,
            ),
          ),
          color: Colors.transparent,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4,bottom: 4),
                child: Text(
                    headerTitle,
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:TextFieldWidget(placeHolderStyle:placeHolderStyle,enableInteractiveSelection:enableInteractiveSelection,isObscure:isSecureText,hint: hint,inputType: inputType,
                          textController: textEditingController,isIcon: false,onChanged:(value){
                        onChanged(textEditingController);
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Widget saveAndContinueWidget() {
    return InkWell(
      onTap: () {
        if (isAllDetailsEntered)
        {
          push(CreateAccount(isFromCompleteProfile: true,));
        }
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 36,left: 16,right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: isAllDetailsEntered?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.save_and_continue),
          textAlign: TextAlign.center,
          style: isAllDetailsEntered?BaseStyles.chatItemDepositSuccessMoneyTextStyle:BaseStyles.verifyTextStyle,
        ),
      ),
    );
  }

}
