import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/otp_text_field_widget.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/card_view.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';

class CreateMPIN extends StatefulWidget {
  const CreateMPIN({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateMPIN();
  }
}

class _CreateMPIN extends BaseState<CreateMPIN> {
  bool isReEnterPinCorrect = true;
  String pin;

  String newPin = "";
  String confirmPin = "";
  bool isFinishConfirmPin = false;
  String errorText = "";
  bool isOtpEntered = false;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
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
                          getOTPBorderContainer(Strings.new_pin),
//                          errorText.isNotEmpty?Center(
//                            child: Container(
//                              margin: EdgeInsets.only(bottom: 32,),
//                              child: Text(
//                                  errorText,
//                                  style: BaseStyles.errorTextStyle,
//                                  textAlign: TextAlign.center
//                              ),
//                            ),
//                          ):Container(),
                          getOTPBorderContainer(Strings.confirm_new_mpin),
                          errorText.isNotEmpty
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: 8,
                                    ),
                                    child: Text(errorText,
                                        style: BaseStyles.errorTextStyle,
                                        textAlign: TextAlign.center),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    confirmTransferWidget()
                  ])),
        ),
      ),
    );
  }

  getOTPBorderContainer(String heading) {
    return Column(
      children: [
        Container(
          child: Text(getTranslation(heading),
              style: BaseStyles.enterMPINTextStyle,
              textAlign: TextAlign.center),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(
            top: 16,
          ),
          child: OTPTextFieldWidget(
            width: MediaQuery.of(context).size.width,
            length: 6,
            fieldWidth: 40,
            textFieldAlignment: MainAxisAlignment.spaceBetween,
            fieldStyle: FieldStyle.underline,
            obscureText: true,
            style: BaseStyles.MPINTextStyle,
            correctPin: newPin,
            onCompleted: (pin) {
              setState(() {
                if (heading == Strings.new_pin) {
                  newPin = pin;
                } else {
                  confirmPin = pin;
                  isFinishConfirmPin = true;
                }
              });
            },
            onChanged: (pin) {
              setState(() {
                print("On Changes: $pin");
                print("New Pin: $newPin");
                errorText = "";
                if (heading == Strings.new_pin) {
                  newPin = pin;
                  if (newPin.length == 2 && pin.length == 1) {
                    newPin = "";
                  } else {}
                } else {
                  confirmPin = pin;
                  isFinishConfirmPin = false;
                  if (pin.length == 1) {
                    confirmPin = "";
                  } else {
                    confirmPin = pin;
                  }
                }
              });
            },
          ),
        ),
        Container(
          height: 5,
          margin: EdgeInsets.only(
            bottom: 32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBorderContainer(heading),
              getBorderContainer(heading),
              getBorderContainer(heading),
              getBorderContainer(heading),
              getBorderContainer(heading),
              getBorderContainer(heading),
            ],
          ),
        ),
      ],
    );
  }

  getBorderColor(String heading) {
    if (heading == Strings.new_pin) {
      if (newPin.length == 6) {
        return AppColors.fareColor;
      }
    } else {
      if (newPin != confirmPin && isFinishConfirmPin) {
        return Colors.pink;
      } else if (confirmPin.length == 6) {
        return AppColors.fareColor;
      }
    }
    return AppColors.light_grey_blue;
  }

  getBorderContainer(String heading) {
    return Container(
      height: 3,
      width: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: getBorderColor(heading),
              width: 2.0,
              style: BorderStyle.solid),
        ),
        color: Colors.transparent,
      ),
    );
  }

  confirmTransferWidget() {
    return Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 32, top: 8, left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: confirmPin.length == 6 && newPin.length == 6
                ? AppColors.bottom_border_color
                : Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: InkWell(
            onTap: () {
              if (confirmPin.length == 6 && newPin.length == 6) {
                if (this.newPin != null && this.newPin.length == 0) {
                  setState(() {
                    errorText = getTranslation(Strings.mpin_cannot_empty);
                  });
                } else if (newPin != confirmPin) {
                  setState(() {
                    errorText = getTranslation(Strings.mpin_not_match);
                  });
                } else {
                  pushAndRemoveUntil(HomeCustomerScreen());
                }
              } else {
                return;
              }
            },
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: Text(
                getTranslation(Strings.CONTINUE),
                textAlign: TextAlign.center,
                style: confirmPin.length == 6 && newPin.length == 6
                    ? BaseStyles.addNewBankAccount
                    : BaseStyles.disableButtonStyle,
              ),
            )));
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }
}
