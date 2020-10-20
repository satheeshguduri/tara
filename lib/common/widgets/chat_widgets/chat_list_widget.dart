import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_item_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

// ignore: must_be_immutable
class ChatListWidget extends StatefulWidget {

  final String chatMsg;

  ChatListWidget(
      {Key key,
        this.chatMsg,})
      : super(key: key);

  @override
  _ChatListWidgetState createState() => _ChatListWidgetState();
  }

  class _ChatListWidgetState extends BaseState<ChatListWidget> {

    final ScrollController listScrollController = new ScrollController();

  @override
  BuildContext getContext() {
  // TODO: implement getContext
  return context;
  }

  List<String> arrStr = [];

    // ignore: must_call_super
    @override
    void initState() {
      super.initState();
     // getChatStaticArr();
    }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(height: MediaQuery.of(context).size.height,
        child: ListView.builder(
      padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 60),
      itemBuilder: (context, index) => ChatItemWidget(index,"","",(val){}), //arrStr[index]
      itemCount: 24,//(arrStr!=null&&arrStr.length>0)?arrStr.length:0,
      reverse: false,
      controller: listScrollController,
    ));
  }



}
