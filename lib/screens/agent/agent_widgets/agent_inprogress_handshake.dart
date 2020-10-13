
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgentInProgressHandShake extends StatefulWidget {

  final Function confirmDelivery;

  const AgentInProgressHandShake({Key key, this.confirmDelivery}) : super(key: key);

  @override
  _AgentInProgressHandShakeState createState() =>
      _AgentInProgressHandShakeState();
}

class _AgentInProgressHandShakeState
    extends BaseState<AgentInProgressHandShake> {
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
                Text(
                  "- - - -",
                  style: BaseStyles.placeholderStyle,
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
                  child: SvgPicture.asset(Assets.ic_handshake),
                ),
                Text(
                  "- - - -",
                  style: BaseStyles.placeholderStyle,
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: Colors.grey[400],
                  strokeWidth: 2,
                  dashPattern: [4.3],
                  radius: Radius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      Assets.ic_download,
                      fit: BoxFit.none,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 8,),
          Text(getTranslation(Strings.handshake),
              style: const TextStyle(
                  color: AppColors.color_black_80_2,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 10.0),
              textAlign: TextAlign.center),
          Container(height: 8,),
          Text(getTranslation(Strings.share_code_to_mer),
              style: const TextStyle(
                  color: AppColors.header_top_bar_color,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.center),
          Container(height: 8,),
          Text(getTranslation(Strings.your_UIN_code),
              style: const TextStyle(
                  color: AppColors.color_black_80_2,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              textAlign: TextAlign.center),
          Container(
              width: 216,
              height: 56,
              margin: EdgeInsets.only(top: 8,bottom: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: Radii.border(8),
                  border: Border.all(
                      color: AppColors.light_grey_bg_color,
                      width: 1
                  ),
                  color: AppColors.background_color
              ),
            child: Text(
                "TAR112322421",
                style: const TextStyle(
                    color: AppColors.fareColor,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 27.0
                ),
                textAlign: TextAlign.center
            ),
          ),
          Container(
              width: 190,
              margin: EdgeInsets.only(top: 8,bottom: 16),
              padding: EdgeInsets.only(top: 4,bottom: 4,left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: Radii.border(6),
                  border: Border.all(
                      color: AppColors.light_grey_blue,
                      width: 1
                  ),
                  color: Colors.white
              ),
            child:
            Row(
              children: <Widget>[
                Image.asset(Assets.ic_share),
                Text(getTranslation(Strings.share_code_to_chat),
                    style: const TextStyle(
                        color: AppColors.header_top_bar_color,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                    textAlign: TextAlign.center),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8,bottom: 16),
              height: 1,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.light_grey_bg_color,
                      width: 1
                  )
              )
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Text(
                getTranslation(Strings.input_otp_code),
                style: const TextStyle(
                    color:  AppColors.fareColor,
                    fontWeight: FontWeight.w400,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.center
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:16,left: 16,right: 16),
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.light_grey_blue,
                    width: 1.0,
                  ),
                )),
            child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:InkWell(
                      onTap: (){
                      },
                      child: Image.asset(Assets.ic_lock,color:Color(0xff8899aa)),
                    ),
                  ),
                  Expanded(
                      flex: 9,
                      child: TextFieldWidget(
                        isObscure:true,
                        hint: getTranslation(Strings.enter_otp_code),
                        placeHolderStyle: BaseStyles.enterOTPTextStyle,
                      )),
                ]),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top:16,left: 16,right: 16),
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)
                  ),
                  color: AppColors.light_grey_bg_color
              ),
              child: Text(
                getTranslation(Strings.confirm_handshake),
                style: TextStyle(
                    color:  AppColors.color_black_80_2,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
