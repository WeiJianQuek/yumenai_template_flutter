import 'package:flutter/material.dart';

import '../../utility/navigator_utility.dart';
import '../screen/dashboard_screen_route.dart';

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
}
