import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/cores/wallpaper.dart';

class Refresh extends ConsumerWidget {
  const Refresh({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => refreshWallpaper(ref),
      icon: Icon(Icons.refresh_rounded),
    );
  }
}
