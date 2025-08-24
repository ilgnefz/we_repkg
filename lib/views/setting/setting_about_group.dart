import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/utils/pack.dart';
import 'package:we_repkg/widgets/link_text.dart';
import 'package:we_repkg/widgets/setting_info.dart';
import 'package:we_repkg/widgets/setting_label.dart';

class SettingAboutGroup extends ConsumerWidget {
  const SettingAboutGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingLabel(tr(AppI10n.settingAboutLabel)),
        SizedBox(height: 8),
        SettingInfo(
          title: tr(AppI10n.settingAboutOpenSourceLicense),
          content: AppStrings.license,
        ),
        SettingInfo(
          title: tr(AppI10n.settingAboutRepkgVersion),
          content: ref.watch(toolVersionProvider) ?? AppStrings.repkgVersion,
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
    );
  }
}
