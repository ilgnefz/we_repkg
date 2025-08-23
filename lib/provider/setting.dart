import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/utils/storage.dart';

part 'setting.g.dart';

@riverpod
class ShowAll extends _$ShowAll {
  @override
  bool build() => StorageUtil.getBool(AppKeys.showAll);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.showAll, value);
    if (value) {
      ref.read(hideUnknownProvider.notifier).update(false);
      ref.read(hideSceneProvider.notifier).update(false);
      ref.read(hideVideoProvider.notifier).update(false);
      ref.read(hideWebProvider.notifier).update(false);
      ref.read(hideAppProvider.notifier).update(false);
      ref.read(hideAdultProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.hideUnknown, false);
      await StorageUtil.setBool(AppKeys.hideScene, false);
      await StorageUtil.setBool(AppKeys.hideVideo, false);
      await StorageUtil.setBool(AppKeys.hideWeb, false);
      await StorageUtil.setBool(AppKeys.hideApp, false);
      await StorageUtil.setBool(AppKeys.hideAdult, false);
    }
  }
}

@riverpod
class HideUnknown extends _$HideUnknown {
  @override
  bool build() => StorageUtil.getBool(AppKeys.hideUnknown);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.hideUnknown, value);
    if (value) {
      ref.read(showAllProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}

@riverpod
class HideScene extends _$HideScene {
  @override
  bool build() => StorageUtil.getBool(AppKeys.hideScene);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.hideScene, value);
    if (value) {
      ref.read(showAllProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}


@riverpod
class HideVideo extends _$HideVideo {
  @override
  bool build() => StorageUtil.getBool(AppKeys.hideVideo);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.hideVideo, value);
    if (value) {
      ref.read(showAllProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}

@riverpod
class HideWeb extends _$HideWeb {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.hideWeb) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.hideWeb, value);
    if (value) {
      ref.read(showAllProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}

@riverpod
class HideApp extends _$HideApp {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.hideApp) ?? true;
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.hideApp, value);
    if (value) {
      ref.read(showAllProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}

@riverpod
class HideAdult extends _$HideAdult {
  @override
  bool build() => StorageUtil.getBool(AppKeys.hideAdult);
  void update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.hideAdult, value);
    if (value) {
      ref.read(showAllProvider.notifier).update(false);
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}

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