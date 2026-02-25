import 'package:flutter/material.dart';
import 'package:we_repkg/views/setting/setting.dart';
import 'package:we_repkg/widgets/click_icon.dart';

class SettingBtn extends StatelessWidget {
  const SettingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ClickIcon(
      width: 40,
      height: 32,
      icon: Icons.settings_outlined,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => SettingView(),
          barrierColor: Colors.black.withValues(alpha: .6),
        );
      },
    );
  }
}
