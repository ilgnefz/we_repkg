import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/cores/base.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/widgets/folder_input.dart';

class ToggleInput extends ConsumerWidget {
  const ToggleInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ExtractType extractType = ref.watch(currentExtractTypeProvider);
    String? text = extractType.isWallpaper
        ? ref.watch(exportPathProvider)
        : ref.watch(projectPathProvider);
    String hintText = extractType.isWallpaper
        ? AppI10n.homeExtractFolderTip
        : AppI10n.settingConfigProjectPathTip;
    return Expanded(
      child: FolderInput(
        controller: TextEditingController(text: text),
        hintText: tr(hintText),
        onPressed: () async => extractType.isWallpaper
            ? await setExportPath(ref)
            : await setProjectPath(ref),
      ),
    );
  }
}
