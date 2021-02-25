import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/firebase/firebase_remote_service.dart';
import 'package:tara_app/utils/chat_test.dart';

import '../../injector.dart';

class ChatInbox extends StatefulWidget {
  @override
  _ChatInboxState createState() => _ChatInboxState();
}

class _ChatInboxState extends BaseState<ChatInbox> {

  List<ChatInboxInfo> arrAllChats = [];
  List<ChatInboxInfo> arrMerchantChats = [];
  List<ChatInboxInfo> arrTaraUserChats = [];

  List<String> arrTaraUserTitle = ["Yakub Pasha", "Kiran"];
  List<String> arrTaraUserSubTitle = ["requested money","Rp.500.000 transferred"];
  List<String> arrTaraUserChatCard = ["chat_request_cash_deposit","chat_money_transfer_success"];
  List<String> arrTaraUserChatAmount = ["200","500"];

  List<String> arrMerchantTitle = ["Tara Orders"];
  List<String> arrMerchantSubTitle = ["1 Order"];
  List<String> arrMerchantChatCard = ["1 Order"];
  List<String> arrMerchantChatAmount = [""];

  List<String> arrAllChatTitle = ["Tara Orders","Tara Shop", "Tara Cash", "Yakub Pasha", "Kiran","Harish"];
  List<String> arrAllChatSubTitle = ["1 Order", "","Rp.100.000 tara cash received","requested money","Rp.500.000 transferred","Hi Harish"];
  List<String> arrAllChatCards= ["", "tara_shop_received_text","decline_pay","chat_request_cash_deposit","chat_money_transfer_success","Hi Harish"];
  List<String> arrAllChatChatAmount = ["","","100","200","500",""];

  @override
  BuildContext getContext() => context;

  @override
  void initState() {
    super.initState();
    loadData();
  }
  void loadData()
  {
    arrAllChats = [];
    arrMerchantChats = [];
    arrTaraUserChats = [];

    for (var i = 0; i < arrAllChatTitle.length; i++) {
      var chatInboxInfo = ChatInboxInfo();
      chatInboxInfo.chatTitle = arrAllChatTitle[i];
      chatInboxInfo.chatSubTitle = arrAllChatSubTitle[i];
      chatInboxInfo.chatCardTitle = arrAllChatCards[i];
      chatInboxInfo.chatAmount = arrAllChatChatAmount[i];
      arrAllChats.add(chatInboxInfo);
    }

    for (var i = 0; i < arrMerchantTitle.length; i++) {
      var chatInboxInfo = ChatInboxInfo();
      chatInboxInfo.chatTitle = arrMerchantTitle[i];
      chatInboxInfo.chatSubTitle = arrMerchantSubTitle[i];
      chatInboxInfo.chatCardTitle = arrMerchantChatCard[i];
      chatInboxInfo.chatAmount = arrMerchantChatAmount[i];
      arrMerchantChats.add(chatInboxInfo);
    }

    for (var i = 0; i < arrTaraUserTitle.length; i++) {
      var chatInboxInfo = ChatInboxInfo();
      chatInboxInfo.chatTitle = arrTaraUserTitle[i];
      chatInboxInfo.chatSubTitle = arrTaraUserSubTitle[i];
      chatInboxInfo.chatCardTitle = arrTaraUserChatCard[i];
      chatInboxInfo.chatAmount = arrTaraUserChatAmount[i];
      arrTaraUserChats.add(chatInboxInfo);
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: TabBarView(
            children: [
              getChatList(),
              // getChatListWidget(Strings.all_chats),
              getChatListWidget(Strings.tara_user),
              getChatListWidget(Strings.merchant),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "btn1",
            elevation: 0, highlightElevation: 0,
            child: Container(
              width: 60,
              height: 60,
              child: Container(
                padding: EdgeInsets.all(16),
               // child: SvgPicture.asset(Assets.CHAT_IN_ACTIVE,color: AppColors.header_top_bar_color,width: 24,height: 24,),
                child: getSvgImage(imagePath:Assets.assets_icon_c_chat_inactive,color: AppColors.header_top_bar_color,width: 24.0,height: 24.0,),

              ),
              decoration: BoxDecoration(
                gradient: Gradients.primaryGradient,
                shape: BoxShape.circle,
              ),
            ),
            onPressed: () {
//              push(ChatTest());
              push(ConversationPage());
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // hides leading widget
        title:Text(
          getTranslation(Strings.inbox),
          textAlign: TextAlign.center,
          style: BaseStyles.topBarTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 1.5,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: TabBar(
                  isScrollable: false,
                  unselectedLabelColor: Color(0xff889aac),
                  indicatorColor: AppColors.header_top_bar_color,
                  labelColor: AppColors.header_top_bar_color,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 4.0,
                  tabs: [
                    getTab(Strings.all_chats),
                    getTab(Strings.tara_user),
                    getTab(Strings.merchant)
                  ],
                  labelStyle: BaseStyles.chatInboxTabSelectedTextColor,
                  unselectedLabelStyle:BaseStyles.chatInboxTabUnSelectedTextColor
              ),
            ),
          ),
        )
    );
  }

  Widget getTab(String tabName) => Container(
    margin: EdgeInsets.only(top: 16,bottom: 8,),
    child: Text(
        getTranslation(tabName),
        textAlign: TextAlign.center
    ),
  );

  getChatListWidget(String tabTitle)
  {
    var length = (tabTitle == Strings.tara_user?arrTaraUserChats.length:tabTitle==Strings.merchant?arrMerchantChats.length:arrAllChats.length);
    return Container(
      margin: EdgeInsets.only(top: 8,bottom: 8),
      child: ListView.builder(
        padding:EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: length,
        itemBuilder: (context,index){
          if (tabTitle==Strings.tara_user)
          {
            return getChatItemWidget(arrTaraUserChats[index]);
          }
          else if (tabTitle==Strings.merchant)
          {
            return getChatItemWidget(arrMerchantChats[index]);
          }
          else{
            return getChatItemWidget(arrAllChats[index]);
          }
        },
      ),
    );
  }
  Future<CustomerProfile> getCustomerInfoByFirebaseId(path) async{
    var data = getChatTypeFirebaseId(path);
    if(data!=null){
         var resp = await getIt.get<AuthRepository>().getCustomerInfoByFirebaseId(data);
         if(resp.isRight()){
           return resp.getOrElse(() => null);
         }else{
           return null;
         }
    }
    else {
      var data = CustomerProfile(firstName: "Biller",firebaseId: "BillPayment");
      return Future.value(data);
    }
  }
  getChatTypeFirebaseId(String path){
    var destinationFirebaseId;
      var chatTypePath = path.split("/");
      if(chatTypePath.isNotEmpty && chatTypePath.length>1){
        if(chatTypePath[0] == "customer_bill_payment"){
          var userIds = chatTypePath[1].split("_");
        }else{
          var userIds = chatTypePath[1].split("_");
          destinationFirebaseId = "CID-"+userIds[0];

        }
      }
      return destinationFirebaseId;
  }
  getChatList(){
    AuthResponse user = Get.find<AuthController>().user.value;
    //add condition for customer and merchant separation
    var chatHistoryPath = FirebasePath.customerChats(user.customerProfile.firebaseId);
    print(chatHistoryPath);
    return Container(
      height: 500,
      child: new FirebaseAnimatedList(
          query: getIt.get<FirebaseRemoteService>().getDataStream(path:chatHistoryPath),
          padding: new EdgeInsets.all(8.0),
          reverse: false,
          itemBuilder: (_, DataSnapshot snapshot,
              Animation<double> animation, int x) {
            return FutureBuilder<CustomerProfile>(
                initialData: CustomerProfile(),
                future: getCustomerInfoByFirebaseId(snapshot.value.toString()),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListTile(
                      title: Text(snapshot.data?.firstName??""),
                      onTap: (){
                        Get.to(ConversationPage(isFromTaraOrder:false,selectedContact: ContactInfo(),custInfo: snapshot.data,));
                      },
                    );
                  }
                  return Container();


            });
          }
      ),
    );
  }
  getChatItemWidget(ChatInboxInfo chatInboxInfo)
  {
    return InkWell(
      onTap: (){
        if (chatInboxInfo.chatTitle!="Tara Shop"&&chatInboxInfo.chatTitle!="Tara Orders")
        {
          push(ConversationPage(chatInboxInfo: chatInboxInfo,));
        }else if(chatInboxInfo.chatTitle=="Tara Orders"){
          push(ConversationPage(chatInboxInfo: chatInboxInfo,isFromTaraOrder: true,));
        }else if (chatInboxInfo.chatTitle=="Tara Shop")
        {
          push(ConversationPage(chatInboxInfo: chatInboxInfo,));
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 16,left: 16,),
        padding: EdgeInsets.only(top: 4,bottom: 8),
        child:Center(
          child: Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child:Image.asset("assets/images/avatar-11.png",height: 32,width: 32,),)),
              Container(
                margin: EdgeInsets.only(left: 16),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    chatInboxInfo.chatSubTitle.isEmpty?Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          chatInboxInfo.chatTitle,
                          textAlign: TextAlign.left,
                          style: BaseStyles.chatTitleTextStyle,
                        ),
                      ),
                    ):Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        chatInboxInfo.chatTitle,
                        textAlign: TextAlign.left,
                        style: BaseStyles.chatTitleTextStyle,
                      ),
                    ),
                    chatInboxInfo.chatSubTitle.isNotEmpty?Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        chatInboxInfo.chatSubTitle,
                        textAlign: TextAlign.left,
                        style: BaseStyles.chatSubTitleTextStyle,
                      ),
                    ):Container(),
                  ],
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
  }
}