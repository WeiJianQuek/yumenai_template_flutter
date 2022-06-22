import 'package:flutter/material.dart';

import '../../../component/button/submit_button_component.dart';
import '../../../view/template/screen_template_view.dart';
import '../../controller/entry/landing_entry_controller_route.dart';

class LandingEntryScreenRoute extends StatelessWidget {
  final LandingEntryControllerRoute controller;

  const LandingEntryScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView.avatar(
      title: 'Yumenai',
      actionPrimary: SubmitButtonComponent(
        title: 'Sign In',
        onClicked: () {
          controller.onSignIn(context);
        },
      ),
      actionSecondary: SubmitButtonComponent.secondary(
        title: 'Sign Up',
        onClicked: () {
          controller.onSignUp(context);
        },
      ),
    );
  }
}
