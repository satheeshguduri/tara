import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      appBar: CustomAppBarWidget(
          title: getTranslation(Strings.settings), addNewWidgetShow: false),
      body: Column(
        children: [
          //? Account Settings
          buildListTile(
            onTap: () {},
            leadingIconPath: Assets.assets_icon_p_profile,
            title: Strings.ACCOUNT_SETTINGS,
            trailingIconPath: Assets.assets_icon_a_arrow_right,
          ),
          getDivider(color: AppColors.light_grey_bg_color),
          //? Notification Settings
          buildListTile(
            onTap: () {},
            leadingIconPath: Assets.assets_icon_n_notification,
            title: Strings.notification_settings,
            trailingIconPath: Assets.assets_icon_a_arrow_right,
          ),
          getDivider(color: AppColors.light_grey_bg_color),
          //? Help & Support
          buildListTile(
            onTap: () {},
            leadingIconPath: Assets.assets_icon_h_help,
            title: Strings.help_support,
            trailingIconPath: Assets.assets_icon_a_arrow_right,
          ),
          getDivider(color: AppColors.light_grey_bg_color),
          //? Terms & Condition
          buildListTile(
            onTap: () {},
            leadingIconPath: Assets.assets_icon_p_paper,
            title: Strings.terms_condition,
            trailingIconPath: Assets.assets_icon_a_arrow_right,
          ),
          getDivider(color: AppColors.light_grey_bg_color),
          //? Privacy Policy
          buildListTile(
            onTap: () {},
            leadingIconPath: Assets.assets_icon_l_lock_outline,
            title: Strings.privacy_policy,
            trailingIconPath: Assets.assets_icon_a_arrow_right,
          ),
          getDivider(color: AppColors.light_grey_bg_color),
        ],
      ),
    );
  }

  ListTile buildListTile(
      {Function onTap,
      String leadingIconPath,
      String title,
      String trailingIconPath}) {
    return ListTile(
      onTap: onTap,
      leading: getSvgImage(
        imagePath: leadingIconPath,
        width: 24.0,
        height: 24.0,
      ),
      title: Text(getTranslation(title), style: TextStyles.body2222),
      trailing: getSvgImage(
        imagePath: trailingIconPath,
        width: 16.0,
        height: 16.0,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      title: Text(
        getTranslation(Strings.settings),
        textAlign: TextAlign.left,
        style: BaseStyles.topBarTextStyle,
      ),
    );
  }

  @override
  BuildContext getContext() => context;
}
