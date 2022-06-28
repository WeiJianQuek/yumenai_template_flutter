import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import '../../screen/entry/register_entry_screen_route.dart';

class RegisterEntryControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: RegisterEntryScreenRoute(
        controller: RegisterEntryControllerRoute._(),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  RegisterEntryControllerRoute._();

  void onSignUp(final BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {

    }
  }

  String? onValidateInput(final String? text) {
    if (text?.isEmpty ?? true) {
      return 'Please fill in this field';
    }

    return null;
  }
}