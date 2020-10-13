import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_input_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_list_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends BaseState<ConversationPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        child: Scaffold(
          backgroundColor: Color(0xfff7f7fa),
            appBar: _buildAppBar(context), // Custom app bar for chat screen
            body: Stack(children: <Widget>[
              ChatListWidget(),
              Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        color: Color(0xfff7f7fa),
                        child: InputWidget(),
                      ),
                    ),
                  )
                ],
              ),

            ]
            )
        )
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: Text(
    getTranslation(Strings.TARA_CASH_DEPOSIT),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

}