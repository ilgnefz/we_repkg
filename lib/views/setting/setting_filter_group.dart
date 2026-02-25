import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/provider/filter.dart';
import 'package:we_repkg/widgets/setting_checkbox.dart';
import 'package:we_repkg/widgets/setting_label.dart';

import 'mature_switch.dart';

class SettingFilterGroup extends ConsumerWidget {
  const SettingFilterGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterWatch = ref.watch(filterStateProvider);
    final filterRead = ref.read(filterStateProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingLabel(tr(AppI10n.settingFilterLabel)),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterShowAll),
          value: filterWatch.showAll,
          onChanged: (value) => filterRead.updateShowAll(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideScene),
          value: filterWatch.hideScene,
          onChanged: (value) => filterRead.updateHideScene(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideVideo),
          value: filterWatch.hideVideo,
          onChanged: (value) => filterRead.updateHideVideo(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideWeb),
          value: filterWatch.hideWeb,
          onChanged: (value) => filterRead.updateHideWeb(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideApplication),
          value: filterWatch.hideApp,
          onChanged: (value) => filterRead.updateHideApp(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingFilterHideUnknown),
          value: filterWatch.hideUnknown,
          onChanged: (value) => filterRead.updateHideUnknown(value!),
        ),
        MatureSwitch(),
      ],
    );
  }
}
