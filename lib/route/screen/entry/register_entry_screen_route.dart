import 'package:flutter/material.dart';

import '../../../component/button/submit_button_component.dart';
import '../../../component/text/input_text_component.dart';
import '../../../view/template/screen_template_view.dart';
import '../../controller/entry/register_entry_controller_route.dart';

class RegisterEntryScreenRoute extends StatelessWidget {
  final RegisterEntryControllerRoute controller;

  const RegisterEntryScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView.avatar(
      title: 'Sign Up',
      subtitle: 'Yumenai',
      enableReversalTagText: true,
      form: Form(
        key: controller.formKey,
        child: Column(
          children: [
            InputTextComponent(
              controller: controller.idInputController,
              label: 'ID',
              style: InputTextStyle.outline,
              onValidate: controller.onValidateInput,
            ),
            InputTextComponent.name(
              controller: controller.nameInputController,
              label: 'Name',
              style: InputTextStyle.outline,
              onValidate: controller.onValidateInput,
            ),
            InputTextComponent.email(
              controller: controller.emailInputController,
              label: 'Email',
              style: InputTextStyle.outline,
              onValidate: controller.onValidateInput,
            ),
            InputTextComponent.secure(
              controller: controller.passwordInputController,
              label: 'Password',
              style: InputTextStyle.outline,
              onValidate: controller.onValidateInput,
            ),
            InputTextComponent.secure(
              controller: controller.confirmPasswordInputController,
              label: 'Confirm Password',
              style: InputTextStyle.outline,
              onValidate: controller.onValidateInput,
            ),
          ],
        ),
      ),
      actionPrimary: SubmitButtonComponent(
        title: 'Sign Up',
        onClicked: () {
          controller.onSignUp(context);
        },
      ),
    );
  }
}
