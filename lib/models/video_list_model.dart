import 'package:json_annotation/json_annotation.dart';

part 'video_list_model.g.dart';

@JsonSerializable()
class VideoListModel extends Object {

  @JsonKey(name: 'list')
  List<VideoInfo> list;

  VideoListModel(
      this.list,
  );

  factory VideoListModel.fromJson(Map<String, dynamic> srcJson) => _$VideoListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoListModelToJson(this);
}

@JsonSerializable()
class VideoInfo extends Object {

  @JsonKey(name: 'vod_id')
  int vodId;

  @JsonKey(name: 'vod_name')
  String vodName;

  @JsonKey(name: 'vod_pic')
  String vodPic;


  VideoInfo({
    this.vodId,
    this.vodName,
    this.vodPic,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> srcJson) => _$VideoInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}
