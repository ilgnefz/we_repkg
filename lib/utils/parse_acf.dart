import 'dart:io';

import 'package:we_repkg/models/acf.dart';

/// 解析ACF格式文件
///
/// [acfPath] ACF文件路径
/// 返回解析后的Map对象
Future<Map<String, dynamic>> parseAcf(String acfPath) async {
  String content = await File(acfPath).readAsString();
  return _parseAcfContent(content);
}

/// 解析ACF内容
Map<String, dynamic> _parseAcfContent(String content) {
  final result = <String, dynamic>{};
  int i = 0;

  // 跳过文件开头的空白字符
  while (i < content.length &&
      (content[i] == ' ' || content[i] == '\t' || content[i] == '\n')) {
    i++;
  }

  // 解析顶层对象键
  if (i < content.length && content[i] == '"') {
    final topLevelKey = _parseString(content, i);
    i = _skipString(content, i);

    // 跳过空白字符
    while (i < content.length &&
        (content[i] == ' ' || content[i] == '\t' || content[i] == '\n')) {
      i++;
    }

    // 解析顶层对象的值
    if (i < content.length && content[i] == '{') {
      i++; // 跳过 '{'
      final objResult = _parseObject(content, i);
      result[topLevelKey] = objResult.value;
      // i = objResult.endIndex; // 这行可以省略，因为我们已经处理完所有内容
    }
  }

  return result;
}

class ParseResult {
  final dynamic value;
  final int endIndex;

  ParseResult(this.value, this.endIndex);
}

/// 解析对象
ParseResult _parseObject(String content, int startIndex) {
  final map = <String, dynamic>{};
  int i = startIndex;

  while (i < content.length) {
    // 跳过空白字符
    while (i < content.length &&
        (content[i] == ' ' || content[i] == '\t' || content[i] == '\n')) {
      i++;
    }

    // 遇到 '}' 结束当前对象解析
    if (i < content.length && content[i] == '}') {
      return ParseResult(map, i + 1);
    }

    // 解析键
    if (i < content.length && content[i] == '"') {
      final key = _parseString(content, i);
      i = _skipString(content, i);

      // 跳过空白字符
      while (i < content.length &&
          (content[i] == ' ' || content[i] == '\t' || content[i] == '\n')) {
        i++;
      }

      // 解析值
      if (i < content.length) {
        if (content[i] == '"') {
          // 字符串值
          final value = _parseString(content, i);
          map[key] = value;
          i = _skipString(content, i);
        } else if (content[i] == '{') {
          // 对象值
          i++; // 跳过 '{'
          final objResult = _parseObject(content, i);
          map[key] = objResult.value;
          i = objResult.endIndex;
        } else {
          // 跳过其他字符直到找到值
          while (i < content.length &&
              content[i] != '"' &&
              content[i] != '{' &&
              content[i] != '}') {
            i++;
          }
          continue;
        }
      }
    } else {
      // 如果当前字符不是引号，跳过
      i++;
    }
  }

  // 如果正常退出循环而没有遇到'}'，说明文件格式可能有问题
  throw FormatException('Invalid ACF format: missing closing brace');
}

/// 解析字符串
String _parseString(String content, int startIndex) {
  int i = startIndex;
  if (i >= content.length || content[i] != '"') return '';

  i++; // 跳过开始引号
  final start = i;

  // 查找结束引号
  while (i < content.length && content[i] != '"') {
    // 检查是否有足够的字符用于转义
    if (content[i] == '\\' && i + 1 < content.length) {
      i += 2; // 跳过转义字符
    } else {
      i++;
    }
  }

  // 检查是否找到了结束引号
  if (i >= content.length || content[i] != '"') {
    throw FormatException('Invalid string format: missing closing quote');
  }

  return content.substring(start, i);
}

/// 跳过字符串
int _skipString(String content, int startIndex) {
  int i = startIndex;
  if (i >= content.length || content[i] != '"') return startIndex;

  i++; // 跳过开始引号

  // 查找结束引号
  while (i < content.length && content[i] != '"') {
    // 检查是否有足够的字符用于转义
    if (content[i] == '\\' && i + 1 < content.length) {
      i += 2; // 跳过转义字符
    } else {
      i++;
    }
  }

  // 检查是否找到了结束引号
  if (i >= content.length || content[i] != '"') {
    throw FormatException('Invalid string format: missing closing quote');
  }

  return i + 1; // 跳过结束引号
}

/// 将解析后的ACF数据转换为AcfInfo对象列表
List<AcfInfo> convertToAcfInfoList(Map<String, dynamic> parsedData) {
  if (parsedData.isEmpty) return [];
  if (!parsedData.containsKey('AppWorkshop')) return [];
  final List<AcfInfo> result = [];

  // 获取AppWorkshop对象
  final appWorkshop = parsedData['AppWorkshop'] is Map<String, dynamic>
      ? parsedData['AppWorkshop'] as Map<String, dynamic>
      : null;
  if (appWorkshop == null) return [];

  // 处理WorkshopItemsInstalled
  if (appWorkshop.containsKey('WorkshopItemsInstalled') &&
      appWorkshop['WorkshopItemsInstalled'] is Map<String, dynamic>) {
    final workshopItemsInstalled =
        appWorkshop['WorkshopItemsInstalled'] as Map<String, dynamic>;
    workshopItemsInstalled.forEach((id, value) {
      if (value is Map<String, dynamic>) {
        result.add(AcfInfo.fromWorkshopInstalled(id, value));
      }
    });
  }

  // 处理WorkshopItemDetails
  // if (appWorkshop.containsKey('WorkshopItemDetails')) {
  //   final workshopItemDetails =
  //       appWorkshop['WorkshopItemDetails'] as Map<String, dynamic>;
  //   workshopItemDetails.forEach((id, value) {
  //     if (value is Map<String, dynamic>) {
  //       result.add(AcfInfo.fromWorkshopDetails(id, value));
  //     }
  //   });
  // }

  return result;
}
