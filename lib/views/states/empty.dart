import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/cores/base.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/widgets/folder_input.dart';

class EmptyView extends ConsumerWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey),
            Text(
              tr(AppI10n.emptyTip),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Microsoft YaHei',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: FolderInput(
                width: double.infinity,
                height: 40,
                fontSize: 14,
                controller: TextEditingController(
                  text: ref.watch(wallpaperPathProvider),
                ),
                hintText: tr(AppI10n.settingConfigWallpapersPathTip),
                onPressed: () => setWallpaperPath(ref),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
