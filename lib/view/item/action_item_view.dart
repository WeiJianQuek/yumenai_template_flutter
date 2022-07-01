import 'package:flutter/material.dart';

class ActionItemView extends StatelessWidget {
  final String? title;
  final String? content;
  final Widget? icon;
  final Color? color;
  final void Function() onClicked;

  const ActionItemView({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClicked,
    this.content,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 4.0,
      iconColor: color,
      textColor: color,
      leading: icon,
      title: Text(
        title ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: content?.isEmpty ?? true ? null : Text(content ?? ''),
      onTap: () {
        FocusScope.of(context).unfocus();
        onClicked();
      },
    );
  }
}
