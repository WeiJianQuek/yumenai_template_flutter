import 'package:flutter/material.dart';

enum ToggleButtonMode {
  checkbox,
  switches,
}

// This component is created in preparation of future custom toggle mode

class ToggleButtonComponent extends StatelessWidget {
  final ToggleButtonMode mode;
  final bool Function() onListenValue;
  final void Function() onClicked;

  const ToggleButtonComponent({
    Key? key,
    required this.onListenValue,
    required this.onClicked,
  })  : mode = ToggleButtonMode.checkbox,
        super(key: key);

  const ToggleButtonComponent.switches({
    Key? key,
    required this.onListenValue,
    required this.onClicked,
  })  : mode = ToggleButtonMode.switches,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(mode) {
      case ToggleButtonMode.switches:
        return Switch(
          value: onListenValue(),
          onChanged: (_) {
            onClicked();
          },
        );
      case ToggleButtonMode.checkbox:
        return Checkbox(
          value: onListenValue(),
          onChanged: (_) {
            onClicked();
          },
        );
    }
  }
}
