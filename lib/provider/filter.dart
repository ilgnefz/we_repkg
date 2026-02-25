import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/models/filter.dart';
import 'package:we_repkg/utils/storage.dart';

part 'filter.g.dart';

@riverpod
class FilterState extends _$FilterState {
  @override
  WallpaperFilter build() => WallpaperFilter(
    showAll: StorageUtil.getBool(AppKeys.showAll),
    hideScene: StorageUtil.getBool(AppKeys.hideScene),
    hideVideo: StorageUtil.getBool(AppKeys.hideVideo),
    hideWeb: StorageUtil.getNullBool(AppKeys.hideWeb) ?? true,
    hideApp: StorageUtil.getNullBool(AppKeys.hideApp) ?? true,
    hideUnknown: StorageUtil.getBool(AppKeys.hideUnknown),
    matureState:
        MatureState.values[StorageUtil.getInt(AppKeys.matureState) ?? 0],
  );

  void updateShowAll(bool showAll) async {
    state = WallpaperFilter(
      showAll: showAll,
      hideScene: showAll ? false : state.hideScene,
      hideVideo: showAll ? false : state.hideVideo,
      hideWeb: showAll ? false : state.hideWeb,
      hideApp: showAll ? false : state.hideApp,
      hideUnknown: showAll ? false : state.hideUnknown,
      matureState: showAll ? MatureState.show : state.matureState,
    );

    await StorageUtil.setBool(AppKeys.showAll, showAll);
    if (showAll) {
      await StorageUtil.setBool(AppKeys.hideScene, false);
      await StorageUtil.setBool(AppKeys.hideVideo, false);
      await StorageUtil.setBool(AppKeys.hideWeb, false);
      await StorageUtil.setBool(AppKeys.hideApp, false);
      await StorageUtil.setBool(AppKeys.hideUnknown, false);
      await StorageUtil.setInt(AppKeys.matureState, 0);
    }
  }

  void updateHideScene(bool hideScene) async {
    state = state.copyWith(
      showAll: state.showAll && !hideScene,
      hideScene: hideScene,
    );
    await StorageUtil.setBool(AppKeys.hideScene, hideScene);
    if (hideScene) {
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }

  void updateHideVideo(bool hideVideo) async {
    state = state.copyWith(
      showAll: state.showAll && !hideVideo,
      hideVideo: hideVideo,
    );
    await StorageUtil.setBool(AppKeys.hideVideo, hideVideo);
    if (hideVideo) {
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }

  void updateHideWeb(bool hideWeb) async {
    state = state.copyWith(
      showAll: state.showAll && !hideWeb,
      hideWeb: hideWeb,
    );
    await StorageUtil.setBool(AppKeys.hideWeb, hideWeb);
    if (hideWeb) {
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }

  void updateHideApp(bool hideApp) async {
    state = state.copyWith(
      showAll: state.showAll && !hideApp,
      hideApp: hideApp,
    );
    await StorageUtil.setBool(AppKeys.hideApp, hideApp);
    if (hideApp) {
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }

  void updateHideUnknown(bool hideUnknown) async {
    state = state.copyWith(
      showAll: state.showAll && !hideUnknown,
      hideUnknown: hideUnknown,
    );
    await StorageUtil.setBool(AppKeys.hideUnknown, hideUnknown);
    if (hideUnknown) {
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }

  void updateMatureState(MatureState matureState) async {
    state = state.copyWith(
      showAll: state.showAll && matureState.isShow,
      matureState: matureState,
    );
    await StorageUtil.setInt(AppKeys.matureState, matureState.index);
    if (!matureState.isShow) {
      await StorageUtil.setBool(AppKeys.showAll, false);
    }
  }
}
