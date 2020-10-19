
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgentDeclineTransaction extends StatefulWidget{

  @override
  _AgentDeclineTransactionState createState() => _AgentDeclineTransactionState();
}

class _AgentDeclineTransactionState extends BaseState<AgentDeclineTransaction>{

  List<String> arrTransDecline = ["The amount is not match with Requested Deposit Amount",
    "The quality of the cash money is bad","Other"];
  List<int> arrSelectedIndex = List<int>();
  bool isOtherSelected = false;
  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
//      height: 410,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
          color: Colors.white
      ),
      child: Wrap(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 53,
              height: 4,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(4)
                  ),
                  color: AppColors.light_grey_bg_color
              ),
            ),
          ),
          Text(
              getTranslation(Strings.decline_trans_heading),
              style: const TextStyle(
                  color:  AppColors.fareColor,
                  fontWeight: FontWeight.w700,
                  fontStyle:  FontStyle.normal,
                  fontSize: 20.0
              )
          ),
          Container(
            child:ListView.builder(
                itemCount: arrTransDecline.length,
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return
                    Container(
                      padding: EdgeInsets.only(top: 8,bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex:2,
                            child:InkWell(
                              child: arrSelectedIndex.contains(index) ? SvgPicture.asset(Assets.ic_check_filled,width: 24,) : SvgPicture.asset(Assets.ic_check_un_select,width: 24,),
                              onTap: (){
                                if(arrSelectedIndex.contains(index)){
                                  setState(() {
                                    if (index == 2){
                                      isOtherSelected = false;
                                    }
                                    arrSelectedIndex.remove(index);
                                  });
                                }else{
                                  if (index == 2){
                                    isOtherSelected = true;
                                  }
                                  setState(() {
                                    arrSelectedIndex.add(index);
                                  });
                                }

                              },
                            ) ,
                          ),
                          Expanded(
                            flex: 12,
                            child:Text(
                                arrTransDecline[index],
                                style: const TextStyle(
                                    color:  AppColors.fareColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 14.0
                                )
                            ) ,
                          )
                        ],
                      ),
                    );
                }) ,
          ),
          isOtherSelected ? Container(
            margin: EdgeInsets.only(left: 16, right: 16,bottom: 8),
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.light_grey_blue,
                    width: 1.0,
                  ),
                )),
            child: TextFieldWidget(
              hint: getTranslation(Strings.describe_issue),
              placeHolderStyle: BaseStyles.placeholderStyle,
            ),
          ) : Container(),
          Container(
            alignment: Alignment.center,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)
                  ),
                  color: AppColors.pale_turquoise
              ),
            child: Text(getTranslation(Strings.send_report),
            style: TextStyle(
                color:  AppColors.fareColor,
                fontWeight: FontWeight.w700,
                fontStyle:  FontStyle.normal,
                fontSize: 14.0
            ),),
          )
        ],
      ),
    );
  }
}