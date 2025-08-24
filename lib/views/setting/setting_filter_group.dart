import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/widgets/setting_checkbox.dart';
import 'package:we_repkg/widgets/setting_label.dart';

import 'mature_switch.dart';

class SettingFilterGroup extends ConsumerWidget {
  const SettingFilterGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingLabel(tr(AppI10n.settingFilterLabel)),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterShowAll),
          value: ref.watch(showAllProvider),
          onChanged: (value) =>
              ref.read(showAllProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideScene),
          value: ref.watch(hideSceneProvider),
          onChanged: (value) =>
              ref.read(hideSceneProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideVideo),
          value: ref.watch(hideVideoProvider),
          onChanged: (value) =>
              ref.read(hideVideoProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideWeb),
          value: ref.watch(hideWebProvider),
          onChanged: (value) =>
              ref.read(hideWebProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideApplication),
          value: ref.watch(hideAppProvider),
          onChanged: (value) =>
              ref.read(hideAppProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideUnknown),
          value: ref.watch(hideUnknownProvider),
          onChanged: (value) =>
              ref.read(hideUnknownProvider.notifier).update(value!),
        ),
        MatureSwitch(),
      ],
    );
  }
}
