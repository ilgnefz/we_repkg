import 'enums.dart';

class WallpaperFilter {
  final bool showAll;
  final bool hideScene;
  final bool hideVideo;
  final bool hideWeb;
  final bool hideApp;
  final bool hideUnknown;
  final MatureState matureState;

  WallpaperFilter({
    required this.showAll,
    required this.hideScene,
    required this.hideVideo,
    required this.hideWeb,
    required this.hideApp,
    required this.hideUnknown,
    required this.matureState,
  });

  WallpaperFilter copyWith({
    bool? showAll,
    bool? hideScene,
    bool? hideVideo,
    bool? hideWeb,
    bool? hideApp,
    bool? hideUnknown,
    MatureState? matureState,
  }) {
    return WallpaperFilter(
      showAll: showAll ?? this.showAll,
      hideScene: hideScene ?? this.hideScene,
      hideVideo: hideVideo ?? this.hideVideo,
      hideWeb: hideWeb ?? this.hideWeb,
      hideApp: hideApp ?? this.hideApp,
      hideUnknown: hideUnknown ?? this.hideUnknown,
      matureState: matureState ?? this.matureState,
    );
  }
}
