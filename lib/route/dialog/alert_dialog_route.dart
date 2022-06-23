import 'package:flutter/material.dart';

import '../../component/button/dialog_button_component.dart';
import '../../utility/navigator_utility.dart';
import '../../view/template/dialog_template_view.dart';

class AlertDialogRoute {
  static Future<dynamic> show(final BuildContext context, {
    required final String? title,
    final String? message,
    final Widget? layout,
  }) {
    return NavigatorUtility.dialog.showPopup(
      context,
      widget: DialogTemplateView(
        title: title,
        message: message,
        layout: layout,
        positiveButton: DialogButtonComponent.positive(
          title: 'Ok',
          onClicked: (context) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static Future<dynamic> showError(final BuildContext context, {
    final String? title,
    final String? message,
    final Widget? layout,
  }) {
    final foregroundColor =  Theme.of(context).colorScheme.onError;
    final backgroundColor =  Theme.of(context).colorScheme.error;

    return NavigatorUtility.dialog.showPopup(
      context,
      widget: DialogTemplateView(
        title: title ?? 'Error',
        titleColor: backgroundColor,
        message: message ?? 'Something unexpected happened. Please try again.',
        layout: layout,
        positiveButton: DialogButtonComponent.positive(
          title: 'Ok',
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          onClicked: (context) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static Future<dynamic> showConfirm(final BuildContext context, {
    required final String? title,
    final String? message,
    final Widget? layout,
    final String? positiveText,
    final String? negativeText,
    final Future<bool> Function()? onClickedPositive,
    final Future<bool> Function()? onClickedNegative,
    final bool enableWarning = false,
  }) {
    final Color? foregroundColor;
    final Color? backgroundColor;

    if (enableWarning) {
      foregroundColor = Theme.of(context).colorScheme.onError;
      backgroundColor = Theme.of(context).colorScheme.error;
    } else {
      foregroundColor = null;
      backgroundColor = null;
    }

    return NavigatorUtility.dialog.showPopup(
      context,
      widget: DialogTemplateView(
        title: title,
        titleColor: backgroundColor,
        message: message,
        layout: layout,
        positiveButton: DialogButtonComponent.positive(
          title: positiveText ?? 'Confirm',
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          onClicked: (context) async {
            if (await onClickedPositive?.call() ?? true) {
              Navigator.pop(context);
            }
          },
        ),
        negativeButton: DialogButtonComponent.negative(
          title: negativeText ?? 'Cancel',
          onClicked: (context) async {
            if (await onClickedNegative?.call() ?? true) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  const AlertDialogRoute._();
}