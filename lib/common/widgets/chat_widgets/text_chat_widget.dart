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

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Expanded(
            child: Row(
              mainAxisAlignment: widget.isReceivedMsg?MainAxisAlignment.start:MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.isReceivedMsg?AssetImage(Assets.ic_chat_text_bubble_left,):AssetImage(Assets.ic_chat_text_bubble_right),
                            fit: BoxFit.cover,
                          )),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(bottom: 8, left: 16, right: 8,top: 16),
                                child: Text(
                                  "Hi! This is Tara App",
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
          ),
          margin: EdgeInsets.only(bottom: 10.0),
        ));
  }


}
