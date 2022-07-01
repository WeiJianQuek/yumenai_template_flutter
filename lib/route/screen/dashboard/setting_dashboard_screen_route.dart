import 'package:flutter/material.dart';

import '../../../component/view/list_view_component.dart';
import '../../../main.dart';
import '../../../view/item/action_item_view.dart';
import '../../../view/template/screen_template_view.dart';
import '../../controller/dashboard/setting_dashboard_controller_route.dart';

class SettingDashboardScreenRoute extends StatelessWidget {
  final SettingDashboardControllerRoute controller;

  const SettingDashboardScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      titleText: 'Settings',
      layout: ListViewComponent(
        viewList: [
          ActionItemView(
            title: 'Profile',
            icon: const Icon(Icons.person),
            onClicked: () {
              controller.navigateProfile(context);
            },
          ),
          ActionItemView(
            title: 'Password',
            icon: const Icon(Icons.vpn_key),
            onClicked: () {
              controller.navigatePassword(context);
            },
          ),
          ActionItemView(
            title: 'Language',
            content: getLanguageContent(context),
            icon: const Icon(Icons.language_rounded),
            onClicked: () {
              controller.navigateLanguage(context);
            },
          ),
          ActionItemView(
            title: 'Theme',
            content: getThemeContent(context),
            icon: const Icon(Icons.color_lens_rounded),
            onClicked: () {
              controller.navigateTheme(context);
            },
          ),
          ActionItemView(
            title: 'Sign Out',
            icon: const Icon(Icons.exit_to_app),
            color: resource.color.error,
            onClicked: () {
              controller.navigateSignOut(context);
            },
          ),
        ],
      ),
    );
  }

  String getLanguageContent(final BuildContext context) {
    return 'English';
  }

  String getThemeContent(final BuildContext context) {
    switch(controller.appThemeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
