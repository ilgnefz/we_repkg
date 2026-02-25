import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/utils/storage.dart';
import 'package:we_repkg/widgets/circular_progress.dart';

import 'wallpaper_checkbox.dart';

class ImageView extends ConsumerStatefulWidget {
  const ImageView({
    super.key,
    required this.width,
    required this.index,
    required this.wallpaper,
  });

  final double width;
  final int index;
  final WallpaperInfo wallpaper;

  @override
  ConsumerState<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends ConsumerState<ImageView> {
  Future<void> onPointerDown(PointerDownEvent event) async {
    if (event.buttons == kPrimaryButton && event.localPosition != Offset.zero) {
      Set keysPressed = HardwareKeyboard.instance.logicalKeysPressed;
      final isCtrlPressed =
          keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
          keysPressed.contains(LogicalKeyboardKey.controlRight);
      final isShiftPressed =
          keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
          keysPressed.contains(LogicalKeyboardKey.shiftRight);

      if (isCtrlPressed) {
        await StorageUtil.setInt(AppKeys.ctrlPressedIndex, widget.index);
        ref
            .read(wallpaperListProvider.notifier)
            .toggleChecked(widget.wallpaper);
      } else if (isShiftPressed) {
        int beginIndex = 0, endIndex = widget.index;
        List<WallpaperInfo> list = ref.watch(filterWallpaperListProvider);
        List<WallpaperInfo> checkedList = ref.watch(
          checkedWallpaperListProvider,
        );
        if (checkedList.isNotEmpty) {
          beginIndex =
              StorageUtil.getInt(AppKeys.ctrlPressedIndex) ??
              list.indexOf(checkedList.last);
          if (widget.index < beginIndex) {
            endIndex = beginIndex;
            beginIndex = widget.index;
          }
        }
        await StorageUtil.remove(AppKeys.ctrlPressedIndex);
        List<WallpaperInfo> newList = list.sublist(beginIndex, endIndex + 1);
        for (WallpaperInfo e in newList) {
          ref.read(wallpaperListProvider.notifier).updateChecked(e, true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: Key(widget.wallpaper.id),
      child: Listener(
        onPointerDown: onPointerDown,
        child: InkWell(
          onTap: () {
            ref
                .read(selectedWallpaperProvider.notifier)
                .update(widget.wallpaper);
            debugPrint(widget.wallpaper.toString());
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (e) => ref
                .read(hoverWallpaperProvider.notifier)
                .update(widget.wallpaper),
            onExit: (e) =>
                ref.read(hoverWallpaperProvider.notifier).update(null),
            child: Container(
              key: ValueKey(widget.wallpaper.id),
              width: widget.width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(4),
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
                  Container(
                    width: widget.width,
                    height: widget.width,
                    decoration: BoxDecoration(color: Colors.white),
                    clipBehavior: Clip.hardEdge,
                    child: AnimatedScale(
                      scale:
                          ref.watch(hoverWallpaperProvider) == widget.wallpaper
                          ? 1.2
                          : 1,
                      duration: const Duration(milliseconds: 250), // 动画时长300ms
                      curve: Curves.easeInOut,
                      alignment: Alignment.center, // 缩放中心
                      child: Image.file(
                        File(widget.wallpaper.previews),
                        width: widget.width,
                        height: widget.width,
                        fit: BoxFit.cover,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) return child;
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: frame != null
                                    ? child
                                    : const Center(
                                        child: EasyCircularProgress(),
                                      ),
                              );
                            },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 48),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      // constraints: BoxConstraints(maxHeight: 40),
                      height: 24,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.wallpaper.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Microsoft YaHei',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  WallpaperCheckbox(wallpaper: widget.wallpaper),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
