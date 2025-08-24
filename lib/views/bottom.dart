import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/cores/base.dart';
import 'package:we_repkg/cores/extract.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/widgets/custom_btn.dart';
import 'package:we_repkg/widgets/folder_input.dart';

class BottomView extends ConsumerWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<WallpaperInfo> checkedList = ref.watch(checkedWallpaperListProvider);
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        children: [
          Text(
            '${tr(AppI10n.homeExtractTo)}:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Expanded(
            child: FolderInput(
              controller: TextEditingController(
                text: ref.watch(exportPathProvider),
              ),
              hintText: tr(AppI10n.homeExtractFolderTip),
              onPressed: () => setExportPath(ref),
            ),
          ),
          CustomBtn(
            onPressed: ref.watch(exportPathProvider) == null
                ? null
                : () async => await browseFolder(ref),
            label: tr(AppI10n.homeBrowseFolder),
          ),
          if (checkedList.isEmpty)
            CustomBtn(
              onPressed: () => extractAll(ref),
              label: tr(AppI10n.homeExtractAll),
            ),
          if (checkedList.isNotEmpty) ...[
            CustomBtn(
              onPressed: () => extractChecked(ref),
              label: tr(AppI10n.homeExtractChecked),
            ),
            CustomBtn(
              onPressed: () => clearChecked(ref),
              label: tr(AppI10n.homeCancelChecked),
            ),
            CustomBtn(
              onPressed: () => deleteChecked(ref),
              label: tr(AppI10n.homeDeleteChecked),
              backgroundColor: Colors.red,
            ),
          ],
        ],
      ),
    );
  }
}
