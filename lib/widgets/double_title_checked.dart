import 'package:flutter/material.dart';

import 'setting_checkbox.dart';

class DoubleTitleChecked extends StatelessWidget {
  const DoubleTitleChecked({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.subTitle,
  });

  final bool value;
  final Function(bool?) onChanged;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SettingCheckbox(
      value: value,
      onChanged: onChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(subTitle, style: TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}
