import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/widgets/setting_label.dart';

import 'language_switch.dart';
import 'notification_switch.dart';
import 'theme_switch.dart';

class SettingSystemGroup extends ConsumerWidget {
  const SettingSystemGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingLabel(tr(AppI10n.settingSystemLabel)),
        NotificationSwitch(),
        SizedBox(height: 4),
        LanguageSwitch(),
        SizedBox(height: 4),
        ThemeSwitch(),
      ],
    );
  }
}
