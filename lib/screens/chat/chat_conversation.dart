import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_money_transfer_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/decline_pay_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/make_an_order_chat.dart';
import 'package:tara_app/common/widgets/chat_widgets/on_delivery.dart';
import 'package:tara_app/common/widgets/chat_widgets/order_details_decline_pay.dart';
import 'package:tara_app/common/widgets/chat_widgets/order_paid.dart';
import 'package:tara_app/common/widgets/chat_widgets/text_chat_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/order_update_controller.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/chat/message_type.dart';
import 'package:tara_app/models/chat/order.dart';
import 'package:tara_app/models/chat/payment_success.dart';
import 'package:tara_app/models/chat/text_message.dart';
import 'package:tara_app/models/order_management/orders/order.dart'
    as OrderModel;
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/receive_money.dart';
import 'package:tara_app/screens/chat/send_money.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';
import 'package:tara_app/screens/consumer/shop/make_an_order.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/firebase/firebase_remote_service.dart';
import 'package:tara_app/shop/shopping_home_page.dart';

enum ChatEntryPoint { MC_PAYMENT, ORDER, TRANSFER, INBOX }

class ConversationPage extends StatefulWidget {
  final bool canGoBack;
  final bool isFromSend;
  final bool isFromReceive;
  final ContactInfo selectedContact;
  final ChatInboxInfo chatInboxInfo;
  final bool isFromTaraOrder;
  final List<String> arrChats;
  final Function callback;
  final bool isFromShopHome;
  final CustomerProfile custInfo;
  final Store merchantStore;
  final FromScreen fromScreen;
  final bool showMakeAnOrder;
  final ChatEntryPoint entry;

  ConversationPage(
      {this.canGoBack = true,
      this.isFromSend = false,
      this.isFromReceive = false,
      this.selectedContact,
      this.chatInboxInfo,
      this.isFromTaraOrder = false,
      Key key,
      this.arrChats,
      this.callback,
      this.isFromShopHome,
      this.custInfo,
      this.merchantStore,
      this.fromScreen = FromScreen.consumer,
      this.showMakeAnOrder = false,
      this.entry})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends BaseState<ConversationPage> {
  final ScrollController listScrollController = ScrollController();
  List<String> arrStr = [];
  TextEditingController textEditingController = TextEditingController();
  bool isPlusClicked = false;
  String chatMsg = "";
  bool isToShowSendAndReceiveBottomSheet = true;
  String sendReceiveMoney = "100";
  bool isSendReceiveConfirmed = false;
  ChatInboxInfo chatInboxInfoGlobal;
  bool isFromTaraOrder = false;
  AuthResponse user = Get.find<AuthController>().user.value;
  OrderUpdateController controller = Get.put(OrderUpdateController());

  OrderModel.Order customerOrder;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void init() async {
    // TODO: implement init
    super.init();

    print(widget.merchantStore);
    print(widget.custInfo.firebaseId);
    var data = await getIt.get<UserLocalDataStore>().getUser();
    user = data;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    chatInboxInfoGlobal = widget.chatInboxInfo;
    isFromTaraOrder = widget.isFromTaraOrder;
    // getChatStaticArr();
    showChatInboxWidgets();
    if (widget.arrChats != null && widget.arrChats.isNotEmpty) {
      arrStr = widget.arrChats;
    }
    // arrStr = widget?.arrChats??[];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
            top: false,
            child: Scaffold(
                backgroundColor: Color(0xfff7f7fa),
                appBar: _buildAppBar(context), // Custom app bar for chat screen
                body: Stack(children: <Widget>[
                  getChatListView(),
                  Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Container(
                            color: Color(0xfff7f7fa),
                            child: getChatInputWidget(),
                          ),
                        ),
                      )
                    ],
                  ),
                  widget.fromScreen == FromScreen.consumer &&
                              widget.showMakeAnOrder ??
                          false
                      ? Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Positioned(
                              bottom: 76,
                              width: MediaQuery.of(context).size.width,
                              child: MakeAnOrderChat(
                                onSelectOption: (val) {
                                  showOrderTypeBottomSheet(context);

                                  // Get.to(MakeAnOrder(
                                  //   isFromShopHome: false,
                                  //   merchantStore: widget.merchantStore,
                                  //   merchantProfile: widget.custInfo,
                                  // )
                                  // );
                                },
                              ),
                            )
                          ],
                        )
                      : Container(),
                  (!widget.isFromSend && !widget.isFromReceive)
                      ? Container()
                      : (isToShowSendAndReceiveBottomSheet
                          ? showReceiveOrSendBottomSheet()
                          : Container()),
                  isFromTaraOrder == true
                      ? showCashDepositBottomSheet()
                      : Container()
                ])))
        .withProgressIndicator(showIndicator: controller.showProgress.value));
  }

  Widget showReceiveOrSendBottomSheet() {
    Timer(Duration(milliseconds: 2), () {
      if (widget.isFromSend == true) {
        isToShowSendAndReceiveBottomSheet = false;
        sendBottomSheet();
      } else if (widget.isFromReceive == true) {
        isToShowSendAndReceiveBottomSheet = false;
        receiveBottomSheet();
      }
    });
    return Container();
  }

  Widget showCashDepositBottomSheet() {
    Timer(Duration(milliseconds: 2), () {
      if (widget.isFromTaraOrder == true) {
        cashDepositBottomSheet(widget.chatInboxInfo);
      }
    });
    return Container();
  }

  Future cashDepositBottomSheet(ChatInboxInfo chatInboxInfo) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return CashDepositWidget(
            chatInboxInfo: chatInboxInfo,
            chatInboxInfoCallBack: (chatInfo) {
              setState(() {
                chatInboxInfoGlobal = chatInfo;
                isFromTaraOrder = false;
                showChatInboxWidgets();
              });
            },
          );
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: Visibility(
        visible: widget.canGoBack,
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.entry == ChatEntryPoint.MC_PAYMENT ||
                  widget.entry == ChatEntryPoint.TRANSFER) {
                popToRootScreen(HomeCustomerScreen());
              } else if (widget.isFromShopHome == true) {
                widget.callback();
              } else if (arrStr.contains("chat_money_transfer_success")) {
                popToRootScreen(HomeCustomerScreen());
              } else {
                Navigator.pop(context, false);
              }
            }),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: getAvatarWithName(),
      ),
    );
  }

  Widget getAppBarTitle() {
    return Text(
      getTranslation(Strings.TARA_CASH_DEPOSIT),
      textAlign: TextAlign.left,
      style: BaseStyles.topBarTextStyle,
    );
  }

  Widget getAvatarWithName() {
    return Container(
      child: Row(
        children: [
          Image.asset(
            "assets/images/avatar-11.png",
            height: 32,
            width: 32,
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    widget?.custInfo?.firstName ?? "Chat",
                    textAlign: TextAlign.left,
                    style: BaseStyles.backAccountHeaderTextStyle,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffb2f7e2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        "Online",
                        textAlign: TextAlign.left,
                        style: BaseStyles.enterMPINTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getChatListView() {
    // TODO: implement build
//    return Container(height: MediaQuery.of(context).size.height,
//        child:
//        ListView.builder(
//          padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 60),
//          itemBuilder: (context, index) => ChatItemWidget(index,arrStr[index],sendReceiveMoney,
//              (val){
//            print(val);
//            if(val == "decline"){
//              setState(() {
//                arrStr.add("decline_pay_isSender_declined_true");
//              });
//            }else if (val == "pay"){
//              setState(() {
//                arrStr.add("chat_money_transfer_success");
//              });
//            }else if (val == "cancel_Req"){
//              setState(() {
//              });
//            }else if (val == "makeAnOrder"){
//              push(MakeAnOrder(callBack: (arrOfStrings){
//                setState(() {
//                  arrStr.clear();
//                  arrStr = arrOfStrings;
//                });
//              },));
//            }
//            else if (val == Strings.confirm_order){
//              setState(() {
//                arrStr.clear();
//                arrStr.add("items_order_isFromAcceptedAnswer_true");
//              });
//            }
//            else if (val == Strings.order_detail){
//              setState(() {
//                arrStr.add("chat_order_details");
//              });
//            }
//            else if (val == Strings.order_paid){
//              setState(() {
//                arrStr.add("chat_order_paid");
//              });
//            }
//          }),
//          itemCount: (arrStr!=null&&arrStr.length>0)?arrStr.length:0,
//          reverse: false,
//          controller: listScrollController,
//        ))

    // animateToEnd();
    return new FirebaseAnimatedList(
        controller: listScrollController,
        query: getIt.get<FirebaseRemoteService>().getDataStream(
            path: FirebasePath.getPath(
                user?.customerProfile?.firebaseId, widget.custInfo.firebaseId)),
        padding:
            EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 120.0),
        reverse: false,
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int x) {
          var data = loadChatWidget(snapshot);
          // if (listScrollController.hasClients) {
          //   listScrollController.animateTo(
          //     listScrollController.position?.maxScrollExtent,
          //     duration: const Duration(milliseconds: 100),
          //     curve: Curves.ease,
          //   );
          // }
          return data;
        });
  }

  animateToEnd() {
    Timer(
      Duration(milliseconds: 225),
      () {
        if (listScrollController.hasClients) {
          listScrollController.animateTo(
            listScrollController.position?.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        }
      },
    );
  }

  Timer timer;
  Widget loadChatWidget(DataSnapshot snapshot) {
    timer?.cancel();
    timer = Timer(
      Duration(milliseconds: 220),
      () {
        listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
    print(snapshot.value.toString());
    var chatType = snapshot.value["messageType"].toString();
    if (chatType == describeEnum(MessageType.ORDER)) {
      var order = Order.fromSnapshot(snapshot);
      if (widget.fromScreen == FromScreen.merchant) {
        switch (order.orderStatus) {
          case Statuses.PENDING:
            return ItemsOrder(
              fromScreen: FromScreen.merchant,
              order: order,
            );
            break;
          case Statuses.ACCEPTED:
            return ItemsOrder(
              isFromAcceptedOrder: true,
              fromScreen: FromScreen.merchant,
              order: order,
              onTapAction: () {},
            );
            break;
          case Statuses.CANCELLED:
            return ItemsOrder(
              isFromCancelledOrder: true,
              order: order,
              fromScreen: FromScreen.merchant,
              onTapAction: () {},
            );
          case Statuses.ORDER_PAYMENT_DECLINED:
            return DeclinePay(
              isSender: false,
              isDeclined: true,
              onTapAction: (chatAction) {},
            );
            break;
          case Statuses.IN_TRANSIT:
            //"payment paid By the User"
            return OnDelivery(isConfirmArrived: true, order: order);
            break;
          case Statuses.PAID:
            return ChatOrderPaid(
              fromScreen: FromScreen.merchant,
              order: order,
            );
          case Statuses.DELIVERED:
            return ChatOrderPaid(
              order: order,
              isFromOrderDelivered: true,
              fromScreen: FromScreen.merchant,
            );
          default:
            break;
        }
        ;
      } else if (widget.fromScreen == FromScreen.consumer) {
        // CONSUMER CHAT
        switch (order.orderStatus) {
          case Statuses.PENDING:
            return ItemsOrder(
              fromScreen: FromScreen.consumer,
              order: order,
              selfOrder: true,
              onTapAction: () {
                push(MakeAnOrder(
                  isFromShopHome: false,
                  merchantStore: widget.merchantStore,
                  merchantProfile: widget.custInfo,
                ));
              },
            );
            break;
          case Statuses.ACCEPTED:
            //return Pay and Decline Widget Here (i.e "Order confirmed by the Store")
            return OrderDetailsDeclinePay(
              order: order,
              onTapAction: (chatAction) async {
                // make service call to get the order Details
                var response =
                    await controller.getOrderByOrderId(order.orderId);
                response.fold(
                    (l) => print(l.message),
                    (r) => {
                          customerOrder = r,
                          consumerAcceptDeclineOrderPayment(chatAction)
                        });
              },
            );
            break;
          case Statuses.CANCELLED:
            //"Ordered declined by the Store"
            return ItemsOrder(
              isFromCancelledOrderByStore: true,
              order: order,
              onTapAction: () {},
            );
            break;
          case Statuses.ORDER_PAYMENT_DECLINED:
            //update the txt on Pay and decline widget, button should be replaced with text (i.e "You have declined the payment")
            //"Payment Declined By the User"
            return DeclinePay(
              isSender: true,
              isDeclined: true,
              onTapAction: (chatAction) {},
            );
            break;
          case Statuses.PAID:
            //return the pay decline card with disable the button and add text says transaction paid
            return ChatOrderPaid(order: order, fromScreen: FromScreen.consumer);
            //"payment paid By the User"
            // return ChatOrderPaid(fromScreen: FromScreen.consumer,order: order,);
            break;
          case Statuses.IN_TRANSIT:
            //"payment paid By the User"
            return OnDelivery(
              isConfirmArrived: true,
              order: order,
              fromScreen: FromScreen.consumer,
            );
            break;
          case Statuses.DELIVERED:
            //"payment paid By the User"
            return ChatOrderPaid(
              order: order,
              isFromOrderDelivered: true,
              fromScreen: FromScreen.consumer,
            );
            break;
          default:
            return Container();
        }
      } else {
        return Container();
      }
    }
    else if (chatType == describeEnum(MessageType.TRANSFER)) {
      PaymentSuccess paymentSuccess = PaymentSuccess.fromSnapshot(snapshot);
      if (paymentSuccess.payeeId == widget.custInfo.firebaseId) {
        return DeclinePay(
          isSender: false,
          isDeclined: false,
          onTapAction: (chatAction) {

          },
        );
      }else{
        return DeclinePay(
          isSender: true,
          isDeclined: false,
          onTapAction: (chatAction) {

          },
        );
      }

      // return ChatMoneyTransferSuccess(
      //   paymentSuccess: paymentSuccess,
      // );
      /*return ChatRequestCashDeposit(requestedAmount: paymentSuccess.amount.toString(),onTapCancel: (val){

      },);*/
      return ChatMoneyTransferSuccess(
        paymentSuccess: paymentSuccess,
      );
    } else if (chatType == describeEnum(MessageType.PAYMENT)) {
      PaymentSuccess paymentSuccess = PaymentSuccess.fromSnapshot(snapshot);
      return ChatMoneyTransferSuccess(
        paymentSuccess: paymentSuccess,
      );
    } else if (chatType == describeEnum(MessageType.BILL_PAYMENT)) {
      PaymentSuccess paymentSuccess = PaymentSuccess.fromSnapshot(snapshot);
      return ChatMoneyTransferSuccess(
        paymentSuccess: paymentSuccess,
        isBillPayment: true,
      );
    } else {
      String message = snapshot.value["text"];
      String id = snapshot.value["senderId"];
      if (message?.isNotEmpty ?? false) {
        if (id == user.customerProfile.firebaseId) {
          return TextChatWidget(
            textMessage: message,
          );
        } else {
          return TextChatWidget(
            isReceivedMsg: true,
            textMessage: message,
          );
        }
      } else {
        return Container();
      }
    }
  }

  void showChatInboxWidgets() {
    if (isFromTaraOrder == false) {
      if (chatInboxInfoGlobal != null &&
          chatInboxInfoGlobal.chatCardTitle != null) {
        sendReceiveMoney = chatInboxInfoGlobal.chatAmount != null
            ? chatInboxInfoGlobal.chatAmount
            : "";
//        arrStr.add(chatInboxInfoGlobal.chatCardTitle);
      }
    }
  }

  void consumerAcceptDeclineOrderPayment(ChatAction chatAction) async {
    if (chatAction == ChatAction.pay) {
      // update Order with Pay Accepted
      customerOrder.status = Statuses.PAID;
      print(customerOrder.toJson().toString());
      var response = await controller.updateOrder(customerOrder);
      print("Order Status PAID and Updated");
    } else if (chatAction == ChatAction.decline) {
      // update Order with Pay Decline
      customerOrder.status = Statuses.ORDER_PAYMENT_DECLINED;
      print(customerOrder.toJson().toString());
      var response = await controller.updateOrder(customerOrder);
      print("Order Status ORDER_PAYMENT_DECLINED and Updated");
    }
  }

  void getChatStaticArr() {
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
  }

  TextMessage getChatMessage() {
    var textMessage = TextMessage();
    textMessage.type = "TEXT_BASED";
    textMessage.timestamp = DateTime.now();
    textMessage.senderId = user?.customerProfile?.firebaseId;
    textMessage.receiverId = widget.custInfo.firebaseId;
    textMessage.text = textEditingController.text;
    return textMessage;
  }

  Widget getChatInputWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 16, top: 10),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16, right: 8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.header_top_bar_color,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  child: IconButton(
                    icon: Icon(
                      isPlusClicked ? Icons.close : Icons.add,
                      color: Colors.white,
                    ),
                    color: AppColors.primaryText,
                    onPressed: () {
                      if (!isPlusClicked) {
                        setState(() {
                          isPlusClicked = true;
                          isToShowSendAndReceiveBottomSheet = false;
                        });
                      } else {
                        setState(() {
                          isPlusClicked = false;
                          isToShowSendAndReceiveBottomSheet = false;
                        });
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 8),
                            child: TextField(
                              style: TextStyle(
                                  color: AppColors.primaryText, fontSize: 15.0),
                              controller: textEditingController,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Write a message....',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                chatMsg = value.trim();
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 22,
                            ),
                            onPressed: () => {
                              if (chatMsg.isNotEmpty && chatMsg != '')
                                {
                                  getIt.get<FirebaseRemoteService>().setData(
                                      path: FirebasePath.getPath(
                                          user?.customerProfile?.firebaseId,
                                          widget.custInfo.firebaseId),
                                      data: getChatMessage().toJson()),
                                  setState(() {
                                    textEditingController.text = "";
                                    chatMsg = "";
                                  })
                                }
                              else
                                {
                                  setState(() {
                                    textEditingController.text = "";
                                    chatMsg = "";
                                  }),
                                }
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
        ),
        isPlusClicked ? getSendReceiveWidget() : Container()
      ],
    );
  }

  Widget getSendReceiveWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: Colors.grey[300], width: 0.5),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        children: [
          getRoundedButton(
            getTranslation(Strings.SEND),
            Color(0xffb2f7e2),
            AppColors.header_top_bar_color,
            Assets.SEND_ICON,
          ),
          getRoundedButton(getTranslation(Strings.RECEIVE), Color(0xffb2f7e2),
              AppColors.header_top_bar_color, Assets.RECEIVE_ICON),
        ],
      ),
    );
  }

  Widget getRoundedButton(
    String buttonText,
    Color buttonColor,
    Color imageColor,
    String image,
  ) {
    return InkWell(
      onTap: () {
        if (buttonText == getTranslation(Strings.RECEIVE)) {
          receiveBottomSheet();
        } else if (buttonText == getTranslation(Strings.SEND)) {
          sendBottomSheet();
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xffb2f7e2),
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 33,
                child: Image.asset(
                  image,
                  fit: BoxFit.none,
                  color: imageColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: 4),
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: BaseStyles.sendTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future receiveBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ReceiveWidget(
            customerProfile: widget.custInfo,
            receiveMoneyConfirmed: (amount) {
              setState(() {
                sendReceiveMoney = "";
                sendReceiveMoney = amount;
                arrStr.add("chat_request_cash_deposit");
                if (isPlusClicked == true) {
                  isPlusClicked = false;
                }
              });
            },
          );
        });
  }

  Future sendBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SendWidget(
            sendMoneyConfirmed: (amount) {
              setState(() {
                sendReceiveMoney = "";
                sendReceiveMoney = amount;
                arrStr.add("chat_money_transfer_success");
                if (isPlusClicked == true) {
                  isPlusClicked = false;
                }
              });
            },
          );
        });
  }

  Future showOrderTypeBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return bottomSheetWidget();
        });
  }

  Widget bottomSheetWidget() {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        child: Wrap(children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 53,
              height: 4,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: AppColors.light_grey_bg_color),
            ),
          ),
          Text(
              //getTranslation(Strings.addNewAccount),
              "Select Order Type",
              style: TextStyles.myAccountsCardTextStyle),
          Container(
            child: Column(
              children: [
                // getCardTextWidget(getTranslation(Strings.addDebitCard)).paddingOnly(top:10),
                getCardTextWidget("Text Based").paddingOnly(top: 10),
                getDivider(color: AppColors.light_grey_bg_color),
                // getCardTextWidget(getTranslation(Strings.addCreditCard)).paddingOnly(top:10),
                getCardTextWidget("Category Based").paddingOnly(top: 10),
              ],
            ),
          )
        ]));
  }

  Widget getCardTextWidget(String orderType) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Text(orderType, style: TextStyles.bottomSheetCardTextStyle),
          )
        ],
      ),
    ).onTap(onPressed: () {
      if (orderType == "Text Based") {
        Get.back();
        Get.to(MakeAnOrder(
          isFromShopHome: false,
          merchantStore: widget.merchantStore,
          merchantProfile: widget.custInfo,
        ));
      } else {
        Get.back();
        Get.to(ShoppingHomePage(
          merchantStore: widget.merchantStore,
          merchantProfile: widget.custInfo,
        ));
      }
    });
  }
}
