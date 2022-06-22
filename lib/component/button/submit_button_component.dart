import 'package:flutter/material.dart';

enum SubmitButtonMode {
  primary,
  secondary,
}

const _minimumSize = Size(150, 45);
const _roundedShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(12.0),
  ),
);
const _textStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

class SubmitButtonComponent extends StatelessWidget {
  final String? title;
  final void Function() onClicked;
  final SubmitButtonMode mode;

  const SubmitButtonComponent({
    Key? key,
    required this.title,
    required this.onClicked,
  }) :  mode = SubmitButtonMode.primary,
        super(key: key);

  const SubmitButtonComponent.secondary({
    Key? key,
    required this.title,
    required this.onClicked,
  }) :  mode = SubmitButtonMode.secondary,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(mode) {
      case SubmitButtonMode.primary:
        return ElevatedButton(
          onPressed: onClicked,
          style: ElevatedButton.styleFrom(
            minimumSize: _minimumSize,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shape: _roundedShape,
            textStyle: _textStyle,
          ),
          child: Text(title ?? ''),
        );
      case SubmitButtonMode.secondary:
        return OutlinedButton(
          onPressed: onClicked,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            minimumSize: _minimumSize,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            shape: _roundedShape,
            textStyle: _textStyle,
          ),
          child: Text(title ?? ''),
        );
    }
  }
}
