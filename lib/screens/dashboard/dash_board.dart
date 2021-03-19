import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/customer_orders_screen.dart';
import 'package:tara_app/screens/consumer/my_account/my_account.dart';
import 'package:tara_app/screens/consumer/my_account/myaccounts_see_all_screen.dart';
import 'package:tara_app/screens/consumer/transfer/bills_payment_soucres_screen.dart';
import 'package:tara_app/screens/dashboard/notification_settings.dart';
import 'package:tara_app/screens/dashboard/profile_edit.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/merchant/inventory/inventory_page.dart';
import 'package:tara_app/screens/signin_screen.dart';
import 'package:tara_app/screens/dashboard/my_orders_screen.dart';

import '../../flavors.dart';
import '../../flavors.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends BaseState<DashBoard> {
  AuthResponse user = Get.find<AuthController>().user.value;

  // in case of any tile addition on dashboard just add a new item here
  List<TileItem> dashBoardOptions = [
    TileItem(Strings.profile, Assets.assets_icon_p_profile, ProfileEdit()),
    TileItem(Strings.notification_settings, Assets.assets_icon_n_notification,
        ProfileEdit()),
    TileItem(Strings.MY_ACCOUNTS, Assets.assets_icon_a_accounts_active,
        ProfileEdit()),
    TileItem(Strings.my_orders, Assets.assets_icon_c_cart, ProfileEdit()),
    TileItem(Strings.help_support, Assets.assets_icon_h_help, ProfileEdit()),
  ];

  // List<String> dashBoardOptions = [
  //   Strings.profile,
  //   Strings.notification_settings,
  //   Strings.MY_ACCOUNTS,
  //   Strings.my_orders,
  //   Strings.help_support,
  // ];

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    //inventory should only be visible to merchant
    //TODO change the local version of "Inventory"
    if (F.appFlavor == Flavor.MERCHANT)
      dashBoardOptions.insert(3, TileItem("Inventory", Assets.assets_icon_b_box_active, InventoryPage()),);
  }

  @override
  void init() async {
    super.init();
    // var data = await getIt.get<UserLocalDataStore>().getUser();
    // user = data;
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            height: 216,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 140,
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
                      Center(
                        child: Container(
                          child: Text(
                            getTranslation(Strings.my_dashboard),
                            textAlign: TextAlign.center,
                            style: BaseStyles.topBarTextStyle,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 26,
                          ),
                          child: Container(
                            height: 120.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(Assets.ic_avatar_default),
                                  fit: BoxFit.cover,
                                )
                                // image: new Image.asset(_image.)
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Text(getTranslation(Strings.HELLO) + " 👋",
                        style: BaseStyles.alreadyHaveAccountTextStyle),
                  ),
                ),
                Center(
                  child: Container(
                    child: Obx(
                      () => Text(
                        Get.find<AuthController>()
                                .user
                                .value
                                ?.customerProfile
                                ?.firstName ??
                            "",
                        textAlign: TextAlign.center,
                        style: BaseStyles.bankAccountHeaderTitleStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dashBoardOptions.length,
                    itemBuilder: (context, index) {
                      return getCardWithTitle(dashBoardOptions[index]);
                    },
                  ),
                ),
                getLogOutWidget(),
              ],
            )),
          )
        ]),
      ),
    );
  }

  getCardWithTitle(TileItem item) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x24000000),
                  offset: Offset(0, 2),
                  blurRadius: 6,
                  spreadRadius: 0),
              BoxShadow(
                  color: const Color(0x14000000),
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 0)
            ],
            color: Colors.white),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  getSvgImage(
                      imagePath: item.icon,
                      color: item.title == Strings.my_orders
                          ? AppColors.color_black_100_2_2_2
                          : null),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text(getTranslation(item.title) ?? item.title,
                        style: BaseStyles.mobileNoTextStyle),
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey[300],
                size: 24,
              ),
            ],
          ),
        ),
      ),
    ).onTap(onPressed: () => Get.to(item.page));
  }

  getLogOutWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 24, top: 24, left: 16, right: 16),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xffb0b4c1)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.logout),
        textAlign: TextAlign.center,
        style: BaseStyles.logoutTextStyle,
      ),
    ).onTap(onPressed: () {
      //confirmation dailog
      getIt.get<UserLocalDataStore>().clear();
      Get.offAll(SignInScreen());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TileItem {
  final String title;
  final String icon;
  final Widget page;

  TileItem(this.title, this.icon, this.page);
}
