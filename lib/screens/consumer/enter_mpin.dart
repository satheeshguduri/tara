import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/widgets/otp_text_field_widget.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/card_view.dart';
import 'package:tara_app/screens/base/base_state.dart';

class EnterMPIN extends StatefulWidget {
  final bool isFromSendMoney;
  final Function sendMoneyConfirmed;
  Function onConfirmTransfer;
  EnterMPIN({Key key, this.onConfirmTransfer,this.sendMoneyConfirmed,this.isFromSendMoney=false}) : super(key: key);

  @override
  _EnterMPINState createState() => _EnterMPINState();
}

class _EnterMPINState extends BaseState<EnterMPIN> {

  String otpPin = "";
  String correctPin = "123456";
  String errorText = "";
  bool isOtpEntered = false;

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
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4,bottom: 8),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 209, 212, 215),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    getTranslation(Strings.ENTER_MPIN),
                    style:BaseStyles.bottomSheetTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: CustomCard(image:Assets.ic_mpin_card,bankIcon: Assets.ic_mandiri,accountName: "Yakub Pasha Shaik",accountNumber: getTranslation(Strings.MPIN_ACCOUNT_NUMBER),),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                            getTranslation(Strings.ENTER_MPIN),
                            style: BaseStyles.enterMPINTextStyle,
                            textAlign: TextAlign.center
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 24,),
                        child: OTPTextFieldWidget(
                          width:  MediaQuery.of(context).size.width,
                          length: 6,
                          fieldWidth: 40,
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle:FieldStyle.underline,
                          obscureText: true,
                          style: BaseStyles.MPINTextStyle,
                          correctPin:correctPin,
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            setState(() {
                              otpPin = pin;
                              isOtpEntered = true;
                            });
                          },
                          onChanged: (pin) {
                            print("Completed: " + pin);
                            setState(() {
                              if (pin.trim().length<6)
                              {
                                errorText = "";
                                isOtpEntered = false;
                                if (pin.length==1)
                                {
                                  otpPin = "";
                                }
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 5,
                        margin: EdgeInsets.only(bottom: 16,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getBorderContainer(),
                            getBorderContainer(),
                            getBorderContainer(),
                            getBorderContainer(),
                            getBorderContainer(),
                            getBorderContainer(),
                          ],
                        ),
                      ),
                      errorText.isNotEmpty?Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8,),
                          child: Text(
                              errorText,
                              style: BaseStyles.errorTextStyle,
                              textAlign: TextAlign.center
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                ),
                confirmTransferWidget()
              ])
      ),
    );
  }

  confirmTransferWidget()
  {
    return InkWell(
      onTap: () {
        if (isOtpEntered&&otpPin.isNotEmpty&&otpPin.length==6)
        {
          if (otpPin!=correctPin)
          {
            setState(() {
              errorText = getTranslation(Strings.invalid_mpin);
            });
          }else{
            if (widget.isFromSendMoney==true)
            {
              widget.sendMoneyConfirmed();
              Navigator.pop(context);
            }
            else{
              widget.onConfirmTransfer();
            }
          }
        }else if (otpPin.length==0){
          setState(() {
            errorText = getTranslation(Strings.mpin_cannot_empty);
          });
        }
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16,top: 8,left: 8,right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            color: AppColors.bottom_border_color
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.CONFIRM_TRANSFER),
          textAlign: TextAlign.center,
          style: BaseStyles.addNewBankAccount,
        ),
      ),
    );
  }

  getBorderContainer()
  {
    return Container(
      height: 3,
      width: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide( //                   <--- left side
              color: errorText.isNotEmpty?Colors.pink:isOtpEntered?Color(0xffb2f7e2):Color(0xffb0b4c1),
              width: 2.0,
              style: BorderStyle.solid
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }

}
