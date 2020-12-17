import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';

class TextChatWidget extends StatefulWidget {

  final String textMessage;
  final bool isReceivedMsg;
  const TextChatWidget(
      {Key key,this.textMessage,this.isReceivedMsg=false})
      : super(key: key);

  @override
  _TextChatWidgetState createState() => _TextChatWidgetState();
}

class _TextChatWidgetState extends BaseState<TextChatWidget> {

  var taraShopText = "Hi 👋 \n Welcome to Tara Shop! \n\n Now you can order whatever you need easily, and tailored specifically for you.\n You can ask and adjust your order directly with our Trusted Merchant Partner.";

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: widget.isReceivedMsg?MainAxisAlignment.start:MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: widget.isReceivedMsg?const Color(0xffb2f7e2):const Color(0x1f000000),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: 0),
                      BoxShadow(
                          color: widget.isReceivedMsg?const Color(0xffb2f7e2):const Color(0x14000000),
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 0)
                    ],
                    color: widget.isReceivedMsg?const Color(0xffb2f7e2):AppColors.primaryBackground),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                          EdgeInsets.only(bottom: 8, left: 16, right: 8,top: 16),
                          child: Text(
                            widget.isReceivedMsg?taraShopText:widget.textMessage,
                            style: BaseStyles.chatItemSubTextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  DateFormat('kk:mm').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          1565888474278)),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.normal),
                                ),
                                margin:
                                EdgeInsets.only(bottom: 8.0, right: 8),
                              )
                            ])
                      ],
                    ),
                  ],
                )),
            width: 200,
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }


}
