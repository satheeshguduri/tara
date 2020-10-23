import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/circle_shape.dart';
import 'package:tara_app/screens/base/base_state.dart';

class ScanQRCode extends StatefulWidget {
  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends BaseState<ScanQRCode> with TickerProviderStateMixin {
  var qrText = '';
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isAllowCameraAccessClicked = false;

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: Center(
          child: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 270,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 8,
                  right: 8,
                  child: Container(
                    margin: EdgeInsets.only(left: 32,right: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( height:60,width:60,decoration:myBoxDecoration_topLeft(),),
                            Container( height:60,width:60,decoration: myBoxDecoration_topRight()),
                          ],
                        ),
                        Container(
                          height: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( height:60,width:60,decoration: myBoxDecoration_bottomLeft()),
                            Container( height:60,width:60,decoration: myBoxDecoration_bottomRight()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 36,
                  right: 36,
                  child: Align(
                      alignment: Alignment.center,
                      child: isAllowCameraAccessClicked?Container(
                        margin: EdgeInsets.only(top: 4,bottom: 4),
                        height: 260,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: getScannerWidget(),
                      ):Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(margin: EdgeInsets.only(top: 16,),child: CircleShape(width: 80,height: 80,bgColor: Color(0xffd8d8d8),),),
                            Container(margin: EdgeInsets.only(top: 8,left: 16,right: 16),child:  Text(
                              getTranslation(Strings.camera_access_text),
                              style: BaseStyles.ktpTitleTextStyle,
                              textAlign: TextAlign.center,
                            )),
                            Container(padding: EdgeInsets.only(left: 8,right: 8),margin: EdgeInsets.only(top: 8,left: 8,right: 8,),child:  Text(getTranslation(Strings.camera_access_sub_text),
                              style: BaseStyles.alreadyHaveAccountTextStyle,textAlign: TextAlign.center,),),
                            _getAllowCameraAccessWidget()
                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          isAllowCameraAccessClicked?Container(margin: EdgeInsets.only(top: 40,left: 16,right: 16),child:  Text(
            getTranslation(Strings.find_qr_code_to_scan),
            style: BaseStyles.ktpTitleTextStyle,
            textAlign: TextAlign.center,
          )):Container(),
          isAllowCameraAccessClicked?Container(padding: EdgeInsets.only(left: 8,right: 8),margin: EdgeInsets.only(top: 8,left: 16,right: 16,bottom: 16),child:  Text(getTranslation(Strings.find_qr_code_subtext),
            style: BaseStyles.alreadyHaveAccountTextStyle,textAlign: TextAlign.center,),):Container(),
        ],
      ),
    ))));
  }

  BoxDecoration myBoxDecoration_topLeft() {
    return BoxDecoration(
      border: Border(
        left: BorderSide( //                   <--- left side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
        top: BorderSide( //                    <--- top side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
      ),
    );
  }
  BoxDecoration myBoxDecoration_topRight() {
    return BoxDecoration(
      border: Border(
        right: BorderSide( //                   <--- left side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
        top: BorderSide( //                    <--- top side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
      ),
    );
  }
  BoxDecoration myBoxDecoration_bottomLeft() {
    return BoxDecoration(
      border: Border(
        left: BorderSide( //                   <--- left side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
        bottom: BorderSide( //                    <--- top side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
      ),
    );
  }
  BoxDecoration myBoxDecoration_bottomRight() {
    return BoxDecoration(
      border: Border(
        right: BorderSide( //                   <--- left side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
        bottom: BorderSide( //                    <--- top side
          color: isAllowCameraAccessClicked?AppColors.header_top_bar_color:Color(0xffb0b4c1),
          width: 3.0,
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0.8,
        centerTitle: true,
        automaticallyImplyLeading: false, // hides leading widget
        title:Text(
          getTranslation(Strings.scan_qr),
          textAlign: TextAlign.center,
          style: BaseStyles.topBarTextStyle,
        ),
    );
  }

  _getAllowCameraAccessWidget() {
    return InkWell(
      onTap: () {
          setState(() {
            isAllowCameraAccessClicked = true;
          });
      },
      child: Container(
        width: 180,
        child:Container(
        height: 40,
        margin: EdgeInsets.only(top: 8,left: 8,right: 8,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffb2f7e2),),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.allow_camera_access_text),
          textAlign: TextAlign.center,
          style: BaseStyles.chatItemDepositSuccessMoneyTextStyle,
        ),
      ),),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  /// Display the preview from the camera (or a message if the preview is not available).
   getScannerWidget() {

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.transparent,//Color(0xffb2f7e2),
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        print("qr  text is : {$qrText}");
      });
    });
  }
}