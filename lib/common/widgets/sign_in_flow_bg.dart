import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';

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
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage(Assets.ic_Login_flow_bg),
        //   fit: BoxFit.cover,
        // )),
        child: Stack(
          children: [
            getSvgImage(
              imagePath: Assets.assets_bg,
            ),
            Container(color: AppColors.primaryText.withOpacity(0.2),),
            Align(
              alignment: Alignment.centerRight,
              child: current,
            ),
          ],
        ));

    return current;
  }

  Widget getSvgImage({
    String imagePath,
    Color color,
  }) {
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.fitHeight,
      semanticsLabel: 'svg',
      color: color,
    );
  }
}
