import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/assets.dart';

class SignInFlowBg extends StatelessWidget {

  final Widget child;
  const SignInFlowBg({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current = child;

    current = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(Assets.ic_Login_flow_bg),
    fit: BoxFit.cover,
    )),
      child: current,);

    return current;
  }

}