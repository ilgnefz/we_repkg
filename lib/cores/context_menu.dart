import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/widgets/right_menu_item.dart';

import 'base.dart';
import 'extract.dart';

Future<void> showRightMenu(
  BuildContext context,
  TapDownDetails details,
  WidgetRef ref,
  WallpaperInfo wallpaper,
) async {
  List<WallpaperInfo> checkedList = ref.watch(checkedWallpaperListProvider);
  final entries = <ContextMenuEntry>[
    if (wallpaper.type != 'application' || wallpaper.type != 'web')
      RightMenuItem(
        label: tr(AppI10n.homeExtractCurrent),
        onSelected: (_) => extractCurrent(ref, wallpaper),
      ),
    if (wallpaper.type == 'scene')
      RightMenuItem(
        label: tr(AppI10n.homeExtractForProject),
        onSelected: (_) => extractProject(ref, [wallpaper]),
      ),
    if (wallpaper.type == 'video')
      RightMenuItem(
        label: tr(AppI10n.homePlayVideo),
        onSelected: (_) => playVideo(wallpaper),
      ),
    RightMenuItem(
      label: tr(AppI10n.homeOpenFileLocation),
      onSelected: (_) => browserCurrent(wallpaper),
    ),
    if (checkedList.isNotEmpty)
      RightMenuItem(
        label: tr(AppI10n.homeExtractSelected),
        onSelected: (_) => extractChecked(ref),
      ),
    RightMenuItem(
      label: tr(AppI10n.homeDeleteCurrent),
      color: Colors.red,
      onSelected: (_) async => await deleteCurrent(ref, wallpaper),
    ),
  ];

  final ContextMenu<dynamic> menu = ContextMenu(
    entries: entries,
    boxDecoration: BoxDecoration(
      color: Theme.of(context).dialogTheme.backgroundColor,
      borderRadius: BorderRadius.circular(4),
      boxShadow: [
        BoxShadow(blurRadius: 4, color: Colors.black.withValues(alpha: .2)),
      ],
    ),
    padding: EdgeInsets.zero,
    position: details.globalPosition,
  );

  await showContextMenu(context, contextMenu: menu);
}
