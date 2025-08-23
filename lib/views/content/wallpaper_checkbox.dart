import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/wallpaper.dart';

class WallpaperCheckbox extends ConsumerWidget {
  const WallpaperCheckbox({super.key, required this.wallpaper});

  final WallpaperInfo wallpaper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected =
        ref.watch(hoverWallpaperProvider) == wallpaper || wallpaper.checked;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300), // 动画总时长
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: isSelected
          ? Align(
              key: const Key('checkbox-visible'), // 关键帧标识
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1 : 0,
                child: Checkbox(
                  value: wallpaper.checked,
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.lightBlue;
                    }
                    return Colors.white;
                  }),
                  checkColor: Colors.white,
                  side: const BorderSide(color: Colors.lightBlue),
                  onChanged: (v) => ref
                      .read(wallpaperListProvider.notifier)
                      .toggleChecked(wallpaper),
                ),
              ),
            )
          : const SizedBox.shrink(key: Key('checkbox-hidden')), // 隐藏时空容器
    );
  }
}
