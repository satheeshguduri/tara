import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import '../../common/constants/values.dart';


class SeeAllWidget extends StatefulWidget {
  final VoidCallback onPressed;

  SeeAllWidget({Key key,this.onPressed}) : super(key: key);


  @override
  SeeAllWidgetState createState() => SeeAllWidgetState();
}

class SeeAllWidgetState extends BaseState<SeeAllWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Container(
            margin:EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                getTranslation(Strings.SEE_ALL),
                textAlign: TextAlign.center,
                style: BaseStyles.seeAllTextStyle,
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.only(right: 16),
            height: 2,
            width: 60,
            decoration: BoxDecoration(gradient: Gradients.primaryGradient,),
          )
        ]
    );
  }

  @override
  BuildContext getContext() => context;


}
