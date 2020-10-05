import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/chat_item_widget.dart';


class ChatListWidget extends StatelessWidget{
  final ScrollController listScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => ChatItemWidget(index),
          itemCount: 8,
          reverse: false,
          controller: listScrollController,
        ));
  }
}