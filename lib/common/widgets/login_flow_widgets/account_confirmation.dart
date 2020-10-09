import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';

class AccountConfirmation extends StatefulWidget {
  const AccountConfirmation({
    Key key,
  }) : super(key: key);

  @override
  _AccountConfirmationState createState() => _AccountConfirmationState();
}

class _AccountConfirmationState extends BaseState<AccountConfirmation> {

  @override
  Widget build(BuildContext context) {

    return Container(
        child:Align(
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
                  Container(
                    margin: EdgeInsets.only(top:8),
                    child: Center(child: getTabImageWithSize(Assets.ic_success,180,200),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Center(child: Text(
                        getTranslation(Strings.account_created),
                        style: BaseStyles.agentUIN_OTP_CODE_TextStyle,
                        textAlign: TextAlign.center
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Center(child: Text(
                      getTranslation(Strings.account_success_msg),
                      style: BaseStyles.accountSuccessTextStyle,
                      textAlign: TextAlign.center,)),
                  ),
                  Center(
                    child: __getStartedWidget(),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  __getStartedWidget() {
    return InkWell(
      onTap: () {
        pushAndRemoveUntil(HomeCustomerScreen());
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 16,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffb2f7e2),),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.get_started),
          textAlign: TextAlign.center,
          style: BaseStyles.chatItemDepositSuccessMoneyTextStyle,
        ),
      ),
    );
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

}
