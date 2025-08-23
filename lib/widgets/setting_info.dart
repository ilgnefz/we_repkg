import 'package:flutter/material.dart';

class SettingInfo extends StatelessWidget {
  const SettingInfo({super.key, required this.title, this.content, this.child});

  final String title;
  final String? content;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: child == null
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text('$title:', style: textStyle),
          SizedBox(width: 8),
          child ?? Text(content!, style: textStyle),
        ],
      ),
    );
  }
}
