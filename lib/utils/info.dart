import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

String getToolPath() {
  String appPath = Platform.resolvedExecutable;
  String folder = path.dirname(appPath);
  return path.join(folder, 'RePKG.exe');
}

// String? defaultFont() => Platform.isWindows ? 'Microsoft YaHei' : null;

Future<int> getSize(String filePath) async {
  int size = 0;
  if (filePath.endsWith('customdirectory')) {
    Directory dir = Directory(filePath);
    final entities = await dir.list().toList();
    for (final entity in entities) {
      final currentSize = await getSize(entity.path);
      size += currentSize;
    }
  } else {
    File file = File(filePath);
    size = await file.length();
  }
  return size;
}

bool isImage(String filePath) {
  List<String> imgs = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  String ext = filePath.split('.').last.toLowerCase();
  return imgs.contains(ext);
}

IconData getThemeModeIcon(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return Icons.light_mode_rounded;
    case ThemeMode.dark:
      return Icons.dark_mode_rounded;
    case ThemeMode.system:
      return Icons.brightness_4_rounded;
  }
}

Future<bool> toolExist(String toolPath) async => await File(toolPath).exists();
