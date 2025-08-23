import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/cores/base.dart';
import 'package:we_repkg/cores/wallpaper.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/utils/storage.dart';
import 'package:we_repkg/widgets/folder_input.dart';

class WallpaperPathInput extends ConsumerWidget {
  const WallpaperPathInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${tr(AppI10n.settingConfigWallpapersPath)}:',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        FolderInput(
          height: 32,
          fontSize: 13,
          controller: TextEditingController(
            text: ref.watch(wallpaperPathProvider),
          ),
          hintText: tr(AppI10n.settingConfigWallpapersPathTip),
          onPressed: () async {
            bool notEmpty = await setWallpaperPath(ref);
            if (notEmpty) await refreshWallpaper(ref);
          },
        ),
        IconButton(
          onPressed: () async {
            String? before = StorageUtil.getString(AppKeys.wallpaperPathBefore);
            if (before != null) {
              ref.read(wallpaperPathProvider.notifier).update(before);
            }
            await refreshWallpaper(ref);
          },
          icon: Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }
}
