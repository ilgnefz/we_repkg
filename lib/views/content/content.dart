import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/cores/wallpaper.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/views/states/empty.dart';
import 'package:we_repkg/views/states/initial.dart';

import 'image.dart';

class ContentView extends ConsumerStatefulWidget {
  const ContentView({super.key});

  @override
  ConsumerState<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends ConsumerState<ContentView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      List<WallpaperInfo> wallpapers = await getAllFile(ref);
      ref.read(wallpaperListProvider.notifier).addAll(wallpapers);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return InitialView();
    RunState runState = ref.watch(currentStateProvider);
    if (runState.isInitial) return InitialView();
    if (runState.isEmpty) return EmptyView();
    final double width = 180;
    List<WallpaperInfo> list = ref.watch(filterWallpaperListProvider);
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          maxCrossAxisExtent: width,
        ),
        itemBuilder: (context, index) =>
            ImageView(width: width, index: index, wallpaper: list[index]),
      ),
    );
  }
}
