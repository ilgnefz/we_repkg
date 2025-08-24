import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_repkg/constants/keys.dart';
import 'package:we_repkg/models/enums.dart';
import 'package:we_repkg/models/wallpaper.dart';
import 'package:we_repkg/provider/setting.dart';
import 'package:we_repkg/utils/storage.dart';

import 'system.dart';

part 'wallpaper.g.dart';

@riverpod
class WallpaperList extends _$WallpaperList {
  @override
  List<WallpaperInfo> build() => [];
  void add(WallpaperInfo value) {
    state = [...state, value];
  }

  void addAll(List<WallpaperInfo> value) {
    state = [...state, ...value];
  }

  void remove(WallpaperInfo value) {
    state = state.where((e) => e != value).toList();
  }

  void clear() => state = [];

  void toggleChecked(WallpaperInfo value) => state = state.map((e) {
    if (e.id == value.id) e.checked = !e.checked;
    return e;
  }).toList();

  void updateChecked(WallpaperInfo value, bool checked) =>
      state = state.map((e) {
        if (e.id == value.id) e.checked = checked;
        return e;
      }).toList();
}

@riverpod
class HoverWallpaper extends _$HoverWallpaper {
  @override
  WallpaperInfo? build() => null;
  void update(WallpaperInfo? value) => state = value;
}

@riverpod
class SelectedWallpaper extends _$SelectedWallpaper {
  @override
  WallpaperInfo? build() => null;
  void update(WallpaperInfo? value) => state = value;
}

// @riverpod
// class CheckedWallpaper extends _$CheckedWallpaper {
//   @override
//   List<WallpaperInfo> build() => [];
//   void add(WallpaperInfo wallpaper) => state = [...state, wallpaper];
//
//   void addAll(List<WallpaperInfo> wallpapers) =>
//       state = [...state, ...wallpapers];
//
//   void remove(WallpaperInfo wallpaper) =>
//       state = state.where((e) => e != wallpaper).toList();
//
//   void clear() => state = [];
// }
@riverpod
List<WallpaperInfo> checkedWallpaperList(Ref ref) =>
    ref.watch(filterWallpaperListProvider).where((e) => e.checked).toList();

@riverpod
List<WallpaperInfo> filterWallpaperList(Ref ref) {
  List<WallpaperInfo> list = ref.watch(wallpaperListProvider);
  String keyWord = ref.watch(searchContentProvider);
  switch (ref.watch(matureShowStateProvider)) {
    case MatureState.hide:
      list = list.where((e) => e.contentRating != 'mature').toList();
      break;
    case MatureState.show:
      break;
    case MatureState.only:
      list = list.where((e) => e.contentRating == 'mature').toList();
  }
  if (keyWord.isNotEmpty) {
    list = list.where((e) => e.title.contains(keyWord)).toList();
  }
  if (!ref.watch(showAllProvider)) {
    list = list.where((e) => e.target.isNotEmpty).toList();
  }
  if (ref.watch(hideSceneProvider)) {
    list = list.where((e) => e.type != 'scene').toList();
  }
  if (ref.watch(hideVideoProvider)) {
    list = list.where((e) => e.type != 'video').toList();
  }
  if (ref.watch(hideWebProvider)) {
    list = list.where((e) => e.type != 'web').toList();
  }
  if (ref.watch(hideAppProvider)) {
    list = list.where((e) => e.type != 'application').toList();
  }
  if (ref.watch(hideUnknownProvider)) {
    list = list.where((e) => e.type != '').toList();
  }
  // if (ref.watch(hideAdultProvider)) {
  //   list = list.where((e) => e.contentRating != 'Mature').toList();
  // }
  switch (ref.watch(wallpaperSortTypeProvider)) {
    case SortType.time:
      String earliestDate = StorageUtil.getString(AppKeys.earliestDate) ?? '';
      // print('最早日期:$earliestDate');
      List<WallpaperInfo> earliestList = [];
      List<WallpaperInfo> otherList = [];
      for (WallpaperInfo wallpaper in list) {
        if (wallpaper.createTime.toString().startsWith(earliestDate)) {
          earliestList.add(wallpaper);
        } else {
          otherList.add(wallpaper);
        }
      }
      earliestList.sort((a, b) => a.createTime.compareTo(b.createTime));
      otherList.sort((a, b) => b.createTime.compareTo(a.createTime));
      list = [...otherList, ...earliestList];
      break;
    case SortType.size:
      list.sort((a, b) => b.size.compareTo(a.size));
      break;
    case SortType.update:
      list.sort((a, b) => b.updateTime.compareTo(a.updateTime));
      break;
  }
  if (ref.watch(sortAscendingProvider)) list = list.reversed.toList();
  return list;
}

@riverpod
class ExtractList extends _$ExtractList {
  @override
  List<WallpaperInfo> build() => [];
  void addAll(List<WallpaperInfo> value) => state = [...value];
  void clear() => state = [];
}

@riverpod
class CurrentIndex extends _$CurrentIndex {
  @override
  int build() => 0;
  void update(int value) => state = value;
}

// @riverpod
// class TotalCount extends _$TotalCount {
//   @override
//   int build() => 0;
//   void update(int index) => state = index;
//   void clear() => state = 0;
// }
// @riverpod
// class CurrentProgress extends _$CurrentProgress {
//   @override
//   double build() => 0;
//
//   void add(double value) {
//     state = state + value;
//   }
//
//   void update(double value) => state = value;
// }
