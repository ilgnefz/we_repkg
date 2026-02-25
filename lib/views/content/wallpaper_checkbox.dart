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
    final Color primaryColor = Theme.of(context).primaryColor;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: isSelected
          ? Align(
              key: const Key('checkboxVisible'),
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1 : 0,
                child: Checkbox(
                  value: wallpaper.checked,
                  mouseCursor: SystemMouseCursors.click,
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return primaryColor;
                    }
                    return Colors.white;
                  }),
                  checkColor: Colors.white,
                  side: BorderSide(color: primaryColor),
                  onChanged: (v) => ref
                      .read(wallpaperListProvider.notifier)
                      .toggleChecked(wallpaper),
                ),
              ),
            )
          : const SizedBox.shrink(key: Key('checkboxHidden')),
    );
  }
}
