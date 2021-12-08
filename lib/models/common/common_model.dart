class VideoHistoryItem {
  String createTime;
  int vodId;
  String vodPic;
  String vodName;
  String vodEpo;
  int watchedDuration;
  String totalDuration;
  VideoHistoryItem(
      {required this.createTime,
      required this.vodId,
      required this.vodPic,
      required this.vodName,
      required this.vodEpo,
      required this.watchedDuration,
      required this.totalDuration});

  factory VideoHistoryItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return VideoHistoryItem(
      createTime: parsedJson['create_time'],
      vodId: parsedJson['vod_id'],
      vodName: parsedJson['vod_name'],
      vodPic: parsedJson['vod_pic'],
      vodEpo: parsedJson['vod_epo'],
      watchedDuration: parsedJson['watched_duration'],
      totalDuration: parsedJson['total'],
    );
  }
}

class MyCollectionItem {
  int collectId;
  String createTime;
  String collectName;
  String img;
  MyCollectionItem({
    required this.collectId,
    required this.createTime,
    required this.collectName,
    required this.img,
  });

  factory MyCollectionItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return MyCollectionItem(
      collectId: parsedJson['id'],
      createTime: parsedJson['create_time'],
      collectName: parsedJson['collect_name'],
      img: parsedJson['img'],
    );
  }
}

class CollectVideoDetail {
  String createTime;
  int collectId;
  MyCollectionItem? myCollectionItem;
  int vodId;
  String vodPic;
  String vodName;

  CollectVideoDetail({
    required this.createTime,
    required this.collectId,
    required this.vodId,
    required this.vodPic,
    required this.vodName,
  });

  factory CollectVideoDetail.fromJson(Map<dynamic, dynamic> parsedJson) {
    return CollectVideoDetail(
      createTime: parsedJson['create_time'],
      collectId: parsedJson['collect_id'],
      vodId: parsedJson['vod_id'],
      vodPic: parsedJson['vod_pic'],
      vodName: parsedJson['vod_name'],
    );
  }
}
