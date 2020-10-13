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
      itemBuilder: (context, index) => ChatItemWidget(index,""), //arrStr[index]
      itemCount: 24,//(arrStr!=null&&arrStr.length>0)?arrStr.length:0,
      reverse: false,
      controller: listScrollController,
    ));
  }

/*  getChatStaticArr()
  {
    arrStr.add("onTheWay_isArrived");
    arrStr.add("onTheWay_isArrived_false");
    arrStr.add("agent_confirmed");
    arrStr.add("onTheWay_isVerified");
    arrStr.add("agent_UIN_otp_true");
    arrStr.add("agent_UIN_otp_false");
    arrStr.add("deposit_success");
    arrStr.add("decline_pay");
    arrStr.add("decline_pay_isSender_true");
    arrStr.add("chat_money_transfer_success");
    arrStr.add("decline_pay_isSender_declined_true");
    arrStr.add("chat_pln_payment_success");
    arrStr.add("chat_request_cash_deposit");
    arrStr.add("chat_request_cash_deposit_confirmed_true");
    arrStr.add("items_order");
    arrStr.add("items_order_isFromAcceptedAnswer_true");
    arrStr.add("chat_order_details");
    arrStr.add("chat_order_paid");
    arrStr.add("order_details_decline_pay");
    arrStr.add("on_delivery");
    arrStr.add("on_delivery_isConfirmArrived_true");
    arrStr.add("Hi! This is Tara App");
  } */

}
