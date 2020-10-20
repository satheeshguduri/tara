import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/chat_widgets/chat_item_widget.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_inbox.dart';
import 'package:tara_app/screens/chat/receive_money.dart';
import 'package:tara_app/screens/chat/send_money.dart';
import 'package:tara_app/screens/consumer/Data.dart';

class ConversationPage extends StatefulWidget {

  final bool canGoBack;
  final bool isFromSend;
  final bool isFromReceive;
  final ContactInfo selectedContact;
  final ChatInboxInfo chatInboxInfo;
  final bool isFromTaraOrder;
  final List<String> arrChats;

  ConversationPage({this.canGoBack = true,this.isFromSend=false,this.isFromReceive=false,this.selectedContact,
    this.chatInboxInfo,this.isFromTaraOrder=false,Key key,this.arrChats}):super(key:key);

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

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    super.initState();
    chatInboxInfoGlobal = widget.chatInboxInfo;
    isFromTaraOrder = widget.isFromTaraOrder;
    // getChatStaticArr();
    showChatInboxWidgets();
    if(widget.arrChats != null && widget.arrChats.length != 0){
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
            (!widget.isFromSend&&!widget.isFromReceive)?Container():(isToShowSendAndReceiveBottomSheet?showReceiveOrSendBottomSheet():Container()),
              isFromTaraOrder==true?showCashDepositBottomSheet():Container()
            ]
            )
        )
    );
  }




  showReceiveOrSendBottomSheet()
  {
    Timer(Duration(milliseconds: 2), () {
      if(widget.isFromSend==true)
      {
        isToShowSendAndReceiveBottomSheet = false;
        sendBottomSheet();
      }
      else if(widget.isFromReceive==true)
      {
        isToShowSendAndReceiveBottomSheet = false;
        receiveBottomSheet();
      }
    });
    return Container();
  }

  showCashDepositBottomSheet()
  {
    Timer(Duration(milliseconds: 2), () {
      if (widget.isFromTaraOrder==true)
      {
        cashDepositBottomSheet(widget.chatInboxInfo);
      }
    });
    return Container();
  }

  Future  cashDepositBottomSheet(ChatInboxInfo chatInboxInfo) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return CashDepositWidget(chatInboxInfo: chatInboxInfo,chatInboxInfoCallBack: (chatInfo){
            setState(() {
              chatInboxInfoGlobal = chatInfo;
              isFromTaraOrder = false;
              showChatInboxWidgets();
            });
          },);
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
                Navigator.pop(context, false);
            }
        ),
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: getAvatarWithName(),
      ),
    );
  }

  getAppBarTitle()
  {
    return Text(
      getTranslation(Strings.TARA_CASH_DEPOSIT),
      textAlign: TextAlign.left,
      style: BaseStyles.topBarTextStyle,
    );
  }

  getAvatarWithName()
  {
    return Container(
      child: Row(
        children: [
          Image.asset("assets/images/avatar-11.png",height: 32,width: 32,),
          Container(
            margin: EdgeInsets.only(left: 16),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    (widget.selectedContact!=null&&widget.selectedContact.name!=null)?widget.selectedContact.name:
                    (chatInboxInfoGlobal!=null&&chatInboxInfoGlobal.chatTitle!=null)?chatInboxInfoGlobal.chatTitle:"Tania Salsabila",
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
                          color:Color(0xffb2f7e2),
                          shape: BoxShape.circle,
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4,left: 4),
                      child: Text(
                        "Online",
                        textAlign: TextAlign.left,
                        style: BaseStyles.enterMPINTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            ) ,
          ),
        ],
      ),
    );
  }

  getChatListView()
  {
    // TODO: implement build
    return Container(height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 60),
          itemBuilder: (context, index) => ChatItemWidget(index,arrStr[index],sendReceiveMoney,
              (val){
            print(val);
            if(val == "decline"){
              setState(() {
                arrStr.add("decline_pay_isSender_declined_true");
              });
            }
          }),
          itemCount: (arrStr!=null&&arrStr.length>0)?arrStr.length:0,
          reverse: false,
          controller: listScrollController,
        ));
  }


  showChatInboxWidgets()
  {
    if (isFromTaraOrder==false){
      if (chatInboxInfoGlobal!=null&&chatInboxInfoGlobal.chatCardTitle!=null)
      {
        sendReceiveMoney = chatInboxInfoGlobal.chatAmount!=null?chatInboxInfoGlobal.chatAmount:"";
        arrStr.add(chatInboxInfoGlobal.chatCardTitle);
      }
    }
  }

 getChatStaticArr()
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
  }

  getChatInputWidget()
  {
    return Column(
      children: [
        Container(
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
                      isPlusClicked?Icons.close:Icons.add,
                      color: Colors.white,
                    ),
                    color: AppColors.primaryText,
                    onPressed: (){
                      if (!isPlusClicked){
                        setState(() {
                          isPlusClicked = true;
                          isToShowSendAndReceiveBottomSheet = false;
                        });
                      }
                      else{
                        setState(() {
                          isPlusClicked = false;
                          isToShowSendAndReceiveBottomSheet = false;
                        });
                      }
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
                              onChanged: (value){
                                chatMsg = value.trim();
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.send,size: 22,),
                            onPressed: () => {
                              if (chatMsg.isNotEmpty&&chatMsg != '')
                                {
                                  setState(() {
                                    arrStr.add(chatMsg);
                                    textEditingController.text = "";
                                    chatMsg = "";
                                  }),
                                  listScrollController.animateTo(
                                    listScrollController.position.maxScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  )
                                }else{
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
        isPlusClicked?getSendReceiveWidget():Container()
      ],
    );
  }

  getSendReceiveWidget()
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(
            color: Colors.grey[300],
            width: 0.5
        ),
      ),
      padding: EdgeInsets.only(left:16,right: 16,top: 8),
      child: Row(
        children: [
          getRoundedButton(getTranslation(Strings.SEND),Color(0xffb2f7e2),AppColors.header_top_bar_color,Assets.SEND_ICON,),
          getRoundedButton(getTranslation(Strings.RECEIVE),Color(0xffb2f7e2),AppColors.header_top_bar_color, Assets.RECEIVE_ICON),
        ],
      ),
    );
  }


  getRoundedButton(String buttonText, Color buttonColor, Color imageColor, String image,)
  {
    return InkWell(
      onTap: (){
        if (buttonText == getTranslation(Strings.RECEIVE))
        {
          receiveBottomSheet();
        }else if (buttonText == getTranslation(Strings.SEND))
        {
          sendBottomSheet();
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8,right: 8),
              height: 56,
              decoration: new BoxDecoration(
                color: Color(0xffb2f7e2),
                shape: BoxShape.circle,
              ),
              child:Container(
                height: 33,
                child: Image.asset(
                  image,
                  fit: BoxFit.none,
                  color:imageColor,
                ),
              ),),
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
          return ReceiveWidget(receiveMoneyConfirmed:(amount){
            setState(() {
              sendReceiveMoney = "";
              sendReceiveMoney = amount;
              arrStr.add("chat_request_cash_deposit");
              if (isPlusClicked == true)
              {
                isPlusClicked = false;
              }
            });
          },);
        });
  }

  Future sendBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SendWidget(sendMoneyConfirmed: (amount){
            setState(() {
              sendReceiveMoney = "";
              sendReceiveMoney = amount;
              arrStr.add("chat_money_transfer_success");
              if (isPlusClicked == true)
              {
                isPlusClicked = false;
              }
            });
          },);
        });
  }

}