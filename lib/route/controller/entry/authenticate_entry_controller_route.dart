import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/entry/authenticate_entry_screen_route.dart';
import 'splash_entry_controller_route.dart';

class AuthenticateEntryControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: AuthenticateEntryScreenRoute(
        controller: AuthenticateEntryControllerRoute._(),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  AuthenticateEntryControllerRoute._();

  void onSignIn(final BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      await service.storage.keyValue.setAccessToken('access-token');
      SplashEntryControllerRoute.navigate(context);
    }
  }

  String? onValidateInput(final String? text) {
    if (text?.isEmpty ?? true) {
      return 'Please fill in this field';
    }

    return null;
  }
}