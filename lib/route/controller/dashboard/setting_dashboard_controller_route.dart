import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/dashboard/setting_dashboard_screen_route.dart';
import '../setting/language_setting_controller_route.dart';
import '../setting/theme_setting_controller_route.dart';

class SettingDashboardControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const SettingDashboardScreenRoute(
        controller: SettingDashboardControllerRoute._(),
      ),
    );
  }

  const SettingDashboardControllerRoute._();

  ThemeMode get appThemeMode {
    return app.themeMode;
  }

  void navigateProfile(final BuildContext context) {}

  void navigatePassword(final BuildContext context) {}

  void navigateLanguage(final BuildContext context) {
    LanguageSettingControllerRoute.navigate(context);
  }

  void navigateTheme(final BuildContext context) {
    ThemeSettingControllerRoute.navigate(context);
  }

  void navigateSignOut(final BuildContext context) {
    app.signOut(context);
  }
}