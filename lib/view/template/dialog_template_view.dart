import 'package:flutter/material.dart';

import '../../component/button/dialog_button_component.dart';

class DialogTemplateView extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? message;
  final Color? messageColor;
  final Widget? layout;
  final DialogButtonComponent? positiveButton;
  final DialogButtonComponent? negativeButton;

  const DialogTemplateView({
    Key? key,
    required this.title,
    this.titleColor,
    this.message,
    this.messageColor,
    this.layout,
    this.positiveButton,
    this.negativeButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text(
        title ?? '',
        style: TextStyle(
          color: titleColor,
        ),
      ),
      content: _messageLayout,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 6.0,
      ),
      actions: [
        if (negativeButton is Widget) negativeButton ?? const SizedBox(),
        if (positiveButton is Widget) positiveButton ?? const SizedBox(),
      ],
    );
  }

  Widget? get _messageLayout {
    final widgetList = <Widget> [];

    if (message?.isNotEmpty ?? false) {
      widgetList.add(
        Text(
          message ?? '',
          style: TextStyle(
            color: messageColor,
          ),
        ),
      );
    }

    if (layout is Widget) {
      widgetList.add(layout ?? const SizedBox());
    }

    if (widgetList.isEmpty) {
      return null;
    } else if (widgetList.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: widgetList,
      );
    } else {
      return widgetList.first;
    }
  }
}
