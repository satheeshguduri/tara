import 'package:flutter/material.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';


class TransferSuccessScreen extends StatefulWidget {

  const TransferSuccessScreen({Key key,})
      : super(key: key);

  @override
  TransferSuccessScreenState createState() =>  TransferSuccessScreenState();

}

class TransferSuccessScreenState extends BaseState<TransferSuccessScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: buildAppBar(context),
      body: getRootContainer(),
    );
  }


  Widget getRootContainer() {
    return Obx(() => SafeArea(
        child: getOtpWidget()
            ));

  }



  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false,
      // hides leading widget
      leading: IconButton(
        //  icon: Icon(Icons.arrow_back),
          icon: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
              width: 24.0,
              height: 24.0),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(getTranslation(Strings.inputOTP),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

 Widget getOtpWidget() {
    return Container();
 }






}
