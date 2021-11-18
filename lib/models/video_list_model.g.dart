// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoListModel _$VideoListModelFromJson(Map<String, dynamic> json) {
  return VideoListModel(
    json['total'] as int,
    (json['list'] as List<dynamic>)
        .map((e) => VideoInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VideoListModelToJson(VideoListModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) {
  return VideoInfo(
    vodId: json['vod_id'] as int,
    vodName: json['vod_name'] as String,
    vodPic: json['vod_pic'] as String,
  );
}

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'vod_id': instance.vodId,
      'vod_name': instance.vodName,
      'vod_pic': instance.vodPic,
    };
