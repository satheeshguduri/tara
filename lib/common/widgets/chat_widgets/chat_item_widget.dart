import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/widgets/chat_widgets/agent_confirmed.dart';
import 'package:tara_app/common/widgets/chat_widgets/agent_uin_otp_code.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_money_transfer_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_pln_payment_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_request_cash_deposit.dart';
import 'package:tara_app/common/widgets/chat_widgets/decline_pay_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/deposit_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/on_the_way.dart';

// ignore: must_be_immutable
class ChatItemWidget extends StatelessWidget {
  var index;

  ChatItemWidget(this.index);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return OnTheWay(
        isArrived: true,
      );
    } else if (index == 1) {
      return OnTheWay(
        isArrived: false,
      );
    } else if (index == 2) {
      return AgentConfirmed();
    } else if (index == 3) {
      return OnTheWay(
        isVerifyingAgent: true,
      );
    } else if (index == 4) {
      return AgentUINOROTP(
        isAgentUINCode: true,
      );
    } else if (index == 5) {
      return AgentUINOROTP(
        isAgentUINCode: false,
      );
    } else if (index == 7) {
      return DepositSuccess();
    } else if (index == 8) {
      return DeclinePay();
    } else if (index == 9) {
      return DeclinePay(
        isSender: true,
      );
    } else if (index == 10) {
      return ChatMoneyTransferSuccess();
    } else if (index == 11) {
      return DeclinePay(
        isSender: true,
        isDeclined: true,
      );
    } else if (index == 12) {
      return ChatPLNPaymentSuccess();
    } else if (index == 13) {
      return ChatRequestCashDeposit();
    } else if (index == 14) {
      return ChatRequestCashDeposit(
        isConfirmed: true,
      );
    }
    else if (index == 15) {
      return ItemsOrder();
    }
    else if (index == 16) {
      return ItemsOrder(isFromAcceptedOrder:true);
    }
    else {
      return Container();
    }
  }
}
