import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/transfer/beneficiaries_contacts_list_screen.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/firebase/firebase_remote_service.dart';

import '../../flavors.dart';
import '../../injector.dart';

class ChatInbox extends StatefulWidget {
  @override
  _ChatInboxState createState() => _ChatInboxState();
}

class _ChatInboxState extends BaseState<ChatInbox>
    with AutomaticKeepAliveClientMixin<ChatInbox> {
  @override
  BuildContext getContext() => context;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              getChatList(),
              getChatList(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "btn1",
            elevation: 0,
            highlightElevation: 0,
            child: Container(
              width: 60,
              height: 60,
              child: Container(
                padding: EdgeInsets.all(16),
                // child: SvgPicture.asset(Assets.CHAT_IN_ACTIVE,color: AppColors.header_top_bar_color,width: 24,height: 24,),
                child: getSvgImage(
                  imagePath: Assets.assets_icon_c_chat_inactive,
                  color: AppColors.header_top_bar_color,
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              decoration: BoxDecoration(
                gradient: Gradients.primaryGradient,
                shape: BoxShape.circle,
              ),
            ),
            onPressed: () {
              Get.to(BeneficiariesContactsListScreen(
                requestType: RequestType.CHAT,
              ));
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
        title: Text(
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
                  unselectedLabelStyle:
                      BaseStyles.chatInboxTabUnSelectedTextColor),
            ),
          ),
        ));
  }

  Widget getTab(String tabName) => Container(
        margin: EdgeInsets.only(
          top: 16,
          bottom: 8,
        ),
        child: Text(getTranslation(tabName), textAlign: TextAlign.center),
      );

  /*getChatListWidget(String tabTitle)
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
  }*/
  Future<CustomerProfile> getCustomerInfoByFirebaseId(path) async {
    var data = getChatTypeFirebaseId(path);
    if (data != null) {
      var resp =
          await getIt.get<AuthRepository>().getCustomerInfoByFirebaseId(data);
      if (resp.isRight()) {
        return resp.getOrElse(() => null);
      } else {
        return null;
      }
    } else {
      var data =
          CustomerProfile(firstName: "Biller", firebaseId: "BillPayment");
      return Future.value(data);
    }
  }

  getChatTypeFirebaseId(String path) {
    var destinationFirebaseId;
    var chatTypePath = path.split("/");
    if (chatTypePath.isNotEmpty && chatTypePath.length > 1) {
      if (chatTypePath[0] != "customer_bill_payment") {
        List<String> userIds = chatTypePath[1].split("_");
        var currentCustomerID = user.customerProfile.firebaseId.split("-")[1];
        userIds.remove(currentCustomerID);
        destinationFirebaseId = "CID-" + userIds[0];
      }
    }
    return destinationFirebaseId;
  }

  AuthResponse user;
  getChatList() {
    user = Get.find<AuthController>().user.value;
    //add condition for customer and merchant separation

    var chatHistoryPath;
    if(F.appFlavor == Flavor.CONSUMER) {
      chatHistoryPath =
          FirebasePath.customerChats(user.customerProfile.firebaseId);
    } else if(F.appFlavor == Flavor.MERCHANT){
      chatHistoryPath =
          FirebasePath.merchantChats(user.customerProfile.firebaseId);
    }

    print(chatHistoryPath);
    return Container(
      height: 500,
      child: FirebaseAnimatedList(
          query: getIt.get<FirebaseRemoteService>().getDataStream(path:chatHistoryPath),
          padding: EdgeInsets.all(8.0),
          reverse: false,
          itemBuilder:
              (_, DataSnapshot snapshot, Animation<double> animation, int x) {
            return FutureBuilder<CustomerProfile>(
                initialData: CustomerProfile(),
                future: getCustomerInfoByFirebaseId(snapshot.value.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getChatItemWidget(snapshot.data).onTap(
                        onPressed: () {
                      Get.to(ConversationPage(
                        isFromTaraOrder: false,
                        selectedContact: ContactInfo(),
                        custInfo: snapshot.data,
                      ));
                    });
                    // return ListTile(
                    //   title: Text(snapshot.data?.firstName??""),
                    //   onTap: (){
                    //
                    //   },
                    // );
                  }
                  return Container();
                });
          }),
    );
  }
  Widget getChatItemWidget(CustomerProfile customerProfile)
  {
    if(customerProfile==null) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(
        right: 16,
        left: 16,
      ),
      padding: EdgeInsets.only(top: 4, bottom: 8),
      child: Center(
        child: Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    // child:getSvgImage(imagePath: "assets/images/icon_tara_customer_default_profile_picture.svg",width: 32.0,height:32.0))),
                    child: BaseWidgets.bigCircle(
                        customerProfile.firstName ?? ""))),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        customerProfile?.firstName ?? "",
                        textAlign: TextAlign.left,
                        style: BaseStyles.chatTitleTextStyle,
                      ),
                    ),
                  ),
                  customerProfile?.mobileNumber?.isNotEmpty ?? false
                      ? Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            customerProfile.mobileNumber,
                            textAlign: TextAlign.left,
                            style: BaseStyles.chatSubTitleTextStyle,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
