import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/card_view.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';

class CreateMPIN extends StatefulWidget {
  final bool isReEnterPin;
  final bool confirmPin;

  final String oldPin;

  const CreateMPIN(
      {Key key, this.isReEnterPin = false, this.confirmPin = false, this.oldPin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateMPIN();
  }
}

class _CreateMPIN extends BaseState<CreateMPIN> {

  bool isReEnterPinCorrect = true;
  String pin;


  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
          ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.create_mpin),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  String getPinTitle() {
    if (widget.isReEnterPin)
      return Strings.confirm_new_mpin;
    else if (widget.confirmPin)
      return Strings.confirm_MPIN;
    else
      return Strings.new_pin;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: CustomCard(
                            image: Assets.ic_mpin_card,
                            bankIcon: Assets.ic_mandiri,
                            accountName: "Yakub Pasha Shaik",
                            accountNumber:
                                getTranslation(Strings.MPIN_ACCOUNT_NUMBER),
                          ),
                        ),
                        Container(
                          child: Text(getTranslation(getPinTitle()),
                              style: BaseStyles.enterMPINTextStyle,
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(
                              top: 8, bottom: 16, left: 8, right: 8),
                          child: OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceEvenly,
                            fieldWidth: 40,
                            fieldStyle: FieldStyle.underline,
                            obscureText: true,
                            style: BaseStyles.MPINTextStyle,
                            onCompleted: (pin) {
                              this.pin = pin;
                              print("Completed: " + pin);

                            },
                          ),
                        ),
                        isReEnterPinCorrect ? Container() : Text(getTranslation(Strings.mpin_not_match),style: BaseStyles.error_text_style,)

                      ],
                    ),
                  ),
                  confirmTransferWidget()
                ])),
      ),
    );
  }

  confirmTransferWidget() {
    return Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 32, top: 8, left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.bottom_border_color),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            if (widget.confirmPin) {
              // push to Confirm Screen
              pushAndRemoveUntil(HomeCustomerScreen());

            } else if (widget.isReEnterPin) {
              if(widget.oldPin != pin){
                setState(() {
                  isReEnterPinCorrect = false;
                });
              }else{
                push(CreateMPIN(
                  confirmPin: true,
                ));
              }
            } else {
              if(this.pin.length == 6){
                push(CreateMPIN(
                  isReEnterPin: true,
                  oldPin: this.pin,
                ));
              }
            }
          },
          child: Container(
            height: 48,
            alignment: Alignment.center,
            child:Text(
            getTranslation(Strings.CONTINUE),
            textAlign: TextAlign.center,
            style: BaseStyles.addNewBankAccount,
          ),
        ))
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }
}
