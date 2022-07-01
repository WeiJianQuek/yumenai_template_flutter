import 'package:flutter/material.dart';

import '../../utility/navigator_utility.dart';
import '../screen/dashboard_screen_route.dart';
import 'dashboard/setting_dashboard_controller_route.dart';

class DashboardControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const DashboardScreenRoute(
        controller: DashboardControllerRoute._(),
      ),
    );
  }

  const DashboardControllerRoute._();

  void navigateSettings(final BuildContext context) async {
    SettingDashboardControllerRoute.navigate(context);
  }
}
