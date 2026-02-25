import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/cores/context_menu.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/utils/storage.dart';
import 'package:we_repkg/views/content/image.dart';
import 'package:we_repkg/views/content/title.dart';

import 'wallpaper_checkbox.dart';

class ImageItem extends ConsumerWidget {
  const ImageItem({
    super.key,
    required this.width,
    required this.index,
    required this.wallpaper,
  });

  final double width;
  final int index;
  final WallpaperInfo wallpaper;

  Future<void> onPointerDown(WidgetRef ref, PointerDownEvent event) async {
    if (event.buttons == kPrimaryButton && event.localPosition != Offset.zero) {
      Set keysPressed = HardwareKeyboard.instance.logicalKeysPressed;
      final isCtrlPressed =
          keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
          keysPressed.contains(LogicalKeyboardKey.controlRight);
      final isShiftPressed =
          keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
          keysPressed.contains(LogicalKeyboardKey.shiftRight);

      if (isCtrlPressed) {
        await StorageUtil.setInt(AppKeys.ctrlPressedIndex, index);
        ref.read(wallpaperListProvider.notifier).toggleChecked(wallpaper);
      } else if (isShiftPressed) {
        int beginIndex = 0, endIndex = index;
        List<WallpaperInfo> list = ref.watch(filterWallpaperListProvider);
        List<WallpaperInfo> checkedList = ref.watch(
          checkedWallpaperListProvider,
        );
        if (checkedList.isNotEmpty) {
          beginIndex =
              StorageUtil.getInt(AppKeys.ctrlPressedIndex) ??
              list.indexOf(checkedList.last);
          if (index < beginIndex) {
            endIndex = beginIndex;
            beginIndex = index;
          }
        }
        await StorageUtil.remove(AppKeys.ctrlPressedIndex);
        List<WallpaperInfo> newList = list.sublist(beginIndex, endIndex + 1);
        for (WallpaperInfo e in newList) {
          ref.read(wallpaperListProvider.notifier).updateChecked(e, true);
        }
      } else {
        ref.read(selectedWallpaperProvider.notifier).update(wallpaper);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Listener(
      key: Key(wallpaper.id),
      onPointerDown: (e) => onPointerDown(ref, e),
      child: InkWell(
        onSecondaryTapDown: (details) =>
            showRightMenu(context, details, ref, wallpaper),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (e) =>
              ref.read(hoverWallpaperProvider.notifier).update(wallpaper),
          onExit: (e) => ref.read(hoverWallpaperProvider.notifier).update(null),
          child: Container(
            key: ValueKey(wallpaper.id),
            width: width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .5),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ImageView(size: width, wallpaper: wallpaper),
                ImageTitle(title: wallpaper.title),
                WallpaperCheckbox(wallpaper: wallpaper),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
