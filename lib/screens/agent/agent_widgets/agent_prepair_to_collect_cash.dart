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
import 'package:tara_app/common/widgets/map_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class AgentPrepareToCollectCash extends StatefulWidget {

  final Function confirmDelivery;

  const AgentPrepareToCollectCash({Key key, this.confirmDelivery}) : super(key: key);

  @override
  _AgentPrepareToCollectCashState createState() =>
      _AgentPrepareToCollectCashState();
}

class _AgentPrepareToCollectCashState
    extends BaseState<AgentPrepareToCollectCash> {
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
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: Radii.border(20),
                      border: Border.all(
                          color: AppColors.fareColor,
                          style: BorderStyle.solid,
                          width: 2)),
                  child: Image.asset(Assets.ic_location1),
                ),
                Text(
                  "- - - -",
                  style: BaseStyles.placeholderStyle,
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: Colors.grey[400],
                  strokeWidth: 1.5,
                  dashPattern: [4.3],
                  radius: Radius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      Assets.ic_handshake,
                      color: Colors.grey[400],
                    ),
                  ),
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
          Text(getTranslation(Strings.cash_collection),
              style: const TextStyle(
                  color: AppColors.color_black_80_2,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 10.0),
              textAlign: TextAlign.center),
          Container(height: 8,),
          Text(getTranslation(Strings.prepare_to_coll_cash),
              style: const TextStyle(
                  color: AppColors.header_top_bar_color,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.center),
          Container(height: 8,),
          Text("Jl Kedoya Barat No.21-22, Jakarta Barat • 2 Km",
              style: const TextStyle(
                  color: AppColors.color_black_80_2,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              textAlign: TextAlign.center),
          Container(

            height: 136,
            decoration: BoxDecoration(borderRadius: Radii.border(8)),
            child: MapWidget(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(Assets.ic_person1),
                  Container(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Andi Ruhiyat",
                        style: const TextStyle(
                            color: AppColors.color_black_80_2,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(color: AppColors.light_grey_bg_color),
                        child: Text("where have you arrived?",
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                      ),
                    ],
                  )
                ],
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(Assets.ic_chat),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    alignment: Alignment.center,
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: AppColors.badge_color,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("1",
                        style: const TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0),
                        textAlign: TextAlign.center),
                  )
                ],
              )
            ],
          ),
          Container(
            key: confirmDelivery,
            margin: EdgeInsets.only(top: 16, bottom: 16),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: const Color(0xffb2f7e2)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 12,
                  bottom: 12,
                  child: Text(getTranslation(Strings.confirm_delivery),
                      style: const TextStyle(
                          color: AppColors.fareColor,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.center),
                ),
                Positioned(
                  left: positionX,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dragDetails) {
                      final keyContext = confirmDelivery.currentContext;
                      final box = keyContext.findRenderObject() as RenderBox;
                      double screenWidth = box.size.width - 56;
                      double dragPos = dragDetails.globalPosition.dx;
                      if (dragPos > screenWidth) {
                        // push to confirm delivery
                        widget.confirmDelivery();
                      } else {
                        setState(() {
                          positionX = dragPos;
                        });
                      }
                    },
                    child: Container(
                      width: 56,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: Radii.border(8),
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
                          color: const Color(0xffffffff)),
                      child: Center(
                        child: Image.asset(Assets.ic_right_arrow_long),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
