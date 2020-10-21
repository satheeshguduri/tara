import 'package:flutter/material.dart';
import 'package:tara_app/common/widgets/chat_widgets/agent_confirmed.dart';
import 'package:tara_app/common/widgets/chat_widgets/agent_uin_otp_code.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_money_transfer_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_order_detail.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_pln_payment_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_request_cash_deposit.dart';
import 'package:tara_app/common/widgets/chat_widgets/decline_pay_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/deposit_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/on_delivery.dart';
import 'package:tara_app/common/widgets/chat_widgets/on_the_way.dart';
import 'package:tara_app/common/widgets/chat_widgets/order_details_decline_pay.dart';
import 'package:tara_app/common/widgets/chat_widgets/order_paid.dart';
import 'package:tara_app/common/widgets/chat_widgets/text_chat_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

// ignore: must_be_immutable

class ChatItemWidget extends StatefulWidget{

  var index;
  var chatMsg;
  var requestedAmount;
  Function onSelectAction;

  ChatItemWidget(this.index,this.chatMsg,this.requestedAmount, this.onSelectAction,);

  @override
  _ChatItemWidgetState createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends BaseState<ChatItemWidget> {

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }


  @override
  Widget build(BuildContext context) {

    if (widget.chatMsg == "onTheWay_isArrived") {
      return OnTheWay(
        isArrived: true,
      );
    } else if (widget.chatMsg == "onTheWay_isArrived_false") {
      return OnTheWay(
        isArrived: false,
      );
    } else if (widget.chatMsg == "agent_confirmed") {
      return AgentConfirmed();
    } else if (widget.chatMsg == "onTheWay_isVerified") {
      return OnTheWay(
        isVerifyingAgent: true,
      );
    } else if (widget.chatMsg == "agent_UIN_otp_true") {
      return AgentUINOROTP(
        isAgentUINCode: true,
      );
    } else if (widget.chatMsg == "agent_UIN_otp_false") {
      return AgentUINOROTP(
        isAgentUINCode: false,
      );
    } else if (widget.chatMsg == "deposit_success") {
      return DepositSuccess();
    } else if (widget.chatMsg == "decline_pay") {
      return DeclinePay(onTapAction: (val){
        widget.onSelectAction(val);
        print(val);
      },);
    } else if (widget.chatMsg == "decline_pay_isSender_true") {
      return DeclinePay(
        isSender: true,
        onTapAction: (val){
          print(val);
        },
      );
    } else if (widget.chatMsg == "chat_money_transfer_success") {
      return ChatMoneyTransferSuccess(requestedAmount: widget.requestedAmount,);
    } else if (widget.chatMsg == "decline_pay_isSender_declined_true") {
      return DeclinePay(
        isSender: true,
        isDeclined: true,
      );
    } else if (widget.chatMsg == "chat_pln_payment_success") {
      return ChatPLNPaymentSuccess();
    } else if (widget.chatMsg == "chat_request_cash_deposit") {
      return ChatRequestCashDeposit(requestedAmount: widget.requestedAmount,onTapCancel: (val){
        widget.onSelectAction(val);
      },);
    } else if (widget.chatMsg == "chat_request_cash_deposit_confirmed_true") {
      return ChatRequestCashDeposit(
        isConfirmed: true,
      );
    }
    else if (widget.chatMsg == "items_order") {
      return ItemsOrder();
    }
    else if (widget.chatMsg == "items_order_isFromAcceptedAnswer_true") {
      return ItemsOrder(isFromAcceptedOrder:true);
    }
    else if (widget.chatMsg == "chat_order_details") {
      return ChatOrderDetail();
    }
    else if (widget.chatMsg == "chat_order_paid")
    {
      return ChatOrderPaid();
    }
    else if (widget.chatMsg == "order_details_decline_pay")
    {
      return OrderDetailsDeclinePay();
    }
    else if (widget.chatMsg == "on_delivery")
    {
      return OnDelivery();
    }
    else if (widget.chatMsg == "on_delivery_isConfirmArrived_true")
    {
      return OnDelivery(isConfirmArrived:true);
    }
    else if (widget.chatMsg == "tara_shop_received_text")
    {
      return TextChatWidget(textMessage:"",isReceivedMsg: true,);
    }
    else
    {
      return TextChatWidget(textMessage:widget.chatMsg,isReceivedMsg: false,);
    }
  }
}
