import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/constants/strings.dart';
import 'package:we_repkg/utils/storage.dart';

String getToolPath() {
  String? toolPath = StorageUtil.getString(AppKeys.toolPath);
  if (toolPath == null) {
    String appPath = Platform.resolvedExecutable;
    String folder = path.dirname(appPath);
    toolPath = path.join(folder, 'RePKG.exe');
  }
  return toolPath;
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

Future<bool> hasPngTransparency(String imagePath) async {
  // if (!imagePath.toLowerCase().endsWith('.png')) return false;
  File imageFile = File(imagePath);
  if (!await imageFile.exists()) return false;
  try {
    // 读取并解码图片
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return false;
    // 检查像素透明度
    return _imageHasTransparentPixels(image);
  } catch (e) {
    print('检查图片透明度失败: $e');
    return false;
  }
}

// 检查图片是否包含透明像素
bool _imageHasTransparentPixels(img.Image image) {
  // 如果图片没有透明通道，直接返回false
  if (!image.hasAlpha) return false;
  // 遍历所有像素
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      final alpha = pixel.a;
      if (alpha < 255) {
        return true; // 找到透明/半透明像素
      }
    }
  }
  return false; // 没有透明像素
}

String getAcfPath(String filePath) =>
    path.join(path.dirname(path.dirname(filePath)), AppStrings.acfName);
