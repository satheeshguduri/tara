import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/card_view.dart';
import 'package:tara_app/screens/base/base_state.dart';

class EnterMPIN extends StatefulWidget {
  EnterMPIN({Key key}) : super(key: key);

  @override
  _EnterMPINState createState() => _EnterMPINState();
}

class _EnterMPINState extends BaseState<EnterMPIN> {

  @override
  BuildContext getContext() {
    return this.context;
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
                    Strings.ENTER_MPIN,
                    style:BaseStyles.bottomSheetTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: CustomCard(image:Assets.ic_mpin_card,bankIcon: Assets.ic_mandiri,accountName: "Yakub Pasha Shaik",accountNumber: Strings.MPIN_ACCOUNT_NUMBER,),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                            Strings.ENTER_MPIN,
                            style: BaseStyles.enterMPINTextStyle,
                            textAlign: TextAlign.center
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 8,bottom: 16,left: 8,right: 8),
                        child: OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                          fieldWidth: 40,
                          fieldStyle:FieldStyle.underline,
                          obscureText: true,
                          style: BaseStyles.MPINTextStyle,
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                          },
                        ),
                      )
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
      onTap: (){

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
          Strings.CONFIRM_TRANSFER,
          textAlign: TextAlign.center,
          style: BaseStyles.addNewBankAccount,
        ),
      ),
    );
  }

}
