import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/utils/info.dart';
import 'package:we_repkg/utils/storage.dart';

part 'system.g.dart';

@riverpod
class CurrentState extends _$CurrentState {
  @override
  RunState build() => RunState.initial;
  void update(RunState value) => state = value;
}

@riverpod
class WallpaperPath extends _$WallpaperPath {
  @override
  String? build() => StorageUtil.getString(AppKeys.wallpaperPath);
  void update(String? value) async {
    state = value;
    if (state == null) return;
    await StorageUtil.setString(AppKeys.wallpaperPath, value!);
  }
}

@riverpod
class ToolPath extends _$ToolPath {
  @override
  String? build() => getToolPath();
  void update(String? value) => state = value;
}

@riverpod
class ExportPath extends _$ExportPath {
  @override
  String? build() => StorageUtil.getString(AppKeys.exportPath);
  void update(String? value) async {
    state = value;
    await StorageUtil.setString(AppKeys.exportPath, value!);
  }
}

@riverpod
class ToolVersion extends _$ToolVersion {
  @override
  String? build() => StorageUtil.getString(AppKeys.toolVersion);
  void update(String? value) async {
    state = value;
    await StorageUtil.setString(AppKeys.toolVersion, value!);
  }
}

@riverpod
class EarliestTime extends _$EarliestTime {
  @override
  String? build() => null;
  Future<void> update(String? value) async {
    state = value;
    if (state == null) {
      await StorageUtil.remove(AppKeys.earliestDate);
    } else {
      await StorageUtil.setString(AppKeys.earliestDate, state!);
    }
  }
}

@riverpod
class SearchContent extends _$SearchContent {
  @override
  String build() => '';
  void update(String value) => state = value;
}

@riverpod
class CurrentTheme extends _$CurrentTheme {
  @override
  ThemeType build() => ThemeType.values[StorageUtil.getInt(AppKeys.theme) ?? 0];
  void update(ThemeType value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.theme, value.index);
  }
}

@riverpod
class CurrentLanguage extends _$CurrentLanguage {
  @override
  LanguageType? build() => null;
  void update(LanguageType value) => state = value;
}

@riverpod
class LoadingText extends _$LoadingText {
  @override
  String build() => tr(AppI10n.dialogProcessingWallpaper);

  void update(String value) => state = value;
}
