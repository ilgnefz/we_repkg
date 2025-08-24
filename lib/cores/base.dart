import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/src/rust/api/simple.dart';
import 'package:we_repkg/utils/info.dart';
import 'package:we_repkg/utils/storage.dart';

import 'toast.dart';
import 'wallpaper.dart';

Future<bool> setExportPath(WidgetRef ref) async {
  final String? exportPath = await getDirectoryPath();
  if (exportPath != null) {
    ref.read(exportPathProvider.notifier).update(exportPath);
    return true;
  }
  return false;
}

Future<void> setToolPath(WidgetRef ref) async {
  final xType = XTypeGroup(label: 'RePKG', extensions: ['exe']);
  final XFile? file = await openFile(acceptedTypeGroups: [xType]);
  if (file != null) {
    ProcessResult result = await Process.run(file.path, ['version']);
    // print('out:${result.stdout}');
    // print('err:${result.stderr}');
    // print('pid:${result.pid} -- exitCode:${result.exitCode}');
    if (result.exitCode == 0) {
      String version = '';
      if (result.stdout != '') {
        version = result.stdout.toString().trim().split('+').first;
      } else if (result.stderr != '') {
        version = result.stderr.toString().trim().split('+').first;
      }
      version = version.substring(6);
      ref.read(toolVersionProvider.notifier).update(version);
      debugPrint('版本: $version');
    }
    ref.read(toolPathProvider.notifier).update(file.path);
    await StorageUtil.setString(AppKeys.toolPath, file.path);
  }
}

Future<void> refreshToolPath(WidgetRef ref) async {
  await StorageUtil.remove(AppKeys.toolPath);
  ref.read(toolPathProvider.notifier).update(getToolPath());
  ref.read(toolVersionProvider.notifier).update(AppStrings.repkgVersion);
}

Future<void> setWallpaperPath(WidgetRef ref) async {
  final String? wallpaperPath = await getDirectoryPath();
  if (wallpaperPath != null) {
    ref.read(selectedWallpaperProvider.notifier).update(null);
    ref.read(wallpaperPathProvider.notifier).update(wallpaperPath);
    await StorageUtil.setString(AppKeys.wallpaperPath, wallpaperPath);
    await refreshWallpaper(ref);
  }
}

Future<void> refreshWallpaperPath(WidgetRef ref) async {
  String? before = StorageUtil.getString(AppKeys.wallpaperPathBefore);
  if (before != null) {
    ref.read(wallpaperPathProvider.notifier).update(before);
  }
  await refreshWallpaper(ref);
}

Future<void> browseFolder(WidgetRef ref) async {
  String? folderPath = ref.watch(exportPathProvider);
  if (folderPath == null) return;
  folderPath = folderPath.replaceAll('\\', '/');
  final uri = Uri.parse('file:///$folderPath');
  if (!Directory(folderPath).existsSync()) {
    return showErrorToast(tr(AppI10n.dialogFolderNoExist));
  }
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showErrorToast(tr(AppI10n.dialogOpenFolderFailed));
  }
}

Future<void> playVideo(WallpaperInfo wallpaper) async {
  String videoPath = wallpaper.target;
  if (!File(videoPath).existsSync()) {
    return showErrorToast(tr(AppI10n.dialogFileNoExist));
  }
  final Uri fileUri = Uri.file(videoPath);
  if (await canLaunchUrl(fileUri)) {
    await launchUrl(fileUri);
  } else {
    showErrorToast(tr(AppI10n.dialogPlayVideoFailed));
  }
}

Future<bool> checkExportPath(WidgetRef ref) async {
  String? exportPath = ref.watch(exportPathProvider);
  if (exportPath == null) return await setExportPath(ref);
  return true;
}

void clearChecked(WidgetRef ref) {
  List<WallpaperInfo> checkedList = ref.watch(checkedWallpaperListProvider);
  for (var wallpaper in checkedList) {
    ref.read(wallpaperListProvider.notifier).toggleChecked(wallpaper);
  }
}

Future<String?> deleteChecked(WidgetRef ref) async {
  String? err;
  List<WallpaperInfo> wallpapers = ref.watch(checkedWallpaperListProvider);
  List<String> paths = wallpapers.map((e) => e.folder).toList();
  try {
    err = await deleteAllToTrash(filePaths: paths);
    WallpaperInfo? selectedWallpaper = ref.watch(selectedWallpaperProvider);
    if (wallpapers.contains(selectedWallpaper)) {
      ref.read(selectedWallpaperProvider.notifier).update(null);
    }
    for (var wallpaper in wallpapers) {
      ref.read(wallpaperListProvider.notifier).remove(wallpaper);
    }
  } catch (e) {
    debugPrint('删除选中失败: $e');
    err = '${tr(AppI10n.dialogDeleteFailed)} $e';
  }
  return err;
}

Future<void> browserCurrent(WallpaperInfo wallpaper) async {
  String folder = wallpaper.folder;
  if (!Directory(folder).existsSync()) return showErrorToast('文件夹不存在');
  final fixedPath = 'file:///${folder.replaceAll('\\', '/')}';
  final uri = Uri.parse(fixedPath);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showErrorToast(tr(AppI10n.dialogOpenFolderFailed));
  }
}

Future<void> deleteCurrent(WidgetRef ref, WallpaperInfo wallpaper) async {
  try {
    await deleteToTrash(filePath: wallpaper.folder);
    ref.read(wallpaperListProvider.notifier).remove(wallpaper);
    ref.read(selectedWallpaperProvider.notifier).update(null);
    // showSuccessToast('删除成功！文件夹已被移至回收站');
  } catch (e) {
    debugPrint('删除文件失败: $e');
    showErrorToast('${tr(AppI10n.dialogDeleteFailed)} $e');
  }
}

Future<String?> deleteUselessFiles(
  WidgetRef ref,
  String outPath,
  List<FileSystemEntity> oldFiles,
) async {
  bool onlySaveImage = ref.watch(onlySaveImageProvider);
  bool excludeTexture = ref.watch(excludeTextureProvider);
  bool deleteTransparency = ref.watch(deleteTransparencyProvider);
  String? err;
  if (onlySaveImage && !excludeTexture) {
    err = await deleteOther(outPath, oldFiles);
  } else if (excludeTexture) {
    err = await deleteOtherAndTexture(outPath);
  }
  // 如果启用了删除透明PNG功能，执行透明PNG删除
  if (deleteTransparency && err == null) {
    Directory folder = Directory(outPath);
    List<FileSystemEntity> files = await folder.list().toList();
    List<String> filePaths = files
        .whereType<File>()
        .map((file) => file.path)
        .toList();
    List<String> oldFilePaths = oldFiles.map((file) => file.path).toList();
    String? transparencyErr = await deleteTransparentPngs(
      filePaths,
      excludeFiles: oldFilePaths,
    );
    if (transparencyErr != null) err = transparencyErr;
  }
  return err;
}

Future<String?> deleteOther(
  String outPath,
  List<FileSystemEntity> oldFiles,
) async {
  List<String> allFile = oldFiles.map((e) => e.path).toList();
  try {
    Directory folder = Directory(outPath);
    List<FileSystemEntity> files = await folder.list().toList();
    await Future.wait(
      files
          .where((file) {
            if (file is File) {
              String ext = file.path.split('.').last.toLowerCase();
              return !isImage(ext) && !allFile.contains(file.path);
            }
            return false;
          })
          .map((file) async {
            try {
              debugPrint('删除文件: ${file.path}');
              await file.delete();
            } catch (e) {
              debugPrint('删除文件失败 ${file.path}: $e');
              return '${file.path} ${tr(AppI10n.dialogDeleteFailed)} $e';
            }
            return null;
          }),
    );
    return null; // 没有错误时返回null
  } catch (e) {
    String errorMsg = '${tr(AppI10n.dialogDeleteFailed)} $e';
    debugPrint(errorMsg);
    return errorMsg; // 返回错误信息
  }
}

Future<String?> deleteOtherAndTexture(String outPath) async {
  if (await Directory('$outPath/materials').exists()) {
    final files = await Directory('$outPath/materials').list().toList();
    for (var file in files) {
      if (file is File && isImage(file.path)) {
        try {
          await file.rename('$outPath/${path.basename(file.path)}');
        } catch (e) {
          debugPrint('移动文件失败: $e');
          return e.toString();
        }
      }
    }
  }

  List<String> deleteList = [
    'effects',
    'fonts',
    'materials',
    'models',
    'particles',
    'shaders',
    'sounds',
  ];

  List<Future<void>> folderDeletionFutures = [];
  for (String folder in deleteList) {
    String tempPath = path.join(outPath, folder);
    if (await Directory(tempPath).exists()) {
      folderDeletionFutures.add(
        Directory(tempPath).delete(recursive: true).catchError((e) {
          debugPrint('删除文件夹失败: $e，如有需要请手动删除。');
          throw 'tempPath ${tr(AppI10n.dialogDeleteFailed)} $e';
        }),
      );
    }
  }
  folderDeletionFutures.add(
    File(path.join(outPath, 'scene.json')).delete().catchError((e) {
      debugPrint('删除scene.json失败: $e');
      throw 'scene.json ${tr(AppI10n.dialogDeleteFailed)} $e';
    }),
  );
  try {
    await Future.wait(folderDeletionFutures);
  } catch (e) {
    return e.toString();
  }
  return null;
}

Future<String?> deleteTransparentPngs(
  List<String> files, {
  List<String> excludeFiles = const [],
}) async {
  List<String> beDeleteList = [];
  // 使用Set提高排除文件查找性能
  Set<String> excludeSet = excludeFiles.toSet();
  List<String> pngs = files
      .where(
        (file) =>
            file.toLowerCase().endsWith('.png') && !excludeSet.contains(file),
      )
      .toList();
  // 使用Future.wait来并行处理所有PNG文件的透明度检测
  List<bool> transparencyResults = await Future.wait(
    pngs.map((png) => hasPngTransparency(png)),
  );
  for (int i = 0; i < pngs.length; i++) {
    if (transparencyResults[i]) {
      beDeleteList.add(pngs[i]);
    }
  }
  String? err = await deleteAllToTrash(filePaths: beDeleteList);
  return err;
}
