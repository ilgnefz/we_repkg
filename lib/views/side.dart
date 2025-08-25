import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_repkg/config/custom_theme.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/cores/base.dart';
import 'package:we_repkg/cores/extract.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/utils/tool.dart';
import 'package:we_repkg/widgets/copy.dart';
import 'package:we_repkg/widgets/custom_btn.dart';

class SideView extends ConsumerWidget {
  const SideView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    WallpaperInfo? wallpaper = ref.watch(selectedWallpaperProvider);
    List<WallpaperInfo> list = ref.watch(filterWallpaperListProvider);

    if (wallpaper == null || !list.contains(wallpaper)) {
      return SizedBox.shrink();
    }

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .25,
      constraints: BoxConstraints(maxWidth: 320),
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 4, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(
                    File(wallpaper.previews),
                    width: min(size.width * .2, 260),
                    height: min(size.width * .2, 260),
                    fit: BoxFit.cover,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: wallpaper.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                      ),
                      children: [
                        WidgetSpan(child: CopyBtn(text: wallpaper.title)),
                      ],
                    ),
                  ),
                  Text(
                    '${typeText(wallpaper.type)}  ${formatSize(wallpaper.size)}',
                    style: theme.extension<SideTheme>()!.largeStyle,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'ID: ${wallpaper.id}',
                      style: theme.extension<SideTheme>()!.mediumStyle,
                      children: [
                        WidgetSpan(
                          child: CopyBtn(text: wallpaper.id, size: 12),
                        ),
                      ],
                    ),
                  ),
                  if (size.height > 720) ...[
                    Text(
                      '${tr(AppI10n.homeUpdateDate)}: ${formattedTime(wallpaper.updateTime)}',
                      style: theme.extension<SideTheme>()!.mediumStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${tr(AppI10n.homeCreatedDate)}: ${wallpaper.createTime.toString().substring(0, 19)}',
                      style: theme.extension<SideTheme>()!.mediumStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 4),
                  if (wallpaper.type != 'application' ||
                      wallpaper.type != 'web')
                    CustomBtn(
                      onPressed: () => extractCurrent(ref, wallpaper),
                      label: tr(AppI10n.homeExtractCurrent),
                    ),
                  if (wallpaper.type == 'scene')
                    CustomBtn(
                      onPressed: () => extractProject(ref, [wallpaper]),
                      label: tr(AppI10n.homeExtractForProject),
                    ),
                  if (wallpaper.type == 'video')
                    CustomBtn(
                      onPressed: () => playVideo(wallpaper),
                      label: tr(AppI10n.homePlayVideo),
                    ),
                  CustomBtn(
                    onPressed: () => browserCurrent(wallpaper),
                    label: tr(AppI10n.homeOpenFileLocation),
                  ),
                  CustomBtn(
                    onPressed: () async => await deleteCurrent(ref, wallpaper),
                    label: tr(AppI10n.homeDeleteCurrent),
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return IconButton(
                onPressed: () =>
                    ref.read(selectedWallpaperProvider.notifier).update(null),
                icon: Icon(Icons.close_rounded),
              );
            },
          ),
        ],
      ),
    );
  }
}

String formattedTime(int time) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return dateTime.toString().substring(0, 19);
}
