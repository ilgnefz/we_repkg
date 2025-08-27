class WallpaperInfo {
  String id;
  String title;
  String contentRating;
  List<String> tags;
  String previews;
  String type;
  int? updateTime;
  DateTime createTime;
  String target;
  String folder;
  int size;
  bool checked;

  WallpaperInfo({
    required this.id,
    required this.title,
    required this.contentRating,
    required this.tags,
    required this.previews,
    required this.type,
    required this.updateTime,
    required this.createTime,
    required this.target,
    required this.folder,
    required this.size,
    this.checked = false,
  });

  WallpaperInfo copyWith({
    String? id,
    String? title,
    String? contentRating,
    List<String>? tags,
    String? previews,
    String? type,
    int? updateTime,
    DateTime? createTime,
    String? target,
    String? folder,
    int? size,
    bool? checked,
  }) {
    return WallpaperInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      contentRating: contentRating ?? this.contentRating,
      tags: tags ?? this.tags,
      previews: previews ?? this.previews,
      type: type ?? this.type,
      updateTime: updateTime ?? this.updateTime,
      createTime: createTime ?? this.createTime,
      target: target ?? this.target,
      folder: folder ?? this.folder,
      size: size ?? this.size,
      checked: checked ?? this.checked,
    );
  }

  @override
  String toString() {
    return 'WallpaperInfo{id: $id, title: $title, contentRating: $contentRating, tags: $tags, previews: $previews, type: $type, updateTime: $updateTime, createTime: $createTime, target: $target, folder: $folder, size: $size, checked: $checked}\n';
  }
}
