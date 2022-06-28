import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import '../../screen/entry/landing_entry_screen_route.dart';
import 'authenticate_entry_controller_route.dart';
import 'register_entry_controller_route.dart';

class LandingEntryControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const LandingEntryScreenRoute(
        controller: LandingEntryControllerRoute._(),
      ),
    );
  }

  const LandingEntryControllerRoute._();

  void onSignIn(final BuildContext context) {
    AuthenticateEntryControllerRoute.navigate(context);
  }

  void onSignUp(final BuildContext context) {
    RegisterEntryControllerRoute.navigate(context);
  }
}