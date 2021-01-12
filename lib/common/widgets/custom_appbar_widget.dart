import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import '../../common/constants/values.dart';


class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool addNewWidgetShow;
  final VoidCallback onPressed;


  @override
  final Size preferredSize;

  CustomAppBarWidget({ @required this.title,this.onPressed, @required this.addNewWidgetShow}) : preferredSize = Size.fromHeight(56.0);

  @override
  CustomAppBarWidgetState createState() => CustomAppBarWidgetState();
}

class CustomAppBarWidgetState extends BaseState<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: getRootContainer()),
    );
  }

  @override
  BuildContext getContext() => context;

  Widget getRootContainer() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
        color: AppColors.billerPaymentNextButtonColor,
        offset: Offset(0,1),
    blurRadius: 0,
    spreadRadius: 0
    )] ,
    color: AppColors.primaryElement,),
      height: 56,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  backArrowIcon(),
                  titleWidget(),
                ],
              ),
            ),
            addNewWidget(),
          ],
        ),
      ),
    );
  }

  Widget backArrowIcon() {
    return Container(
      margin: EdgeInsets.only(left:16,right: 12),
      child: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
          width: 24.0,
          height: 24.0),
    ).onTap(onPressed: (){
      pop();
    });
  }

  Widget titleWidget() {
    return Text( widget.title,
      style: BaseStyles.topBarTextStyle,
    );

  }

  Widget addNewIcon() {
    return Container(
      margin: EdgeInsets.only(right: 4),
      height: 20,
      width: 20,
      child: getSvgImage(imagePath: Assets.assets_icon_p_plus,
          width: 13.0,
          height: 13.0),
    );
  }

  Widget addNewTextWidget() {
    return  Container(
      margin: EdgeInsets.only(right: 16),
      child: Text(
          getTranslation(Strings.addNew),
          style: TextStyles.subtitle3222
      ),
    );
  }

 Widget addNewWidget() {
    if(widget.addNewWidgetShow){
     return  Row(children: [addNewIcon(), addNewTextWidget()]).onTap(onPressed: (){
        widget.onPressed();
       }
      );
    }else{
      return Container();
    }
  }
}
