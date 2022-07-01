import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/entry/splash_entry_screen_route.dart';
import '../dashboard_controller_route.dart';
import 'landing_entry_controller_route.dart';

class SplashEntryControllerRoute {
  static Widget screen() {
    return const SplashEntryScreenRoute(
      controller: SplashEntryControllerRoute._(),
    );
  }

  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: screen(),
    );
  }

  const SplashEntryControllerRoute._();

  void onInitialise(final BuildContext context) {
    if (service.storage.keyValue.accessToken.isEmpty) {
      LandingEntryControllerRoute.navigate(context);
    } else {
      DashboardControllerRoute.navigate(context);
    }
  }
}
