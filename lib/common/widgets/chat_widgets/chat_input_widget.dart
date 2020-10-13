import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_list_widget.dart';
import 'package:tara_app/common/widgets/circle_shape.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/receive_money.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({Key key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends BaseState<InputWidget> {
  final TextEditingController textEditingController =
  new TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10,right: 16,top: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16,right: 8),
            width: 40,
            height: 40,
            decoration: new BoxDecoration(
              color: AppColors.header_top_bar_color,
              shape: BoxShape.circle,
            ),
            child:Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: new Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                color: AppColors.primaryText,
                onPressed: (){
                  receiveBottomSheet();
                },
              ),
            ),),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                        child: TextField(
                            style: TextStyle(color: AppColors.primaryText, fontSize: 15.0),
                            controller: textEditingController,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Write a message....',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            minLines:1,maxLines:5,
                          keyboardType:TextInputType.text ,
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.send,size: 22,),
                        onPressed: () => {
                        /*  ChatListWidget(
                            chatMsg:textEditingController.text.toString()
                          ),
                          textEditingController.text = "" */
                        },
                        color: AppColors.header_top_bar_color,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      width: double.infinity,
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  Future  receiveBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ReceiveWidget();
        });
  }

}

