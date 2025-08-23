class AcfInfo {
  String id;
  int size;
  int time;

  AcfInfo({required this.id, required this.size, required this.time});

  // 用于创建WorkshopItemsInstalled中的AcfInfo对象
  factory AcfInfo.fromWorkshopInstalled(String id, Map<String, dynamic> json) {
    return AcfInfo(
      id: id,
      size: int.tryParse(json['size'].toString()) ?? 0,
      time: int.tryParse(json['timeupdated'].toString()) ?? 0,
    );
  }

  // 用于创建WorkshopItemDetails中的AcfInfo对象
  factory AcfInfo.fromWorkshopDetails(String id, Map<String, dynamic> json) {
    return AcfInfo(
      id: id,
      size: 0, // WorkshopItemDetails中没有size字段
      time: int.tryParse(json['timeupdated'].toString()) ?? 0,
    );
  }

  factory AcfInfo.fromJson(Map<String, dynamic> json) {
    return AcfInfo(
      id: json['id'].toString(),
      size: int.tryParse(json['size'].toString()) ?? 0,
      time: int.tryParse(json['time'].toString()) ?? 0,
    );
  }

  @override
  String toString() {
    return 'AcfInfo{id: $id, size: $size, time: $time}';
  }
}
