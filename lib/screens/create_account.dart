
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/widgets/sign_in_flow_bg.dart';

import 'base/base_state.dart';

class CreateAccount extends StatefulWidget{

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
      body: SignInFlowBg(child: Container(
        color: AppColors.primaryBackground,
        height: 300,
        width: 200,
        child: Text("This is Sample Container"),
      )),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    throw context;
  }

}
