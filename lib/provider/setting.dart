import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/utils/storage.dart';

part 'setting.g.dart';

@riverpod
class OnlySaveImage extends _$OnlySaveImage {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.onlySaveImage) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.onlySaveImage, value);
  }
}

@riverpod
class ExcludeTexture extends _$ExcludeTexture {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.excludeTexture) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.excludeTexture, value);
  }
}

@riverpod
class UseTitleName extends _$UseTitleName {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.useTitleName) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.useTitleName, value);
  }
}

@riverpod
class SortAscending extends _$SortAscending {
  @override
  bool build() => StorageUtil.getBool(AppKeys.sortAscending);
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.sortAscending, state);
  }
}

@riverpod
class WallpaperSortType extends _$WallpaperSortType {
  @override
  SortType build() =>
      SortType.values[StorageUtil.getInt(AppKeys.sortType) ?? 0];
  void update(SortType value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.sortType, value.index);
  }
}

@riverpod
class ReplaceFile extends _$ReplaceFile {
  @override
  bool build() => StorageUtil.getBool(AppKeys.replaceFile);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.replaceFile, state);
  }
}

@riverpod
class LocalNotificationType extends _$LocalNotificationType {
  @override
  NotificationType build() =>
      NotificationType.values[StorageUtil.getInt(AppKeys.notificationType) ??
          1];
  void update(NotificationType value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.notificationType, value.index);
  }
}

@riverpod
class DeleteTransparency extends _$DeleteTransparency {
  @override
  bool build() => StorageUtil.getBool(AppKeys.deleteTransparency);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.deleteTransparency, state);
  }
}

@riverpod
class UseProjectPath extends _$UseProjectPath {
  @override
  bool build() => StorageUtil.getBool(AppKeys.useProjectFolder);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.useProjectFolder, state);
  }
}

@riverpod
class UseAcfInfo extends _$UseAcfInfo {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.useAcfInfo) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.useAcfInfo, state);
  }
}

@riverpod
class UpdateProjectPath extends _$UpdateProjectPath {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.updateProjectPath) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.updateProjectPath, state);
  }
}

@riverpod
class UpdateAcfPath extends _$UpdateAcfPath {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.updateAcfPath) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.updateAcfPath, state);
  }
}

@riverpod
class MaximizeOpen extends _$MaximizeOpen {
  @override
  bool build() => StorageUtil.getBool(AppKeys.maximizeOpen);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.maximizeOpen, state);
  }
}
