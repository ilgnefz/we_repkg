import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/cores/toast.dart';
import 'package:we_repkg/models/acf.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/models/error.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/system.dart';
import 'package:we_repkg/provider/wallpaper.dart';
import 'package:we_repkg/utils/info.dart';
import 'package:we_repkg/utils/parse_acf.dart';
import 'package:we_repkg/utils/storage.dart';

Future<List<String>> getWindowsDisks() async {
  try {
    // 执行wmic命令获取磁盘信息
    final result = await Process.run('wmic', ['logicaldisk', 'get', 'name']);
    // 解析输出（注意不同系统语言可能需要调整分隔符）
    String output = result.stdout.toString();
    List<String> disks = output
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty && line.contains(':'))
        .toList();
    // 移除标题行（第一行通常是"Name"）
    if (disks.isNotEmpty && disks.first == 'Name') disks.removeAt(0);
    return disks;
  } catch (e) {
    debugPrint('获取磁盘失败: $e');
    return [];
  }
}

Future<String?> getWallpaperPath() async {
  final disks = await getWindowsDisks();
  if (disks.isEmpty) return null;
  // 生成所有可能的壁纸路径
  final tempPaths = _generateWallpaperPaths(disks);
  // 查找存在的壁纸路径
  final (wallpaperPath, infoPath) = await _findWallpaperPath(tempPaths);
  // 处理存储逻辑
  await _handleStorageLogic(wallpaperPath, infoPath);
  return wallpaperPath;
}

/// 生成所有可能的壁纸路径
List<String> _generateWallpaperPaths(List<String> disks) {
  final tempPaths = <String>[];
  // 为第一个磁盘（通常是系统盘）添加特殊路径
  tempPaths.add('${disks.first}${AppStrings.systemDiskWallpaperPath}');
  // 为所有磁盘添加基础路径
  for (final disk in disks) {
    tempPaths.add('$disk${AppStrings.baseWallpaperPath}');
  }
  return tempPaths;
}

/// 查找存在的壁纸路径
Future<(String?, String?)> _findWallpaperPath(List<String> tempPaths) async {
  String? wallpaperPath;
  String? infoPath;
  String? emptyPath;
  for (final tempPath in tempPaths) {
    if (await Directory(tempPath).exists()) {
      emptyPath ??= tempPath;
      // 检查目录是否包含文件
      final dir = Directory(tempPath);
      final hasContent = await dir.list().isEmpty == false;
      if (hasContent) {
        wallpaperPath = tempPath;
        infoPath = getAcfPath(tempPath);
        break;
      }
    }
  }
  // 如果没有找到有内容的目录，但有空目录，使用空目录
  wallpaperPath ??= emptyPath;
  return (wallpaperPath, infoPath);
}

/// 处理存储相关的逻辑
Future<void> _handleStorageLogic(
  String? wallpaperPath,
  String? infoPath,
) async {
  if (infoPath != null) {
    await StorageUtil.setString(AppKeys.infoPath, infoPath);
  }
  if (wallpaperPath != null) {
    // 保存首次发现的壁纸路径
    final before = StorageUtil.getString(AppKeys.wallpaperPathBefore);
    if (before == null) {
      await StorageUtil.setString(AppKeys.wallpaperPathBefore, wallpaperPath);
    }
    // 设置项目默认路径
    // final projectPath = projectDefaultPath(wallpaperPath);
    // await StorageUtil.setString(AppKeys.projectPath, projectPath);
  }
}

Future<List<WallpaperInfo>> getAllFile(WidgetRef ref) async {
  String? wallpaperPath = ref.watch(wallpaperPathProvider);
  if (wallpaperPath == null) {
    wallpaperPath = await getWallpaperPath();
    ref.read(wallpaperPathProvider.notifier).update(wallpaperPath);
  }
  CurrentState currentState = ref.read(currentStateProvider.notifier);
  currentState.update(RunState.initial);
  List<WallpaperInfo> wallpapers = [];
  try {
    wallpapers = await getAllWallpaper(ref, wallpaperPath);
    currentState.update(RunState.complete);
  } catch (e) {
    showErrorView([
      ErrorInfo(
        wallpaper: null,
        message: '${tr(AppI10n.errorGetWallpaperFailed)} $e',
      ),
    ]);
  }
  if (wallpapers.isEmpty) currentState.update(RunState.empty);
  return wallpapers;
}

Future<List<AcfInfo>> getWallpaperInfo() async {
  List<AcfInfo> acfInfoList = [];
  String? infoPath = StorageUtil.getString(AppKeys.infoPath);
  if (infoPath == null) return acfInfoList;
  Map<String, dynamic> content = await parseAcf(infoPath);
  if (content.isEmpty) return acfInfoList;
  acfInfoList = convertToAcfInfoList(content); // 转换为AcfInfo对象列表
  return acfInfoList;
}

Future<List<WallpaperInfo>> getAllWallpaper(
  WidgetRef ref,
  String? folderPath,
) async {
  if (folderPath == null) return [];
  List<WallpaperInfo> wallpapers = [];
  Directory dir = Directory(folderPath);
  final (
    dirList,
    acfInfoList,
  ) = await (Future.wait([dir.list().toList(), getWallpaperInfo()])).then(
    (results) =>
        (results[0] as List<FileSystemEntity>, results[1] as List<AcfInfo>),
  );
  DateTime? earliestDate;
  // 创建一个Map以便快速查找AcfInfo
  Map<String, AcfInfo> acfInfoMap = {};
  for (var acfInfo in acfInfoList) {
    acfInfoMap[acfInfo.id] = acfInfo;
  }
  for (FileSystemEntity folder in dirList) {
    if (folder is Directory) {
      String id = path.basename(folder.path);
      File file = File('${folder.path}\\project.json');
      if (await file.exists()) {
        String jsonString = await file.readAsString();
        final jsonMap = json.decode(jsonString);
        String title = jsonMap['title'];
        String? contentRating = jsonMap['contentrating'];
        if (contentRating == null) {
          debugPrint('没有分级: ${folder.path}');
          contentRating = '';
        }
        List<String> tags = List<String>.from(jsonMap['tags'] ?? []);
        String? type = jsonMap['type'];
        if (type == null) {
          debugPrint('没有类型: ${folder.path}');
          type = '';
        }
        String imgName = jsonMap['preview'];
        String previews = '${folder.path}\\$imgName';
        String? target = jsonMap['file'];
        if (target == null) {
          String temp = '${folder.path}\\directories\\customdirectory';
          target = await Directory(temp).exists() ? temp : '';
        } else {
          if (target.endsWith('json')) target = 'scene.pkg';
          if (target == '') debugPrint('空文件：${folder.path}');
          target = target == '' ? '' : '${folder.path}\\$target';
        }
        int size = 0;
        int? updateTime;
        final fileStat = await file.stat();
        DateTime createTime = fileStat.changed;
        if (earliestDate == null || createTime.isBefore(earliestDate)) {
          earliestDate = createTime;
        }
        if (acfInfoMap.containsKey(id)) {
          size = acfInfoMap[id]!.size;
          updateTime = acfInfoMap[id]!.time;
        } else {
          debugPrint('$id 没有获取到信息');
          size = await getSize(target);
          updateTime = (createTime.millisecondsSinceEpoch / 1000).truncate();
        }
        wallpapers.add(
          WallpaperInfo(
            id: id,
            title: title,
            contentRating: contentRating.toLowerCase(),
            tags: tags,
            previews: previews,
            type: type.toLowerCase(),
            updateTime: updateTime,
            createTime: createTime,
            target: target,
            size: size,
            folder: folder.path,
          ),
        );
      }
    }
  }
  if (earliestDate != null) {
    String earliestDateStr = earliestDate.toString().substring(0, 10);
    ref.read(earliestTimeProvider.notifier).update(earliestDateStr);
  }
  return wallpapers;
}

Future<void> refreshWallpaper(WidgetRef ref) async {
  ref.read(wallpaperListProvider.notifier).clear();
  List<WallpaperInfo> wallpapers = await getAllFile(ref);
  ref.read(wallpaperListProvider.notifier).addAll(wallpapers);
}
