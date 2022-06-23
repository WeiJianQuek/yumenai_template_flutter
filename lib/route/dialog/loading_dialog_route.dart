import 'package:flutter/material.dart';

import '../../utility/navigator_utility.dart';
import '../../view/template/dialog_template_view.dart';

class LoadingDialogRoute {
  static void show(final BuildContext context, {
    final String? title,
    final String? message,
  }) {
    NavigatorUtility.dialog.showPopup(
      context,
      widget: DialogTemplateView(
        title: '${title ?? 'Loading'}...',
        message: message,
        layout: const LinearProgressIndicator(),
      ),
    );
  }

  const LoadingDialogRoute._();
}