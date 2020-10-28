
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/account_confirmation.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/create_new_account.dart';
import 'package:tara_app/common/widgets/login_flow_widgets/mobile_verification.dart';
import 'package:tara_app/common/widgets/sign_in_flow_bg.dart';
import 'package:tara_app/flavors.dart';
import 'package:tara_app/screens/agent/agent_widgets/upload_portrait_pic.dart';
import 'package:tara_app/screens/create_password.dart';

import 'base/base_state.dart';

class CreateAccount extends StatefulWidget{

  final bool isFromMobileVerification;
  final bool isFromCreateAccount;
  final bool isFromCreatePassword;

  const CreateAccount(
      {Key key, this.isFromMobileVerification = false, this.isFromCreateAccount = false, this.isFromCreatePassword = false, })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateAccountState();
  }
}

class _CreateAccountState extends BaseState<CreateAccount>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SignInFlowBg(child: getSignInFlow()),
    );
  }

  getSignInFlow()
  {
    if(Flavor.CONSUMER == F.appFlavor){
      return widget.isFromCreateAccount?
      MobileVerification():widget.isFromMobileVerification?
      CreatePassword(): widget.isFromCreatePassword ?
      AccountConfirmation():CreateNewAccount();
    }else if(Flavor.AGENT == F.appFlavor ||  Flavor.MERCHANT == F.appFlavor){
      return widget.isFromCreateAccount?
      MobileVerification()
      :CreateNewAccount();
    }
  }


  @override
  BuildContext getContext() {
    // TODO: implement getContext
    throw context;
  }

}
