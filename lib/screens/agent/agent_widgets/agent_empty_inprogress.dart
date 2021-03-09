

import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgentEmptyInProgress extends StatefulWidget{

  @override
  _AgentEmptyInProgressState createState() => _AgentEmptyInProgressState();
}

class _AgentEmptyInProgressState extends BaseState<AgentEmptyInProgress>{

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 32,top: 32),
      padding: EdgeInsets.only(left: 32,right: 32),
      child: Column(
        children: [
          Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                  color: AppColors.light_grey_blue,
                  borderRadius: Radii.border(44)
              )
          ),
          Container(height: 8,),
          Text(
              getTranslation(Strings.NO_PROGRESS_YET),
              style: const TextStyle(
                  color:  AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                  
                  fontSize: 16.0
              ),
              textAlign: TextAlign.center
          ),
          Container(height: 8,),
          Text(
              getTranslation(Strings.SEE_AVAIL_REQ),
              style: const TextStyle(
                  color:  AppColors.battleship_grey,
                  fontWeight: FontWeight.w400,
                  
                  fontSize: 14.0
              ),
              textAlign: TextAlign.center
          )
        ],
      ),
    );
  }
}