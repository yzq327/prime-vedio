
part of 'video_list_model.dart';

VideoListModel _$VideoListModelFromJson(Map<String, dynamic> json) {
  return VideoListModel(
    json['total'] as int,
    (json['list'] as List)
        ?.map((e) =>
    e == null ? null : VideoInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VideoListModelToJson(VideoListModel instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
    };


VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) {
  return VideoInfo(
    vodId: json['vod_id'] as int,
    vodName: json['vod_name'] as String,
    vodPic: json['vod_pic'] as String,
  );
}

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) =>
    <String, dynamic>{
      'vodId': instance.vodId,
      'vodName': instance.vodName,
      'vodPic': instance.vodPic,
    };
