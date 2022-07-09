import 'package:flutter/material.dart';

class InfoTextComponent extends StatelessWidget {
  final String? title;
  final String? content;
  final EdgeInsets? padding;

  const InfoTextComponent({
    Key? key,
    required this.title,
    required this.content,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            (content?.trim().isEmpty ?? true) ? 'N/A' : content ?? '',
            style: const TextStyle(
              color: Color(0xFF616161),
            ),
          ),
        ],
      ),
    );
  }
}
