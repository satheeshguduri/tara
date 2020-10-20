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

// ignore: must_be_immutable
class ChatItemWidget extends StatelessWidget {
  var index;
  var chatMsg;
  var requestedAmount;

  ChatItemWidget(this.index,this.chatMsg,this.requestedAmount);

  List<String> arrWidgets = [];

  @override
  Widget build(BuildContext context) {

    if (chatMsg == "onTheWay_isArrived") {
      return OnTheWay(
        isArrived: true,
      );
    } else if (chatMsg == "onTheWay_isArrived_false") {
      return OnTheWay(
        isArrived: false,
      );
    } else if (chatMsg == "agent_confirmed") {
      return AgentConfirmed();
    } else if (chatMsg == "onTheWay_isVerified") {
      return OnTheWay(
        isVerifyingAgent: true,
      );
    } else if (chatMsg == "agent_UIN_otp_true") {
      return AgentUINOROTP(
        isAgentUINCode: true,
      );
    } else if (chatMsg == "agent_UIN_otp_false") {
      return AgentUINOROTP(
        isAgentUINCode: false,
      );
    } else if (chatMsg == "deposit_success") {
      return DepositSuccess();
    } else if (chatMsg == "decline_pay") {
      return DeclinePay();
    } else if (chatMsg == "decline_pay_isSender_true") {
      return DeclinePay(
        isSender: true,
      );
    } else if (chatMsg == "chat_money_transfer_success") {
      return ChatMoneyTransferSuccess(requestedAmount: requestedAmount,);
    } else if (chatMsg == "decline_pay_isSender_declined_true") {
      return DeclinePay(
        isSender: true,
        isDeclined: true,
      );
    } else if (chatMsg == "chat_pln_payment_success") {
      return ChatPLNPaymentSuccess();
    } else if (chatMsg == "chat_request_cash_deposit") {
      return ChatRequestCashDeposit(requestedAmount: requestedAmount,);
    } else if (chatMsg == "chat_request_cash_deposit_confirmed_true") {
      return ChatRequestCashDeposit(
        isConfirmed: true,
      );
    }
    else if (chatMsg == "items_order") {
      return ItemsOrder();
    }
    else if (chatMsg == "items_order_isFromAcceptedAnswer_true") {
      return ItemsOrder(isFromAcceptedOrder:true);
    }
    else if (chatMsg == "chat_order_details") {
      return ChatOrderDetail();
    }
    else if (chatMsg == "chat_order_paid")
    {
      return ChatOrderPaid();
    }
    else if (chatMsg == "order_details_decline_pay")
    {
      return OrderDetailsDeclinePay();
    }
    else if (chatMsg == "on_delivery")
    {
      return OnDelivery();
    }
    else if (chatMsg == "on_delivery_isConfirmArrived_true")
    {
      return OnDelivery(isConfirmArrived:true);
    }
    else if (chatMsg == "tara_shop_received_text")
    {
      return TextChatWidget(textMessage:"",isReceivedMsg: true,);
    }
    else
    {
      return TextChatWidget(textMessage:chatMsg,isReceivedMsg: false,);
    }
  }
}
