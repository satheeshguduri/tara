import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/screens/agent/agent_widgets/agent_decline_transaction.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgentInProgressTransaction extends StatefulWidget {

  final Function tapOnDecline;
  final Function tapOnConfirm;

  const AgentInProgressTransaction({Key key, this.tapOnDecline,this.tapOnConfirm}) : super(key: key);

  @override
  _AgentInProgressTransactionState createState() =>
      _AgentInProgressTransactionState();
}

class _AgentInProgressTransactionState
    extends BaseState<AgentInProgressTransaction> {
  double positionX = 0;

  GlobalKey confirmDelivery = GlobalKey();

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 0, right: 0),
      decoration: BoxDecoration(
          borderRadius: Radii.border(8),
          boxShadow: Shadows.shadows_list,
          color: AppColors.primaryBackground),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: Radii.border(15),
                  ),
                  child: Image.asset(Assets.ic_check_solid),
                ),
                Container(
                    width: 56,
                    height: 1,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.fareColor,
                            width: 1.5
                        )
                    )
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: Radii.border(15),
                  ),
                  child: Image.asset(Assets.ic_check_solid),
                ),
                Container(
                    width: 56,
                    height: 1,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.fareColor,
                            width: 1.5
                        )
                    )
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: Radii.border(20),
                      border: Border.all(
                          color: AppColors.fareColor,
                          style: BorderStyle.solid,
                          width: 2)),
                  child: Image.asset(Assets.ic_download, color: AppColors.fareColor,),
                )
              ],
            ),
          ),
          Container(height: 8,),
          Text(getTranslation(Strings.transaction),
              style: const TextStyle(
                  color: AppColors.color_black_80_2,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 10.0),
              textAlign: TextAlign.center),
          Container(height: 8,),
          Text(getTranslation(Strings.receive_cash_merchant),
              style: const TextStyle(
                  color: AppColors.header_top_bar_color,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.center),
          Container(height: 8,),
          Text(getTranslation(Strings.requested_amount),
              style: const TextStyle(
                  color: AppColors.color_black_80_2,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              textAlign: TextAlign.center),
          Container(
            margin: EdgeInsets.only(top: 16,bottom: 16),
              width: 216,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: Radii.border(8),
                  border: Border.all(
                      color: AppColors.light_grey_blue,
                      width: 1
                  ),
                  color: AppColors.background_color
              ),
            child: Text(
                "Rp 500.000",
                style: const TextStyle(
                    color:  AppColors.fareColor,
                    fontWeight: FontWeight.w700,
                    
                    fontSize: 27.0
                ),
                textAlign: TextAlign.center
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            alignment: Alignment.center,
            height: 72,
              decoration: BoxDecoration(
                  borderRadius: Radii.border(8),
                  border: Border.all(
                      color: Color(0xf1e4c6),
                      width: 1
                  ),
                  color: const Color(0x80f1e4c6)
              ),
            child: Text(
                getTranslation(Strings.agent_in_progress_transaction_msg),
                style: const TextStyle(
                    color:  AppColors.fareColor,
                    fontWeight: FontWeight.w400,
                    
                    fontSize: 14.0
                ),
                textAlign: TextAlign.center
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Container(
                      width: 140,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: Radii.border(8),
                          border: Border.all(
                              color: AppColors.light_grey_blue,
                              width: 1
                          ),
                          color: Colors.white
                      ),
                    child: Text(
                        getTranslation(Strings.DECLINE),
                        style: const TextStyle(
                            color:  AppColors.badge_color,
                            fontWeight: FontWeight.w700,
                            
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                    onTap: (){
//                      widget.tapOnDecline();
                    showBottomSheet(context);
                    }
                ),
                InkWell(
                  child: Container(
                    width: 140,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: Radii.border(8),
                        color: AppColors.pale_turquoise
                    ),
                    child: Text(
                        getTranslation(Strings.confirm),
                        style: const TextStyle(
                            color:  AppColors.fareColor,
                            fontWeight: FontWeight.w700,
                            
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  onTap: (){
                    widget.tapOnConfirm();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future  showBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AgentDeclineTransaction();
      });
}


