import 'package:flutter/material.dart';

class IconButtonComponent extends IconButton {
  static Widget elevate({
    Key? key,
    required final Widget icon,
    required final String? hint,
    required final void Function() onClicked,
  }) {
    return FloatingActionButton.small(
      heroTag: UniqueKey(),
      tooltip: hint,
      onPressed: onClicked,
      child: icon,
    );
  }

  static Widget outline({
    Key? key,
    required final Widget icon,
    required final String? hint,
    required final void Function() onClicked,
  }) {
    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
          ),
        ),
        child: IconButton(
          key: key,
          icon: icon,
          tooltip: hint,
          onPressed: onClicked,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }

  const IconButtonComponent({
    Key? key,
    required final Widget icon,
    required final String? hint,
    required final void Function() onClicked,
  }) : super(
    key: key,
    icon: icon,
    tooltip: hint,
    onPressed: onClicked,
  );
}