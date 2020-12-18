import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_item_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_order_detail.dart';
import 'package:tara_app/common/widgets/chat_widgets/decline_pay_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/items_order_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/make_an_order_chat.dart';
import 'package:tara_app/common/widgets/chat_widgets/order_details_decline_pay.dart';
import 'package:tara_app/common/widgets/chat_widgets/order_paid.dart';
import 'package:tara_app/common/widgets/chat_widgets/text_chat_widget.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/chat/message_type.dart';
import 'package:tara_app/models/chat/order.dart';
import 'package:tara_app/models/chat/text_message.dart';
import 'package:tara_app/models/order_management/orders/order_status.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/receive_money.dart';
import 'package:tara_app/screens/chat/send_money.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/shop/make_an_order.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/firebase_remote_service.dart';

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
  CustomerProfile custInfo;
  final Store merchantStore;
  final FromScreen fromScreen;

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
      this.fromScreen = FromScreen.consumer})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends BaseState<ConversationPage> {
  final ScrollController listScrollController = new ScrollController();
  List<String> arrStr = [];
  TextEditingController textEditingController = TextEditingController();
  bool isPlusClicked = false;
  String chatMsg = "";
  bool isToShowSendAndReceiveBottomSheet = true;
  String sendReceiveMoney = "100";
  bool isSendReceiveConfirmed = false;
  ChatInboxInfo chatInboxInfoGlobal;
  bool isFromTaraOrder = false;
  AuthResponse user;// = Get.find();
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
  }

  @override
  void initState() {
    super.initState();
    chatInboxInfoGlobal = widget.chatInboxInfo;
    isFromTaraOrder = widget.isFromTaraOrder;
    // getChatStaticArr();
    showChatInboxWidgets();
    if (widget.arrChats != null && widget.arrChats.length != 0) {
      arrStr = widget.arrChats;
    }
  }

//  @override
//  void init() {
//    // TODO: implement init
//    super.init();
//    setState(() {
//
//      arrStr = widget.arrChats;
//    });

//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              widget.fromScreen == FromScreen.consumer
                  ? Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          bottom: 76,
                          width: MediaQuery.of(context).size.width,
                          child: MakeAnOrderChat(
                            onSelectOption: (val) {
                              push(MakeAnOrder(
                                isFromShopHome: false,
                                merchantStore: widget.merchantStore,
                                merchantProfile: widget.custInfo,
                              ));
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
            ])));
  }

  showReceiveOrSendBottomSheet() {
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

  showCashDepositBottomSheet() {
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

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: Visibility(
        visible: widget.canGoBack,
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.isFromShopHome == true) {
                widget.callback();
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

  getAppBarTitle() {
    return Text(
      getTranslation(Strings.TARA_CASH_DEPOSIT),
      textAlign: TextAlign.left,
      style: BaseStyles.topBarTextStyle,
    );
  }

  getAvatarWithName() {
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
                    (widget.selectedContact != null &&
                            widget.selectedContact.name != null)
                        ? widget.selectedContact.name
                        : (chatInboxInfoGlobal != null &&
                                chatInboxInfoGlobal.chatTitle != null)
                            ? chatInboxInfoGlobal.chatTitle
                            : widget.custInfo.firstName,
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
                      decoration: new BoxDecoration(
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

  getChatListView() {
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
    return new FirebaseAnimatedList(
        query: getIt.get<FirebaseRemoteService>().getDataStream(
            path: FirebasePath.getPath(
                user?.customerProfile?.firebaseId, widget.custInfo.firebaseId)),
        padding:
            new EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 120.0),
        reverse: false,
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int x) {
          return loadChatWidget(snapshot);
        });
  }

  Widget loadChatWidget(DataSnapshot snapshot) {
    print(snapshot.value.toString());
    String chatType = snapshot.value["messageType"];
    if (chatType == describeEnum(MessageType.ORDER)) {
      Order order = Order.fromSnapshot(snapshot);
      if (widget.fromScreen == FromScreen.merchant) {
        if (order.orderStatus == describeEnum(Statuses.PENDING))
          return ItemsOrder(
            fromScreen: FromScreen.merchant,
            order: order,
          );
        else if (order.orderStatus == describeEnum(Statuses.ACCEPTED)) {
          // "You have accepted the order."
          return ItemsOrder(
            isFromAcceptedOrder: true,
            fromScreen: FromScreen.merchant,
            order: order,
            onTapAction: () {},
          );
        } else if (order.orderStatus == describeEnum(Statuses.CANCELLED)) {
//          "You have canceled the order"
          return ItemsOrder(
            isFromCancelledOrder: true,
            order: order,
            fromScreen: FromScreen.merchant,
            onTapAction: () {},
          );
        } else if (order.orderStatus ==
            describeEnum(Statuses.ORDER_PAYMENT_DECLINED)) {
          //"Payment Declined By the User"
          return DeclinePay(
            isSender: false,
            isDeclined: true,
            onTapAction: () {},
          );
        } else if (order.orderStatus == describeEnum(Statuses.IN_TRANSIT)) {
          //"payment paid By the User"
          return ChatOrderDetail(
            onTapAction: () {},
          );
        } else if (order.orderStatus == describeEnum(Statuses.PAID)) {
          //"payment paid By the User"
          return ChatOrderPaid();
        } else if (order.orderStatus == describeEnum(Statuses.DELIVERED)) {
          //"payment paid By the User"
          return ChatOrderPaid(
            isFromOrderDelivered: true,
          );
        }
      } else if (widget.fromScreen == FromScreen.consumer) {
        if (order.orderStatus == describeEnum(Statuses.PENDING))
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
        else if (order.orderStatus == describeEnum(Statuses.ACCEPTED)) {
          //return Pay and Decline Widget Here (i.e "Order confirmed by the Store")
          return OrderDetailsDeclinePay(
            order: order,
            onTapAction: (btn) {
              if (btn == "Decline") {
              } else if (btn == "Decline") {}
            },
          );
        } else if (order.orderStatus == describeEnum(Statuses.CANCELLED)) {
          //          "Ordered declined by the Store"
          return ItemsOrder(
            isFromCancelledOrderByStore: true,
            order: order,
            onTapAction: () {},
          );
        } else if (order.orderStatus ==
            describeEnum(Statuses.ORDER_PAYMENT_DECLINED)) {
          //update the txt on Pay and decline widget, button should be replaced with text (i.e "You have declined the payment")
          //"Payment Declined By the User"
          return DeclinePay(
            isSender: true,
            isDeclined: true,
            onTapAction: () {},
          );
        } else if (order.orderStatus == describeEnum(Statuses.PAID)) {
          //"payment paid By the User"
          return ChatOrderPaid();
        }
      } else {
        return Container();
      }
    } else {
      String message = snapshot.value["text"];
      String id = snapshot.value["senderId"];
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
    }
  }

  showChatInboxWidgets() {
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

  getChatStaticArr() {
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

  getChatInputWidget() {
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
                decoration: new BoxDecoration(
                  color: AppColors.header_top_bar_color,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  child: IconButton(
                    icon: new Icon(
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

  getSendReceiveWidget() {
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

  getRoundedButton(
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
              decoration: new BoxDecoration(
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
}
