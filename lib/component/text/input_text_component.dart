import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _curveRadius = 12.0;

const _marginSpacing = EdgeInsets.symmetric(
  vertical: 8.0,
);

enum InputTextStyle {
  fill,
  line,
  outline,
}

class InputTextComponent extends StatelessWidget {
  static Widget option({
    required final int itemCount,
    required final String Function(int) onBuild,
    required final void Function(int) onSelect,
    final String? label,
    final String? hint,
    final Color? backgroundColor,
    final int? selectedIndexPosition,
    final String? prefixText,
    final Widget? prefixIcon,
    final String? Function(int?)? onValidate,
    final InputTextStyle style = InputTextStyle.outline,
    final bool enableSpacing = true,
  }) {
    final optionItemList = <DropdownMenuItem<int>> [];
    for (int indexPosition = 0; indexPosition < itemCount; indexPosition++) {
      optionItemList.add(
        DropdownMenuItem(
          value: indexPosition,
          child: Text(onBuild(indexPosition)),
        ),
      );
    }

    final component = DropdownButtonFormField<int>(
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      validator: onValidate,
      items: optionItemList,
      value: selectedIndexPosition,
      decoration: _inputDecoration(
        label: label,
        hint: hint,
        backgroundColor: backgroundColor,
        style: style,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        suffixIcon: null,
        suffixText: null,
      ),
      onChanged: (indexPosition) {
        if (indexPosition is int) {
          onSelect.call(indexPosition);
        }
      },
    );

    if (enableSpacing) {
      return Padding(
        padding: _marginSpacing,
        child: component,
      );
    } else {
      return component;
    }
  }

  static Widget secure({
    Key? key,
    required final TextEditingController controller,
    final String? hint,
    final String? label,
    final Color? backgroundColor,
    final bool enableSpacing = true,
    final bool enableEditable = true,
    final String? Function(String?)? onValidate,
    final void Function(String?)? onEdit,
    final void Function()? onSubmit,
    final InputTextStyle style = InputTextStyle.outline,
  }) {
    return _SecureInputText(
      key: key,
      controller: controller,
      hint: hint,
      label: label,
      backgroundColor: backgroundColor,
      enableSpacing: enableSpacing,
      enableEditable: enableEditable,
      onValidate: onValidate,
      onEdit: onEdit,
      onSubmit: onSubmit,
      style: style,
    );
  }

  static Widget action({
    Key? key,
    required final TextEditingController controller,
    required final void Function() onSelect,
    final String? hint,
    final String? label,
    final String? actionText,
    final Color? backgroundColor,
    final bool enableSpacing = true,
    final bool enableEditable = true,
    final String? Function(String?)? onValidate,
    final void Function(String?)? onEdit,
    final void Function()? onSubmit,
    final InputTextStyle style = InputTextStyle.outline,
  }) {
    return InputTextComponent(
      key: key,
      controller: controller,
      hint: hint,
      label: label,
      backgroundColor: backgroundColor,
      enableSpacing: enableSpacing,
      enableEditable: enableEditable,
      enableInteractivity: false,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(
          right: 1.25,
        ),
        child: ElevatedButton(
          onPressed: () {
            onSelect();
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(_curveRadius - 1),
              ),
            ),
          ),
          child: Text(actionText ?? 'Select'),
        ),
      ),
      onValidate: onValidate,
      onEdit: onEdit,
      onSubmit: onSubmit,
      onClicked: onSelect,
      style: style,
    );
  }

  final String? hint;
  final String? label;

  final Color? backgroundColor;

  final int minLine;
  final int maxLine;
  final int? size;
  final bool enableSpacing;
  final bool enableObscurity;
  final bool enableEditable;
  final bool enableInteractivity;

  final TextCapitalization capitalization;
  final TextInputType keyboardType;
  final String? regexFormat;

  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;
  final String? suffixText;
  final TextEditingController controller;

  final String? Function(String?)? onValidate;
  final void Function(String?)? onEdit;
  final void Function()? onSubmit;
  final void Function()? onClicked;

  final InputTextStyle style;

  const InputTextComponent({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.minLine = 1,
    this.maxLine = 1,
    this.keyboardType = TextInputType.text,
    this.regexFormat,
    this.size,
    this.capitalization = TextCapitalization.none,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.onClicked,
    this.enableObscurity = false,
    this.enableEditable = true,
    this.enableInteractivity = true,
    this.style = InputTextStyle.outline,
  }) :  super(key: key);

  const InputTextComponent.name({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.minLine = 1,
    this.maxLine = 1,
    this.keyboardType = TextInputType.text,
    this.regexFormat,
    this.size,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.onClicked,
    this.enableEditable = true,
    this.style = InputTextStyle.outline,
  }) :  capitalization = TextCapitalization.words,
        enableObscurity = false,
        enableInteractivity = true,
        super(key: key);

  const InputTextComponent.field({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.minLine = 3,
    this.maxLine = 6,
    this.size,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.enableEditable = true,
    this.style = InputTextStyle.outline,
  }) :  onClicked = null,
        keyboardType = TextInputType.multiline,
        regexFormat = null,
        capitalization = TextCapitalization.sentences,
        enableObscurity = false,
        enableInteractivity = true,
        super(key: key);

  const InputTextComponent.email({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.size,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.enableEditable = true,
    this.style = InputTextStyle.outline,
  }) :  onClicked = null,
        keyboardType = TextInputType.emailAddress,
        minLine = 1,
        maxLine = 1,
        regexFormat = null,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableInteractivity = true,
        super(key: key);

  const InputTextComponent.phone({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.enableEditable = true,
    this.style = InputTextStyle.outline,
    final bool enableSymbol = true,
    final int? digitSize,
  }) :  onClicked = null,
        keyboardType = TextInputType.phone,
        minLine = 1,
        maxLine = 1,
        regexFormat = '^(${enableSymbol ? '[+]?' : ''}\\d${digitSize is int ? '{0,$digitSize}' : '*'})?',
        size = null,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableInteractivity = true,
        super(key: key);

  const InputTextComponent.number({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.enableEditable = true,
    this.style = InputTextStyle.outline,
    final bool enableSignDigit = true,
    final int? digitSize,
  }) :  onClicked = null,
        keyboardType = TextInputType.number,
        minLine = 1,
        maxLine = 1,
        regexFormat = '^(${enableSignDigit ? '[-,+]?' : ''}\\d${digitSize is int ? '{0,$digitSize}' : ''})?',
        size = null,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableInteractivity = true,
        super(key: key);

  const InputTextComponent.decimal({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.enableEditable = true,
    this.style = InputTextStyle.outline,
    final int? integerSize,
    final int? fractionSize,
    final bool enableSignDigit = true,
  }) :  onClicked = null,
        keyboardType = const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        regexFormat = '^${enableSignDigit ? '[-,+]?' : ''}\\d${integerSize is int ? '{0,$integerSize}' : '*'}(\\.\\d${fractionSize is int ? '{0,$fractionSize}' : '*'})?',
        minLine = 1,
        maxLine = 1,
        size = null,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableInteractivity = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final component = TextFormField(
      controller: controller,
      decoration: _inputDecoration(
        label: label,
        hint: hint,
        backgroundColor: backgroundColor,
        style: style,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: regexFormat is String ? [
        FilteringTextInputFormatter.allow(RegExp(regexFormat ?? ''))
      ] : null,
      maxLength: size,
      maxLines: maxLine,
      minLines: minLine,
      keyboardType: keyboardType,
      textCapitalization: capitalization,
      obscureText: enableObscurity,
      validator: onValidate,
      onTap: onClicked,
      onChanged: onEdit,
      enabled: enableEditable,
      readOnly: !enableInteractivity,
      enableInteractiveSelection: enableInteractivity,
      onFieldSubmitted: (_) {
        onSubmit?.call();
      },
    );

    if (enableSpacing) {
      return Padding(
        padding: _marginSpacing,
        child: component,
      );
    } else {
      return component;
    }
  }
}

class _SecureInputText extends StatefulWidget {
  final String? hint;
  final String? label;

  final Color? backgroundColor;

  final bool enableSpacing;
  final bool enableEditable;

  final TextEditingController controller;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onEdit;
  final void Function()? onSubmit;

  final InputTextStyle style;

  const _SecureInputText({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.backgroundColor,
    this.enableSpacing = true,
    this.enableEditable = true,
    this.onValidate,
    this.onEdit,
    this.onSubmit,
    this.style = InputTextStyle.outline,
  }) : super(key: key);

  @override
  State<_SecureInputText> createState() => _SecureInputTextState();
}

class _SecureInputTextState extends State<_SecureInputText> {
  bool enableObscurity = true;

  @override
  Widget build(BuildContext context) {
    return InputTextComponent(
      controller: widget.controller,
      hint: widget.hint,
      label: widget.label,
      backgroundColor: widget.backgroundColor,
      enableSpacing: widget.enableSpacing,
      onValidate: widget.onValidate,
      onEdit: widget.onEdit,
      onSubmit: widget.onSubmit,
      style: widget.style,
      enableObscurity: enableObscurity,
      enableEditable: widget.enableEditable,
      suffixIcon: enableObscurity ? IconButton(
        icon: const Icon(Icons.visibility),
        onPressed: () {
          enableObscurity = false;
          if (mounted) setState(() {});
        },
      ) : IconButton(
        icon: const Icon(Icons.visibility_off),
        onPressed: () {
          enableObscurity = true;
          if (mounted) setState(() {});
        },
      ),
    );
  }
}


InputDecoration _inputDecoration({
  required final String? label,
  required final String? hint,
  required final Color? backgroundColor,
  required final InputTextStyle style,
  required final String? prefixText,
  required final Widget? prefixIcon,
  required final String? suffixText,
  required final Widget? suffixIcon,
}) {
  final EdgeInsets padding;

  if (style == InputTextStyle.line) {
    padding = const EdgeInsets.all(8.0);
  } else {
    padding = const EdgeInsets.all(16.0);
  }

  final FloatingLabelBehavior floatingLabelBehavior;

  if (style == InputTextStyle.fill) {
    floatingLabelBehavior = FloatingLabelBehavior.never;
  } else {
    floatingLabelBehavior = FloatingLabelBehavior.auto;
  }

  final InputBorder inputBorder;

  switch (style) {
    case InputTextStyle.fill:
      inputBorder = const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(_curveRadius),
        ),
      );
      break;
    case InputTextStyle.line:
      inputBorder = const UnderlineInputBorder();
      break;
    case InputTextStyle.outline:
      inputBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_curveRadius),
        ),
        borderSide: BorderSide(
          width: 1.5,
        ),
      );
      break;
  }

  return InputDecoration(
    labelText: label,
    hintText: hint,
    border: inputBorder,
    fillColor: backgroundColor,
    filled: backgroundColor is Color,
    floatingLabelBehavior: floatingLabelBehavior,
    isDense: true,
    alignLabelWithHint: true,
    contentPadding: padding,
    prefixIcon: prefixIcon,
    prefixText: prefixText,
    suffixIcon: suffixIcon,
    suffixText: suffixText,
  );
}
