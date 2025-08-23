import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:path/path.dart' as path;

String typeText(String type) {
  switch (type) {
    case 'video':
      return tr(AppI10n.homeVideo);
    case 'scene':
      return tr(AppI10n.homeScene);
    case 'web':
      return tr(AppI10n.homeWeb);
    case 'application':
      return tr(AppI10n.homeApplication);
    case '':
      return tr(AppI10n.homeUnknown);
    default:
      return type;
  }
}

String formatSize(int size) {
  if (size < 1024) {
    return '${size}B';
  } else if (size < 1024 * 1024) {
    return '${(size / 1024).toStringAsFixed(2)}KB';
  } else {
    return '${(size / 1024 / 1024).toStringAsFixed(2)}MB';
  }
}

List<String> splitOnFirstColon(String message) {
  int colonIndex = message.indexOf(':');
  if (colonIndex == -1) return ['', message];
  String beforeColon = message.substring(0, colonIndex);
  String afterColon = message.substring(colonIndex + 1);
  return [beforeColon, afterColon];
}

// 写一个重命名文件名的方法，先检测文件是否已存在，存在就在文件名后面加“-1”，如果“-1”也存在，就加“-2”，以此类推
String renameFile(String filePath) {
  String fileName = path.basename(filePath);
  String dirPath = path.dirname(filePath);
  String newFilePath = path.join(dirPath, fileName);
  int index = 1;
  while (FileSystemEntity.typeSync(newFilePath) !=
      FileSystemEntityType.notFound) {
    newFilePath = path.join(
      dirPath,
      '${fileName.split('.')[0]}-$index.${fileName.split('.')[1]}',
    );
    index++;
  }
  return newFilePath;
}
