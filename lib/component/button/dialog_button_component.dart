import 'package:flutter/material.dart';

enum DialogButtonMode {
  positive,
  negative,
}

class DialogButtonComponent extends StatelessWidget {
  final String? title;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final void Function(BuildContext) onClicked;
  final DialogButtonMode mode;

  const DialogButtonComponent.positive({
    Key? key,
    required this.title,
    required this.onClicked,
    this.foregroundColor,
    this.backgroundColor,
  }) :  mode = DialogButtonMode.positive,
        super(key: key);

  const DialogButtonComponent.negative({
    Key? key,
    required this.title,
    required this.onClicked,
    final Color? color,
  }) :  mode = DialogButtonMode.negative,
        foregroundColor = color,
        backgroundColor = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(mode) {
      case DialogButtonMode.positive:
        return ElevatedButton(
          onPressed: () {
            onClicked(context);
          },
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            onPrimary: foregroundColor,
          ),
          child: _titleText,
        );
      case DialogButtonMode.negative:
        return TextButton(
          onPressed: () {
            onClicked(context);
          },
          style: TextButton.styleFrom(
            primary: foregroundColor,
          ),
          child: _titleText,
        );
    }
  }

  Widget get _titleText {
    return Text(title ?? '');
  }
}
