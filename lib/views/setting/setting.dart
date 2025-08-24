import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/views/setting/setting_about_group.dart';
import 'package:we_repkg/views/setting/setting_config_group.dart';
import 'package:we_repkg/views/setting/setting_filter_group.dart';
import 'package:we_repkg/views/setting/setting_system_group.dart';
import 'package:we_repkg/widgets/dialog.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogView(
      title: tr(AppI10n.settingTitle),
      content: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingFilterGroup(),
            SettingConfigGroup(),
            SettingSystemGroup(),
            SettingAboutGroup(),
          ],
        ),
      ),
      onClose: () => Navigator.of(context).pop(),
    );
  }
}
