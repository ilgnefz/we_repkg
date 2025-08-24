import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/utils/pack.dart';
import 'package:we_repkg/views/setting/language_switch.dart';
import 'package:we_repkg/views/setting/mature_switch.dart';
import 'package:we_repkg/views/setting/theme_switch.dart';
import 'package:we_repkg/widgets/dialog.dart';
import 'package:we_repkg/widgets/link_text.dart';
import 'package:we_repkg/widgets/setting_checkbox.dart';
import 'package:we_repkg/widgets/setting_info.dart';
import 'package:we_repkg/widgets/setting_label.dart';

import 'tool_path_input.dart';
import 'wallpaper_path_input.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogView(
      title: tr(AppI10n.settingTitle),
      content: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24, right: 16),
        child: Column(
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
            SettingCheckbox(
              value: ref.watch(replaceFileProvider),
              onChanged: (value) =>
                  ref.read(replaceFileProvider.notifier).update(value!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(AppI10n.settingConfigReplaceExistFile),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    tr(AppI10n.settingConfigReplaceExistFileTip),
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            ToolPathInput(),
            SizedBox(height: 4),
            WallpaperPathInput(),
            SettingLabel(tr(AppI10n.settingSystemLabel)),
            LanguageSwitch(),
            SizedBox(height: 4),
            ThemeSwitch(),
            SettingLabel(tr(AppI10n.settingAboutLabel)),
            SizedBox(height: 8),
            SettingInfo(
              title: tr(AppI10n.settingAboutOpenSourceLicense),
              content: AppStrings.license,
            ),
            Consumer(
              builder: (context, ref, _) {
                return SettingInfo(
                  title: tr(AppI10n.settingAboutRepkgVersion),
                  content:
                      ref.watch(toolVersionProvider) ?? AppStrings.repkgVersion,
                );
              },
            ),
            SettingInfo(
              title: tr(AppI10n.settingAboutRepkgAuthor),
              content: AppStrings.repkgAuthor,
            ),
            SettingInfo(
              title: tr(AppI10n.settingAboutRepkgUrl),
              child: LinkText(
                label: AppStrings.repkgRepo,
                uri: AppStrings.repkgRepo,
              ),
            ),
            SettingInfo(
              title: tr(AppI10n.settingAboutWeRepkgVersion),
              content: PackInfo.getVersion(),
            ),
            SettingInfo(
              title: tr(AppI10n.settingAboutWeRepkgAuthor),
              content: AppStrings.appAuthor,
            ),
            SettingInfo(
              title: tr(AppI10n.settingAboutWeRepkgUrl),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinkText(
                      label: AppStrings.appRepoGithub,
                      uri: AppStrings.appRepoGithub,
                    ),
                    LinkText(
                      label: AppStrings.appRepoGitte,
                      uri: AppStrings.appRepoGitte,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onClose: () => Navigator.of(context).pop(),
    );
  }
}
