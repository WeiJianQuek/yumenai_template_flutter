import 'package:flutter/material.dart';

import '../../main.dart';

class OptionItemView {
  static Widget single({
    required final String? title,
    required final bool Function() onListen,
    required final void Function() onSelect,
    final String? content,
    final Color? color,
  }) {
    return SingleOptionItemView(
      title: title,
      content: content,
      color: color,
      onListen: onListen,
      onSelect: onSelect,
    );
  }

  static Widget multiple({
    required final String? title,
    required final bool Function() onListen,
    required final void Function() onSelect,
    final String? content,
    final Color? color,
  }) {
    return MultipleOptionItemView(
      title: title,
      content: content,
      color: color,
      onListen: onListen,
      onSelect: onSelect,
    );
  }

  const OptionItemView._();
}

class SingleOptionItemView extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? color;
  final bool Function() onListen;
  final void Function() onSelect;

  const SingleOptionItemView({
    Key? key,
    required this.title,
    required this.onListen,
    required this.onSelect,
    required this.content,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(
        title ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: content?.isEmpty ?? true ? null : Text(content ?? ''),
      value: onListen(),
      groupValue: true,
      activeColor: resource.color.primary,
      onChanged: (isSelected) {
        FocusScope.of(context).unfocus();
        onSelect();
      },
    );
  }
}

class MultipleOptionItemView extends StatefulWidget {
  final String? title;
  final String? content;
  final Color? color;
  final bool Function() onListen;
  final void Function() onSelect;

  const MultipleOptionItemView({
    Key? key,
    required this.title,
    required this.onListen,
    required this.onSelect,
    this.content,
    this.color,
  }) : super(key: key);

  @override
  State<MultipleOptionItemView> createState() => _MultipleOptionItemViewState();
}

class _MultipleOptionItemViewState extends State<MultipleOptionItemView> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.title ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: widget.content?.isEmpty ?? true ? null : Text(widget.content ?? ''),
      value: widget.onListen(),
      activeColor: resource.color.primary,
      onChanged: (isSelected) {
        FocusScope.of(context).unfocus();
        widget.onSelect();
        if (mounted) setState(() {});
      },
    );
  }
}
