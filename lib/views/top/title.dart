import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/provider/wallpaper.dart';

class TopTitle extends ConsumerWidget {
  const TopTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      tr(
        AppI10n.homeTopTitle,
        namedArgs: {
          'count': '${ref.watch(filterWallpaperListProvider).length}',
        },
      ),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
