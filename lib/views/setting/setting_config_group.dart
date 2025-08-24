import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/widgets/double_title_checked.dart';
import 'package:we_repkg/widgets/setting_checkbox.dart';
import 'package:we_repkg/widgets/setting_label.dart';

import 'tool_path_input.dart';
import 'wallpaper_path_input.dart';

class SettingConfigGroup extends ConsumerWidget {
  const SettingConfigGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingLabel(tr(AppI10n.settingConfigLabel)),
        SettingCheckbox(
          label: tr(AppI10n.settingConfigOnlySaveImage),
          value: ref.watch(onlySaveImageProvider),
          onChanged: (value) =>
              ref.read(onlySaveImageProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingConfigNoTexture),
          value: ref.watch(excludeTextureProvider),
          onChanged: (value) =>
              ref.read(excludeTextureProvider.notifier).update(value!),
        ),
        SettingCheckbox(
          label: tr(AppI10n.settingConfigOriginalProjectName),
          value: ref.watch(useTitleNameProvider),
          onChanged: (value) =>
              ref.read(useTitleNameProvider.notifier).update(value!),
        ),
        DoubleTitleChecked(
          value: ref.watch(replaceFileProvider),
          onChanged: (value) =>
              ref.read(replaceFileProvider.notifier).update(value!),
          title: tr(AppI10n.settingConfigReplaceExistFile),
          subTitle: tr(AppI10n.settingConfigReplaceExistFileTip),
        ),
        DoubleTitleChecked(
          value: ref.watch(deleteTransparencyProvider),
          onChanged: (value) =>
              ref.read(deleteTransparencyProvider.notifier).update(value!),
          title: tr(AppI10n.settingConfigDeleteTransparency),
          subTitle: tr(AppI10n.settingConfigDeleteTransparencyTip),
        ),
        SizedBox(height: 8),
        ToolPathInput(),
        SizedBox(height: 4),
        WallpaperPathInput(),
      ],
    );
  }
}
