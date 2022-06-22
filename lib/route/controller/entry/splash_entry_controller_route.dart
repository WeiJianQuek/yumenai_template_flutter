import 'package:flutter/material.dart';
import 'package:template/route/controller/entry/landing_entry_controller_route.dart';

import '../../../utility/navigator_utility.dart';
import '../../screen/entry/splash_entry_screen_route.dart';

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
    LandingEntryControllerRoute.navigate(context);
  }
}