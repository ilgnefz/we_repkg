import 'package:flutter/material.dart';

class SettingLabel extends StatelessWidget {
  const SettingLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontFamily: 'Microsoft YaHei',
        ),
      ),
    );
  }
}
