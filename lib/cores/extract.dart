import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/models/error.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/utils/info.dart';
import 'package:we_repkg/utils/tool.dart';

import 'base.dart';
import 'toast.dart';

Future<void> extractProject(
  WidgetRef ref,
  List<WallpaperInfo> wallpapers,
) async {
  bool useProjectPath = ref.watch(useProjectPathProvider);
  ExtractType extractType = ref.watch(currentExtractTypeProvider);
  if (useProjectPath || extractType.isProject) {
    if (!await checkProjectPath(ref, true)) return;
  } else {
    if (!await checkExportPath(ref, true)) return;
  }
  String? rePKGPath = ref.watch(toolPathProvider);
  if (!await toolExist(rePKGPath)) return showToolNoExistToast();
  List<ErrorInfo> errList = [];
  List<String> skipList = [];
  String outPath = useProjectPath || extractType.isProject
      ? ref.watch(projectPathProvider)!
      : ref.watch(exportPathProvider)!;
  if (!await Directory(outPath).exists()) {
    return projectNoExistToast(outPath);
  }
  changeLoadingText(ref, tr(AppI10n.dialogProcessingWallpaper));
  final cancel = showLoadingView(wallpapers);
  int index = 0;
  final basePath = outPath;
  for (WallpaperInfo wallpaper in wallpapers) {
    ref.read(currentIndexProvider.notifier).update(index);
    if (!wallpaper.target.toLowerCase().endsWith('pkg')) {
      skipList.add(wallpaper.title);
      continue;
    }
    if (ref.watch(useTitleNameProvider)) {
      String title = renameFolder(wallpaper.title);
      outPath = path.join(basePath, title);
    } else {
      outPath = path.join(basePath, wallpaper.id);
    }
    try {
      await Directory(outPath).create();
    } catch (e) {
      debugPrint('创建目录失败: $e');
      errList.add(
        ErrorInfo(
          wallpaper: wallpaper,
          message: '${tr(AppI10n.errorCreatedFolderFailed)} $e',
        ),
      );
      index++;
      continue;
    }
    try {
      String? overwrite = ref.watch(replaceFileProvider) ? '--overwrite' : null;
      final args = [
        'extract',
        '-c',
        ?overwrite,
        '-o',
        outPath,
        wallpaper.target,
      ].cast<String>().toList();
      String fullCommand = '$rePKGPath ${args.join(' ')}';
      debugPrint('执行完整命令: $fullCommand');
      ProcessResult result = await Process.run(
        rePKGPath!,
        args,
        runInShell: true,
      );
      int exitCode = result.exitCode;
      String stdout = result.stdout;
      String stderr = result.stderr;
      debugPrint('标准输出: $stdout');
      debugPrint('标准错误: $stderr');
      if (exitCode != 0) {
        errList.add(
          ErrorInfo(
            wallpaper: wallpaper,
            message: '${tr(AppI10n.errorExtractFailed)} $stderr',
          ),
        );
      }
    } catch (e) {
      debugPrint('提取失败: $e');
      errList.add(
        ErrorInfo(
          wallpaper: wallpaper,
          message: '${tr(AppI10n.errorExtractFailed)} $e',
        ),
      );
    }
    index++;
  }
  cancel.call();
  errList.isNotEmpty ? showErrorView(errList) : showProjectToast(skipList);
}

Future<void> exportCurrentProject(
  WidgetRef ref,
  WallpaperInfo wallpaper,
) async {
  await extractProject(ref, [wallpaper]);
}

// 新增的通用提取方法
Future<void> extractWallpapers(
  WidgetRef ref,
  List<WallpaperInfo> wallpapers,
) async {
  if (!await checkExportPath(ref, true)) return;
  String? rePKGPath = ref.watch(toolPathProvider);
  if (!await toolExist(rePKGPath)) return showToolNoExistToast();
  List<ErrorInfo> errList = [];
  String outPath = ref.watch(exportPathProvider)!;
  Directory outDir = Directory(outPath);
  if (!await outDir.exists()) await outDir.create();
  List<FileSystemEntity> oldFiles = await outDir.list().toList();
  int index = 0;
  changeLoadingText(ref, tr(AppI10n.dialogProcessingWallpaper));
  final cancel = showLoadingView(wallpapers);
  bool needClear = false;
  for (WallpaperInfo wallpaper in wallpapers) {
    ref.read(currentIndexProvider.notifier).update(index);
    (String?, bool) res = await extractBranch(ref, wallpaper.target, outPath);
    String? err = res.$1;
    needClear = res.$2;
    if (err != null) errList.add(ErrorInfo(wallpaper: wallpaper, message: err));
    index++;
  }

  if (needClear) {
    changeLoadingText(ref, tr(AppI10n.dialogProcessingDelete));
    String? err2 = await deleteUselessFiles(ref, outPath, oldFiles);
    if (err2 != null) errList.add(ErrorInfo(wallpaper: null, message: err2));
  }
  cancel.call();
  errList.isNotEmpty ? showErrorView(errList) : showExtractSuccessToast();
}

Future<void> extractCurrent(WidgetRef ref, WallpaperInfo wallpaper) async {
  await extractWallpapers(ref, [wallpaper]);
}

Future<void> extractChecked(WidgetRef ref) async {
  List<WallpaperInfo> wallpapers = ref.watch(checkedWallpaperListProvider);
  ExtractType extractType = ref.watch(currentExtractTypeProvider);
  if (extractType.isWallpaper) {
    await extractWallpapers(ref, wallpapers);
  } else {
    await extractProject(ref, wallpapers);
  }
}

Future<void> extractAll(WidgetRef ref) async {
  List<WallpaperInfo> wallpapers = ref.watch(filterWallpaperListProvider);
  ExtractType extractType = ref.watch(currentExtractTypeProvider);
  if (extractType.isWallpaper) {
    await extractWallpapers(ref, wallpapers);
  } else {
    await extractProject(ref, wallpapers);
  }
}

Future<(String?, bool)> extractBranch(
  WidgetRef ref,
  String target,
  String outPath,
) async {
  if (target.toLowerCase().endsWith('pkg')) {
    return (await extractPKG(ref, target, outPath), true);
  } else if (target.endsWith('.mp4')) {
    return (await extractVideo(ref, target, outPath), false);
  } else if (target.endsWith('customdirectory')) {
    return (await extractImages(ref, target, outPath), false);
  }
  return (null, false);
}

Future<String?> extractPKG(WidgetRef ref, String file, String outPath) async {
  changeLoadingText(ref, tr(AppI10n.dialogProcessingWallpaper));
  String rePKGPath = ref.watch(toolPathProvider)!;
  bool excludeTexture = ref.watch(excludeTextureProvider);
  try {
    String? overwrite = ref.watch(replaceFileProvider) ? '--overwrite' : null;
    List<String> args = [
      'extract',
      '-e',
      'tex',
      '-s',
      ?overwrite,
      '-o',
      outPath,
      file,
    ].cast<String>().toList();
    // 提取项目，移动materials一级目录的文件到外面
    if (excludeTexture) args = ['extract', '-o', outPath, file];
    String fullCommand = '$rePKGPath ${args.join(' ')}';
    debugPrint('执行完整命令: $fullCommand');
    ProcessResult result = await Process.run(rePKGPath, args, runInShell: true);
    int exitCode = result.exitCode; // 退出码
    String stdout = result.stdout; // 标准输出
    String stderr = result.stderr;
    debugPrint('退出代码: $exitCode');
    debugPrint('标准输出: $stdout');
    debugPrint('标准错误: $stderr');
    if (exitCode != 0) {
      return '${tr(AppI10n.errorExtractFailed)} (Exit code: $exitCode)\n$stderr';
    }
  } catch (e) {
    debugPrint('提取失败: $e');
    return '${tr(AppI10n.errorExtractFailed)} $e';
  }
  return null;
}

Future<String?> extractVideo(
  WidgetRef ref,
  String filePath,
  String outPath,
) async {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  try {
    final fileName = filePath.split(Platform.pathSeparator).last;
    final targetPath = renameFile(path.join(outPath, fileName));
    final sourceFile = File(filePath);
    final destinationFile = File(targetPath);
    final totalSize = await sourceFile.length();
    await destinationFile.parent.create(recursive: true);
    // 使用流方式复制文件并显示进度
    // final int chunkSize = 1024 * 1024; // 1MB chunks
    int copiedSize = 0;
    final readStream = sourceFile.openRead();
    final writeStream = destinationFile.openWrite();
    try {
      await readStream
          .listen(
            (List<int> data) async {
              writeStream.add(data);
              copiedSize += data.length;
              String loadingText = tr(
                AppI10n.dialogExtractVideoInfo,
                namedArgs: {
                  "copied": formatSize(copiedSize),
                  "total": formatSize(totalSize),
                },
              );
              changeLoadingText(ref, loadingText);
            },
            onError: (error) {
              throw Exception('读取文件时出错: $error');
            },
            onDone: () async {
              await writeStream.close();
            },
            cancelOnError: true,
          )
          .asFuture<void>();
    } finally {
      await writeStream.close();
    }
    await writeStream.done;
  } catch (e) {
    debugPrint('导出视频失败: $e');
    return '${tr(AppI10n.errorExportVideoFailed)} $e';
  } finally {
    stopwatch.stop();
    double seconds = stopwatch.elapsedMilliseconds / 1000;
    debugPrint('提取视频耗时: $seconds 秒');
  }
  return null;
}

Future<String?> extractImages(
  WidgetRef ref,
  String filePath,
  String outPath,
) async {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  try {
    Directory folder = Directory(filePath);
    List<FileSystemEntity> files = await folder.list().toList();
    String loadingText = '';
    int count = files.length;
    for (var file in files) {
      if (file is File) {
        loadingText = tr(
          AppI10n.dialogExtractImageInfo,
          namedArgs: {'index': '${files.indexOf(file)}', 'count': '$count'},
        );
        changeLoadingText(ref, loadingText);
        String fileName = path.basename(file.path);
        String targetPath = renameFile(path.join(outPath, fileName));
        await file.copy(targetPath);
      }
    }
  } catch (e) {
    debugPrint('导出图片失败: $e');
    return '${tr(AppI10n.errorExportImageFailed)} $e';
  }
  stopwatch.stop();
  double seconds = stopwatch.elapsedMilliseconds / 1000;
  debugPrint('提取图片耗时: $seconds 秒');
  return null;
}

void changeLoadingText(WidgetRef ref, String text) {
  ref.read(loadingTextProvider.notifier).update(text);
}
