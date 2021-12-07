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
      required this.totalDuration
      });

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
  String createTime;
  int collectId;
  String collectName;
  String img;
  MyCollectionItem(
      {required this.createTime,
        required this.collectId,
        required this.collectName,
        required this.img,
      });

  factory MyCollectionItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return MyCollectionItem(
      createTime: parsedJson['create_time'],
      collectId: parsedJson['collect_id'],
      collectName: parsedJson['collect_name'],
      img: parsedJson['img'],
    );
  }
}


