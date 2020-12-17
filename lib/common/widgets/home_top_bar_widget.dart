import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/rounded_button.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/shop/shop_home.dart';
import 'package:tara_app/screens/create_account_screen.dart';
import 'package:tara_app/screens/dashboard/profile_edit.dart';
import 'package:tara_app/screens/notification_screen.dart';

class HomeTopBar extends StatefulWidget {
  final String appName;
  HomeTopBar({Key key, this.appName = ""}) : super(key: key);

  @override
  _HomeTopBarState createState() => _HomeTopBarState();
}

class _HomeTopBarState extends BaseState<HomeTopBar> {
  AuthResponse user = Get.find();
  var userName = "";

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                  gradient: Gradients.primaryGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(16.0),
                    bottomRight: const Radius.circular(16.0),
                  )),
              child: Container(),
            ),
          ),
          Positioned(
            left: 0,
            top: 35,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 56,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: showLogoAndTitle()),
                      nameNotificationsAndImage()
                    ],
                  ),
                ),
                getSearchWidget(),
                Container(
                  height: 8,
                ),
                getTopOptions()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getTopOptions() {
    if (widget.appName == "Merchant") {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              buttonText: getTranslation(Strings.SEND),
              image: Assets.SEND_ICON,
              onPressed: () {
                push(CashDepositSelectContact(
                  isFromSend: true,
                ));
              },
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.RECEIVE),
              image: Assets.RECEIVE_ICON,
              onPressed: () {
                push(CashDepositSelectContact(
                  isFromReceive: true,
                ));
              },
            ),
            RoundedButton(
                buttonText: getTranslation(Strings.CASH_DEPOSIT),
                image: Assets.ic_cash_deposit,
                onPressed: () {
                  var chatInboxInfo = ChatInboxInfo();
                  chatInboxInfo.chatTitle =
                      getTranslation(Strings.CASH_DEPOSIT);
                  chatInboxInfo.chatCardTitle = "chat_request_cash_deposit";
                  push(ConversationPage(
                      chatInboxInfo: chatInboxInfo, isFromTaraOrder: true));
                }),
            RoundedButton(
              buttonText: getTranslation(Strings.RESTOCK),
              image: Assets.ic_restock,
            ),
          ],
        ),
      );
    } else if (widget.appName == "Agent") {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              buttonText: getTranslation(Strings.SEND),
              image: Assets.SEND_ICON,
              onPressed: () {
                push(CashDepositSelectContact(
                  isFromSend: true,
                ));
              },
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.RECEIVE),
              image: Assets.RECEIVE_ICON,
              onPressed: () {
                push(CashDepositSelectContact(
                  isFromReceive: true,
                ));
              },
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.PAYMENT),
              image: Assets.ic_payment,
              onPressed: () {},
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.CMS_TOP_UP),
              image: Assets.ic_topup,
              onPressed: () {},
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              buttonText: getTranslation(Strings.transfer),
              image: Assets.SEND_ICON,
              onPressed: () {
                push(CashDepositSelectContact(
                  isFromSend: true,
                ));
              },
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.request),
              image: Assets.RECEIVE_ICON,
              onPressed: () {
                push(CashDepositSelectContact(
                  isFromReceive: true,
                ));
              },
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.bills),
              image: Assets.ic_payment,
              onPressed: () {},
            ),
            RoundedButton(
              buttonText: getTranslation(Strings.purchase),
              image: Assets.SHOP_ICON,
              onPressed: () {
                var chatInboxInfo = ChatInboxInfo();
                chatInboxInfo.chatTitle = getTranslation(Strings.SHOP);
                chatInboxInfo.chatCardTitle = "tara_shop_received_text";
//              push(ConversationPage(chatInboxInfo: chatInboxInfo,));
                push(ShopHome());
              },
            ),
          ],
        ),
      );
    }
  }

  Widget getSearchWidget() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
      decoration: BoxDecoration(
        color: Color.fromARGB(179, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.only(left: 8),
            child: getTabImage(Assets.SEARCH_ICON),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              "Try typing action, contact or merchant...",
              textAlign: TextAlign.left,
              style: BaseStyles.searchBarTextStyle,
            ),
          ),
        ],
      ),
    ).onTap(onPressed: () => Get.to(CashDepositSelectContact()));
  }

  Widget showLogoAndTitle() {
    return Row(
      children: [
        Container(
          width: 62,
          height: 24,
          margin: EdgeInsets.only(top: 8),
          child: Image.asset(
            "assets/images/combined-shape-5.png",
            fit: BoxFit.none,
          ),
        ),
        Flexible(
          child: Text(widget.appName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                  color: AppColors.fareColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "PlayfairDisplay",
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0)),
        )
      ],
    );
  }

  Widget nameNotificationsAndImage() {

    if (user?.customerProfile?.firstName != null) {
      userName = user?.customerProfile?.firstName;
    } else if (user?.customerProfile?.lastName != null) {
      userName = user?.customerProfile?.lastName;
    }
    return Row(
      children: [
        Container(
          width: 150,
          height: 38,
          margin: EdgeInsets.only(top: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Hello",
                  textAlign: TextAlign.right,
                  style: BaseStyles.navigationTextStyle,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  userName != "" ? userName : "Customer Name",
                  textAlign: TextAlign.right,
                  style: BaseStyles.nameTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 29,
              height: 29,
              margin: EdgeInsets.only(right: 4),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Positioned(
                    right: 4,
                    child: Image.asset(
                      Assets.NOTIFICATION_ICON,
                      fit: BoxFit.none,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.badge_color,
                        borderRadius: Radii.border(7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: BaseStyles.notificationBadgeTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).onTap(onPressed: () => Get.to(NotificationScreen())),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 32,
                height: 32,
                // margin: EdgeInsets.only(right: 16),
                child: Image.asset(
                  Assets.PERSON_ICON,
                  fit: BoxFit.none,
                ),
              ).onTap(onPressed: () => (userName != "")?Get.to(ProfileEdit(isFromHomeTopBar:true)):Get.to(CreateAccountScreen())),
            )
          ],
        )
      ],
    );
  }
}
